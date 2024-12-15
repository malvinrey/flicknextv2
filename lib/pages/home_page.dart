import 'package:flutter/material.dart';  
import 'package:video_player/video_player.dart';  
import 'package:cached_network_image/cached_network_image.dart';  

import '../widgets/header_main.dart';  
import '../widgets/footer_main.dart';  
import '../widgets/sidebar.dart';  

class HomePage extends StatefulWidget {  
  const HomePage({Key? key}) : super(key: key);  

  @override  
  _HomePageState createState() => _HomePageState();  
}  

class _HomePageState extends State<HomePage> {  
  late VideoPlayerController _controller;  
  int _selectedIndex = 0;  
  late SideBarAnimatedState _sideBarAnimatedState;  

  final List<Map<String, String>> continueWatchingMovies = [  
    {"title": "Avatar", "image": "https://image.tmdb.org/t/p/w500/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg"},  
    {"title": "The Lion King", "image": "https://image.tmdb.org/t/p/w500/2bXbqYdUdNVa8VIWXVfclP2ICtT.jpg"},  
    {"title": "Titanic", "image": "https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg"},  
    {"title": "Interstellar", "image": "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg"},  
    {"title": "The Dark Knight", "image": "https://image.tmdb.org/t/p/w500/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg"},  
  ];  

  final List<Map<String, String>> latestMovies = [  
    {"title": "Black Panther", "image": "https://image.tmdb.org/t/p/w500/uxzzxijgPIY7slzFvMotPv8wjKA.jpg"},  
    {"title": "The Avengers", "image": "https://image.tmdb.org/t/p/w500/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg"},  
    {"title": "Thor: Ragnarok", "image": "https://image.tmdb.org/t/p/w500/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg"},  
    {"title": "Iron Man", "image": "https://image.tmdb.org/t/p/w500/78lPtwv72eTNqFW9COBYI0dWDJa.jpg"},  
    {"title": "Doctor Strange", "image": "https://image.tmdb.org/t/p/w500/uGBVj3bEbCoZbDjjl9wTxcygko1.jpg"},  
    {"title": "Joker", "image": "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg"},  
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
    _sideBarAnimatedState = SideBarAnimatedState();  
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

  void _onSidebarItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      backgroundColor: Colors.black,  
      appBar: Header(  
        sideBarAnimatedState: _sideBarAnimatedState,  
      ),  
      body: Stack(  
        children: [  
          SingleChildScrollView(  
            child: Column(  
              crossAxisAlignment: CrossAxisAlignment.start,  
              children: [  
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
                const Padding(  
                  padding: EdgeInsets.symmetric(vertical: 0),  
                  child: SectionTitle(title: "Continue Watching"),  
                ),  

                MovieList(movies: continueWatchingMovies),  

                const Padding(  
                  padding: EdgeInsets.symmetric(vertical: 8.0),  
                  child: SectionTitle(title: "Latest Movies"),  
                ),  
                MovieGrid(movies: latestMovies),  
                const Footer(),  
              ],  
            ),  
          ),  
          SideBarAnimated(  
            onTap: _onSidebarItemTapped,  
            widthSwitch: 0.2,  
            mainLogoImage: 'assets/images/logo.png',  
            sidebarItems: [  
              SideBarItem(  
                iconSelected: Icons.home_rounded,  
                iconUnselected: Icons.home_outlined,  
              ),  
              SideBarItem(  
                iconSelected: Icons.settings_rounded,  
                iconUnselected: Icons.settings_outlined,  
              ),  
            ],  
          ),  
        ],  
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
      height: 180,  
      child: ListView.builder(  
        scrollDirection: Axis.horizontal,  
        itemCount: movies.length,  
        itemBuilder: (context, index) {  
          final movie = movies[index];  
          return Padding(  
            padding: const EdgeInsets.only(right: 12.0),  
            child: Column(  
              mainAxisSize: MainAxisSize.min,  
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
      padding: const EdgeInsets.symmetric(horizontal: 10.0),  
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