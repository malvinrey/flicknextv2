import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import '../widgets/footer_main.dart'; // Footer widget
import '../widgets/header_main.dart'; // Header widget
import 'detailfilm.dart'; // Import halaman DetailFilm
import 'watchlist_page.dart';

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
      "image":
          "https://image.tmdb.org/t/p/w500/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg",
      "description":
          "A paraplegic marine dispatched to the moon Pandora on a unique mission...",
      "genre": "Action, Adventure, Science Fiction",
      "writer": "James Cameron",
      "actors": "Sam Worthington, Zoe Saldana",
      "year": "2009",
      "rating": "PG-13",
      "duration": "162 min",
      "imdbRating": "7.8",
      "votes": "123456"
    },
    {
      "title": "The Lion King",
      "image":
          "https://image.tmdb.org/t/p/w500/2bXbqYdUdNVa8VIWXVfclP2ICtT.jpg",
      "description":
          "Lion prince Simba and his father are targeted by his evil uncle, who wants to ascend the throne himself.",
      "genre": "Animation, Adventure, Drama",
      "writer": "Irene Mecchi, Jonathan Roberts, Linda Woolverton",
      "actors": "Matthew Broderick, Jeremy Irons, James Earl Jones",
      "year": "1994",
      "rating": "G",
      "duration": "88 min",
      "imdbRating": "8.5",
      "votes": "500000"
    },
    {
      "title": "Titanic",
      "image":
          "https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg",
      "description":
          "A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.",
      "genre": "Drama, Romance",
      "writer": "James Cameron",
      "actors": "Leonardo DiCaprio, Kate Winslet, Billy Zane",
      "year": "1997",
      "rating": "PG-13",
      "duration": "195 min",
      "imdbRating": "7.8",
      "votes": "1200000"
    },
    {
      "title": "Interstellar",
      "image":
          "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
      "description":
          "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
      "genre": "Adventure, Drama, Science Fiction",
      "writer": "Jonathan Nolan, Christopher Nolan",
      "actors": "Matthew McConaughey, Anne Hathaway, Jessica Chastain",
      "year": "2014",
      "rating": "PG-13",
      "duration": "169 min",
      "imdbRating": "8.6",
      "votes": "1800000"
    },
    {
      "title": "The Dark Knight",
      "image":
          "https://image.tmdb.org/t/p/w500/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg",
      "description":
          "When the menace known as The Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.",
      "genre": "Action, Crime, Drama",
      "writer": "Jonathan Nolan, Christopher Nolan",
      "actors": "Christian Bale, Heath Ledger, Aaron Eckhart",
      "year": "2008",
      "rating": "PG-13",
      "duration": "152 min",
      "imdbRating": "9.0",
      "votes": "2300000"
    },
  ];

  final List<Map<String, String>> latestMovies = [
    {
      "title": "Black Panther",
      "image":
          "https://image.tmdb.org/t/p/w500/uxzzxijgPIY7slzFvMotPv8wjKA.jpg",
      "description":
          "T'Challa, the king of Wakanda, rises to the throne after his father's death. But when an enemy from his past returns, he must fight to protect his kingdom.",
      "genre": "Action, Adventure, Science Fiction",
      "writer": "Ryan Coogler, Joe Robert Cole",
      "actors": "Chadwick Boseman, Michael B. Jordan, Lupita Nyong'o",
      "year": "2018",
      "rating": "PG-13",
      "duration": "134 min",
      "imdbRating": "7.3",
      "votes": "500000"
    },
    {
      "title": "The Avengers",
      "image": "https://image.tmdb.org/t/p/w500/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg",
      "description":
          "Earth's mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from subjugating Earth.",
      "genre": "Action, Adventure, Science Fiction",
      "writer": "Joss Whedon",
      "actors": "Robert Downey Jr., Chris Evans, Mark Ruffalo",
      "year": "2012",
      "rating": "PG-13",
      "duration": "143 min",
      "imdbRating": "8.0",
      "votes": "1400000"
    },
    {
      "title": "Thor: Ragnarok",
      "image":
          "https://image.tmdb.org/t/p/w500/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg",
      "description":
          "Thor must face the Hulk in a gladiator match and fight for his survival, only to find out that Loki has taken control of Asgard and the universe is in danger.",
      "genre": "Action, Adventure, Comedy",
      "writer": "Eric Pearson, Craig Kyle, Christopher Yost",
      "actors": "Chris Hemsworth, Tom Hiddleston, Cate Blanchett",
      "year": "2017",
      "rating": "PG-13",
      "duration": "130 min",
      "imdbRating": "7.9",
      "votes": "900000"
    },
    {
      "title": "Iron Man",
      "image":
          "https://image.tmdb.org/t/p/w500/78lPtwv72eTNqFW9COBYI0dWDJa.jpg",
      "description":
          "After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil forces.",
      "genre": "Action, Adventure, Science Fiction",
      "writer": "Mark Fergus, Hawk Ostby, Art Marcum",
      "actors": "Robert Downey Jr., Gwyneth Paltrow, Jeff Bridges",
      "year": "2008",
      "rating": "PG-13",
      "duration": "126 min",
      "imdbRating": "7.9",
      "votes": "1200000"
    },
    {
      "title": "Doctor Strange",
      "image":
          "https://image.tmdb.org/t/p/w500/uGBVj3bEbCoZbDjjl9wTxcygko1.jpg",
      "description":
          "Dr. Stephen Strange, a brilliant but arrogant neurosurgeon, must learn the mystic arts to defend the world from dark forces.",
      "genre": "Action, Adventure, Fantasy",
      "writer": "Jon Spaihts, Scott Derrickson, C. Robert Cargill",
      "actors": "Benedict Cumberbatch, Chiwetel Ejiofor, Rachel McAdams",
      "year": "2016",
      "rating": "PG-13",
      "duration": "115 min",
      "imdbRating": "7.5",
      "votes": "800000"
    },
    {
      "title": "Joker",
      "image":
          "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg",
      "description":
          "In Gotham City, a failed comedian becomes disillusioned and turns to a life of crime and chaos, which leads to the rise of the Joker.",
      "genre": "Crime, Drama, Thriller",
      "writer": "Todd Phillips, Scott Silver",
      "actors": "Joaquin Phoenix, Robert De Niro, Zazie Beetz",
      "year": "2019",
      "rating": "R",
      "duration": "122 min",
      "imdbRating": "8.4",
      "votes": "1200000"
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
                title: 'Watchlist',
                icon: const Icon(Icons.favorite,
                    color: Colors.yellow), // Changed to favorite icon
                onTap: (index, _) {
                  // Navigasi menggunakan Navigator.push untuk menuju halaman WatchlistPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WatchlistPage(), // Pastikan ini merujuk ke WatchlistPage yang benar
                    ),
                  );
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
          MovieList(
            movies: continueWatchingMovies,
            onMovieTap: (movie) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailFilm(
                    title: movie['title']!,
                    imageUrl: movie['image']!,
                    description:
                        movie['description'] ?? 'Description not available',
                    genre: movie['genre'] ?? 'Genre not available',
                    writer: movie['writer'] ?? 'Writer not available',
                    actors: movie['actors'] ?? 'Actors not available',
                    year: movie['year'] ?? 'Year not available',
                    rating: movie['rating'] ?? 'Rating not available',
                    duration: movie['duration'] ?? 'Duration not available',
                    imdbRating: double.parse(
                        movie['imdbRating'] ?? '0.0'), // Konversi di sini
                    votes: int.parse(movie['votes'] ?? '0'), // Konversi di sini
                  ),
                ),
              );
            },
          ),
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
  final Function(Map<String, String>) onMovieTap;

  const MovieList({super.key, required this.movies, required this.onMovieTap});

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
              child: GestureDetector(
                onTap: () => onMovieTap(movie), // Navigate to DetailFilm
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
        return GestureDetector(
          onTap: () {
            // Navigasi ke halaman DetailFilm dengan mengirimkan data film
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailFilm(
                  title: movie['title']!,
                  imageUrl: movie['image']!,
                  description:
                      movie['description'] ?? 'Description not available',
                  genre: movie['genre'] ?? 'Genre not available',
                  writer: movie['writer'] ?? 'Writer not available',
                  actors: movie['actors'] ?? 'Actors not available',
                  year: movie['year'] ?? 'Year not available',
                  rating: movie['rating'] ?? 'Rating not available',
                  duration: movie['duration'] ?? 'Duration not available',
                  imdbRating: double.parse(movie['imdbRating'] ?? '0.0'),
                  votes: int.parse(movie['votes'] ?? '0'),
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(movie['image']!),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  movie['title']!,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
