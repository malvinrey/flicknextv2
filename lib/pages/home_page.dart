import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sidebarx/sidebarx.dart';
import '../widgets/footer_main.dart'; // Footer widget
import '../widgets/header_main.dart'; // Header widget

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  int _selectedIndex = 0; // Track the selected sidebar index
  late SidebarXController _sidebarController; // Controller for SidebarX
  bool _isCollapsed = false; // Manages the collapse/expand state of the sidebar

  final List<Map<String, String>> continueWatchingMovies = [
    {
      "title": "Avatar",
      "image": "https://image.tmdb.org/t/p/w500/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg"
    },
  ];

  final List<Map<String, String>> latestMovies = [
    {
      "title": "Black Panther",
      "image": "https://image.tmdb.org/t/p/w500/uxzzxijgPIY7slzFvMotPv8wjKA.jpg"
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/titanic.mp4')
      ..initialize().then((_) {
        setState(() {});
      }).catchError((error) {
        debugPrint("Error loading video: $error");
      });

    _sidebarController = SidebarXController(selectedIndex: _selectedIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  void _toggleSidebar() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          SidebarX(
            controller: _sidebarController,
            theme: SidebarXTheme(
              width: _isCollapsed ? 60 : 200,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
                size: 20,
              ),
              textStyle: const TextStyle(color: Colors.white),
            ),
            items: _items,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(onMenuTap: _toggleSidebar),
                  Container(
                    height: 300,
                    color: Colors.black,
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: VideoPlayer(_controller),
                        ),
                        Center(
                          child: IconButton(
                            icon: Icon(
                              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 60,
                            ),
                            onPressed: _togglePlayPause,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SectionTitle(title: "Continue Watching"),
                  MovieList(movies: continueWatchingMovies),
                  const SectionTitle(title: "Latest Movies"),
                  MovieGrid(movies: latestMovies),
                  Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<SidebarXItem> get _items {
    return [
      SidebarXItem(
        icon: Icons.home_rounded,
        label: 'Home',
        onTap: () {
          setState(() {
            _selectedIndex = 0;
          });
        },
      ),
      SidebarXItem(
        icon: Icons.settings_rounded,
        label: 'Settings',
        onTap: () {
          setState(() {
            _selectedIndex = 1;
          });
        },
      ),
      SidebarXItem(
        icon: Icons.shopping_cart,
        label: 'Cart',
        onTap: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
      ),
    ];
  }
}

class MovieList extends StatelessWidget {
  final List<Map<String, String>> movies;

  const MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: movie['image']!,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: 120,
                  height: 150,
                ),
                const SizedBox(height: 10),
                Text(
                  movie['title']!,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MovieGrid extends StatelessWidget {
  final List<Map<String, String>> movies;

  const MovieGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2 / 3,
      ),
      itemCount: movies.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(movie['image']!),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
