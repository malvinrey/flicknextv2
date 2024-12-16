import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import '../widgets/footer_main.dart'; // Footer widget
import '../widgets/header_main.dart'; // Header widget

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  final PageController _pageController = PageController();
  final SideMenuController _sideMenuController = SideMenuController();
  bool _isCollapsed = true; // Track sidebar collapsed state

  final List<Map<String, String>> continueWatchingMovies = [
    {
      "title": "Avatar",
      "image": "https://image.tmdb.org/t/p/w500/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg"
    },
    {
      "title": "The Lion King",
      "image": "https://image.tmdb.org/t/p/w500/2bXbqYdUdNVa8VIWXVfclP2ICtT.jpg"
    },
    {
      "title": "Titanic",
      "image": "https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg"
    },
    {
      "title": "Interstellar",
      "image": "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg"
    },
    {
      "title": "The Dark Knight",
      "image": "https://image.tmdb.org/t/p/w500/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg"
    },
  ];

  final List<Map<String, String>> latestMovies = [
    {
      "title": "Black Panther",
      "image": "https://image.tmdb.org/t/p/w500/uxzzxijgPIY7slzFvMotPv8wjKA.jpg"
    },
    {
      "title": "The Avengers",
      "image": "https://image.tmdb.org/t/p/w500/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg"
    },
    {
      "title": "Thor: Ragnarok",
      "image": "https://image.tmdb.org/t/p/w500/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg"
    },
    {
      "title": "Iron Man",
      "image": "https://image.tmdb.org/t/p/w500/78lPtwv72eTNqFW9COBYI0dWDJa.jpg"
    },
    {
      "title": "Doctor Strange",
      "image": "https://image.tmdb.org/t/p/w500/uGBVj3bEbCoZbDjjl9wTxcygko1.jpg"
    },
    {
      "title": "Joker",
      "image": "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg"
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

    _sideMenuController.addListener((index) {
      _pageController.jumpToPage(index);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _sideMenuController.dispose();
    _pageController.dispose();
    super.dispose();
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
          SideMenu(
            controller: _sideMenuController,
            style: SideMenuStyle(
              backgroundColor: Colors.grey[900],
              itemBorderRadius: BorderRadius.circular(8),
              compactSideMenuWidth: 65, // Lebar sidebar ketika collapse
              openSideMenuWidth: 150, // Lebar sidebar ketika expand
              displayMode: _isCollapsed
                  ? SideMenuDisplayMode.compact
                  : SideMenuDisplayMode.open,
              selectedColor: Colors.white,
              unselectedTitleTextStyle: const TextStyle(color: Colors.white70),
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.yellow,
              unselectedIconColor: Colors.white70,
            ),
            items: [
              SideMenuItem(
                title: 'Home',
                icon: const Icon(Icons.home, color: Colors.yellow),
                onTap: (index, _) {
                  _sideMenuController.changePage(index);
                },
              ),
              SideMenuItem(
                title: 'Settings',
                icon: const Icon(Icons.settings, color: Colors.yellow),
                onTap: (index, _) {
                  _sideMenuController.changePage(index);
                },
              ),
              SideMenuItem(
                title: _isCollapsed ? 'Expand Sidebar' : 'Collapse',
                icon: Icon(
                  _isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                  color: Colors.yellow,
                ),
                onTap: (index, _) {
                  _toggleSidebar();
                },
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Header(
                    isSidebarExpanded:
                        !_isCollapsed), // Header menerima status sidebar
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: [
                      _homePageContent(),
                      const Center(
                          child: Text('Settings Page',
                              style: TextStyle(color: Colors.white))),
                      const Center(
                          child: Text('Cart Page',
                              style: TextStyle(color: Colors.white))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _homePageContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 16 / 9, // Maintain video player ratio
              child: _controller.value.isInitialized
                  ? Stack(
                      children: [
                        VideoPlayer(_controller),
                        Center(
                          child: IconButton(
                            icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 60,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  _controller.play();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
          const SectionTitle(title: "Continue Watching"),
          MovieList(movies: continueWatchingMovies),
          const SectionTitle(title: "Latest Movies"),
          MovieGrid(movies: latestMovies),
          Footer(),
        ],
      ),
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

class MovieList extends StatelessWidget {
  final List<Map<String, String>> movies;

  const MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ClipRect(
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: movie['image']!,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                    width: 120,
                    height: 140,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie['title']!,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
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
