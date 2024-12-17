import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Dummy data class for movies
class Movie {
  final String title;
  final String imageUrl;
  final String releaseYear;

  Movie({
    required this.title,
    required this.imageUrl,
    required this.releaseYear,
  });
}

class WatchlistPage extends StatefulWidget {
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    _loadWatchlist();
  }

  // Memuat data film dari SharedPreferences
  Future<void> _loadWatchlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteMovies = prefs.getStringList('watchlist');
    if (favoriteMovies != null) {
      setState(() {
        movies = favoriteMovies.map((title) {
          String imageUrl = prefs.getString(title) ?? '';
          String releaseYear = prefs.getString('${title}_year') ?? 'Unknown';
          return Movie(
            title: title,
            imageUrl: imageUrl,
            releaseYear: releaseYear,
          );
        }).toList();
      });
    }
  }

  // Menghapus film dari watchlist
  Future<void> _removeMovieFromWatchlist(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteMovies = prefs.getStringList('watchlist');
    favoriteMovies?.remove(title);
    await prefs.setStringList('watchlist', favoriteMovies!);
    _loadWatchlist(); // Refresh list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Watchlist",
          style: TextStyle(
            color: Colors.white, // Teks header menjadi putih
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white, // Ikon back menjadi putih
        ),
        elevation: 0, // Menghilangkan bayangan pada app bar
        toolbarHeight: 80, // Menambahkan jarak vertikal pada app bar
      ),
      backgroundColor: Colors.black, // Background of the whole page
      body: movies.isEmpty
          ? Center(
              child: Text(
                "Watchlist anda masih kosong",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 4,
                  color: Color(
                      0xFF161616), // Set the card background color to #161616
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Image.network(
                              movie.imageUrl,
                              width: 100,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    movie.releaseYear,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: IconButton(
                            onPressed: () {
                              _removeMovieFromWatchlist(movie.title);
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
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
