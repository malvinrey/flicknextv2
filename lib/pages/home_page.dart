import 'package:flicknext/pages/detailfilm.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/header_main.dart';
import '../widgets/footer_main.dart';
import '../widgets/sidebar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  int _selectedIndex = 0;
  late SideBarAnimatedState _sideBarAnimatedState;

  final List<Map<String, String>> continueWatchingMovies = [
    {
      "title": "Avatar",
      "image": "https://image.tmdb.org/t/p/w500/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg",
      "description": "A paraplegic Marine dispatched to the moon Pandora on a unique mission.",
      "genre": "Action, Adventure, Fantasy",
      "writer": "James Cameron",
      "actors": "Sam Worthington, Zoe Saldana",
      'year': '2023',
      'rating': 'PG-13',
      'duration': '120 min',
      'imdbRating': '7.5',
      'votes': '2500',
    },
    {
      "title": "The Lion King",
      "image": "https://image.tmdb.org/t/p/w500/2bXbqYdUdNVa8VIWXVfclP2ICtT.jpg",
      "description": "A young lion prince flees his kingdom only to learn the true meaning of responsibility.",
      "genre": "Animation, Adventure, Drama",
      "writer": "Irene Mecchi, Jonathan Roberts",
      "actors": "Matthew Broderick, Jeremy Irons",
      'year': '2023',
      'rating': 'PG-13',
      'duration': '120 min',
      'imdbRating': '7.5',
      'votes': '2500',
    },
    {
      "title": "Titanic",
      "image": "https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg",
      "description": "A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.",
      "genre": "Drama, Romance",
      "writer": "James Cameron",
      "actors": "Leonardo DiCaprio, Kate Winslet, Billy Zane",
      'year': '2023',
      'rating': 'PG-13',
      'duration': '120 min',
      'imdbRating': '7.5',
      'votes': '250',
    },
    {
      "title": "Interstellar",
      "image": "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
      "description": "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival by finding a new habitable planet.",
      "genre": "Adventure, Drama, Sci-Fi",
      "writer": "Jonathan Nolan, Christopher Nolan",
      "actors": "Matthew McConaughey, Anne Hathaway, Jessica Chastain",
      'year': '2023',
      'rating': 'PG-13',
      'duration': '120 min',
      'imdbRating': '7.5',
      'votes': '2500',
    },
    {
      "title": "The Dark Knight",
      "image": "https://image.tmdb.org/t/p/w500/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg",
      "description": "When the menace known as The Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.",
      "genre": "Action, Crime, Drama",
      "writer": "Jonathan Nolan, Christopher Nolan",
      "actors": "Christian Bale, Heath Ledger, Aaron Eckhart",
      'year': '2023',
      'rating': 'PG-13',
      'duration': '120 min',
      'imdbRating': '7.5',
      'votes': '2500',
    },
  ];

  final List<Map<String, String>> latestMovies = [
    {
      "title": "Black Panther",
      "image": "https://image.tmdb.org/t/p/w500/uxzzxijgPIY7slzFvMotPv8wjKA.jpg",
      "description": "T'Challa, the king of Wakanda, fights to protect his nation from rival factions.",
      "genre": "Action, Adventure, Sci-Fi",
      "writer": "Ryan Coogler, Joe Robert Cole",
      "actors": "Chadwick Boseman, Michael B. Jordan, Lupita Nyong'o",
      'year': '2023',
      'rating': 'PG-13',
      'duration': '120 min',
      'imdbRating': '7.5',
      'votes': '2500',
    },
    {
      "title": "The Avengers",
      "image": "https://image.tmdb.org/t/p/w500/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg",
      "description": "Earth's mightiest heroes must come together to stop Loki and his army from conquering Earth.",
      "genre": "Action, Adventure, Sci-Fi",
      "writer": "Joss Whedon",
      "actors": "Robert Downey Jr., Chris Evans, Scarlett Johansson",
      'year': '2023',
      'rating': 'PG-13',
      'duration': '120 min',
      'imdbRating': '7.5',
      'votes': '2500',
    },
    {
      "title": "Thor: Ragnarok",
      "image": "https://image.tmdb.org/t/p/w500/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg",
      "description": "Thor must escape the alien planet Sakaar in time to save Asgard from Hela, the Goddess of Death, and stop the prophecy of Ragnarok.",
      "genre": "Action, Adventure, Fantasy",
      "writer": "Eric Pearson, Craig Kyle, Christopher Yost",
      "actors": "Chris Hemsworth, Tom Hiddleston, Cate Blanchett",
      'year': '2023',
      'rating': 'PG-13',
      'duration': '120 min',
      'imdbRating': '7.5',
      'votes': '2500',
    },
    {
      "title": "Iron Man",
      "image": "https://image.tmdb.org/t/p/w500/78lPtwv72eTNqFW9COBYI0dWDJa.jpg",
      "description": "Tony Stark, a wealthy industrialist, is kidnapped and forced to build a devastating weapon. Instead, he builds a suit of armor to escape and begins his journey as Iron Man.",
      "genre": "Action, Adventure, Fantasy",
      "writer": "Mark Fergus, Hawk Ostby, Art Marcum",
      "actors": "Robert Downey Jr., Gwyneth Paltrow, Jeff Bridges",
      'year': '2023',
      'rating': 'PG-13',
      'duration': '120 min',
      'imdbRating': '7.5',
      'votes': '2500',
    },
    {
      "title": "Doctor Strange",
      "image": "https://image.tmdb.org/t/p/w500/uGBVj3bEbCoZbDjjl9wTxcygko1.jpg",
      "description": "After a car accident, a brilliant but arrogant surgeon loses the use of his hands. He seeks a cure and becomes a powerful sorcerer in the battle against mystical threats.",
      "genre": "Action, Adventure, Fantasy",
      "writer": "Jon Spaihts, Scott Derrickson, C. Robert Cargill",
      "actors": "Benedict Cumberbatch, Chiwetel Ejiofor, Rachel McAdams",
      'year': '2023',
      'rating': 'PG-13',
      'duration': '120 min',
      'imdbRating': '7.5',
      'votes': '2500',
    },
    {
      "title": "Joker",
      "image": "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg",
      "description": "Arthur Fleck, a failed comedian with a troubled past, becomes the iconic villain known as the Joker after facing rejection and a life of hardship.",
      "genre": "Crime, Drama, Thriller",
      "writer": "Todd Phillips, Scott Silver",
      "actors": "Joaquin Phoenix, Robert De Niro, Zazie Beetz",
      'year': '2023',
      'rating': 'PG-13',
      'duration': '120 min',
      'imdbRating': '7.5',
      'votes': '2500',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/titanic.mp4')
      ..initialize().then((_) {
        setState(() {});
      }).catchError((error) {
        print("Error loading video: $error");
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
      body: Row(
        children: [
          SideBarAnimated(
            onTap: _onSidebarItemTapped,
            widthSwitch: 700.0,
            mainLogoImage: 'assets/logo.png',
            sidebarItems: [
              SideBarItem(
                iconSelected: Icons.home_rounded,
                iconUnselected: Icons.home_outlined,
                text: 'Home',
                selectedIndex: _selectedIndex,
              ),
              SideBarItem(
                iconSelected: Icons.settings_rounded,
                iconUnselected: Icons.settings_outlined,
                text: 'Settings',
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
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
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 60,
                            ),
                            onPressed: _togglePlayPause,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: SectionTitle(title: "Continue Watching"),
                  ),
                  MovieList(movies: continueWatchingMovies),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SectionTitle(title: "Latest Movies"),
                  ),
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
}

class MovieList extends StatefulWidget {
  final List<Map<String, String>> movies;

  const MovieList({required this.movies});

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<bool> _isHovered = [];

  @override
  void initState() {
    super.initState();
    _isHovered = List.generate(widget.movies.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailFilm(
                      title: movie['title']!,
                      imageUrl: movie['image']!,
                      description: movie['description']!,
                      genre: movie['genre']!,
                      writer: movie['writer']!,
                      actors: movie['actors']!,
                      year: movie['year']!,
                      rating: movie['rating']!,
                      duration: movie['duration']!,
                      imdbRating: double.parse(movie['imdbRating']!),
                      votes: int.parse(movie['votes']!),

                    ),
                  ),
                );
              },
              child: MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _isHovered[index] = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _isHovered[index] = false;
                  });
                },
                child: Column(
                  children: [
                    Transform.scale(
                      scale: _isHovered[index] ? 1.1 : 1.0,
                      child: CachedNetworkImage(
                        imageUrl: movie['image']!,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: 120,
                        height: 150,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      movie['title']!,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
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

  const MovieGrid({required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
