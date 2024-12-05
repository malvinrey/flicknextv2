import 'package:flutter/material.dart';

// Dummy data class for movies
class Movie {
  final String title;
  final String imageUrl;
  final String releaseYear; // Mengganti watchedStatus menjadi releaseYear

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
  // List of dummy movies with updated data
  final List<Movie> movies = [
    Movie(
      title: "Spider-Man: Homecoming",
      imageUrl:
          "https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg",
      releaseYear: "2017", // Update to year
    ),
    Movie(
      title: "Doctor Strange",
      imageUrl:
          "https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg",
      releaseYear: "2016", // Update to year
    ),
    Movie(
      title: "Captain Marvel",
      imageUrl:
          "https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg",
      releaseYear: "2019", // Update to year
    ),
  ];

  // Method to remove a movie from the list
  void _deleteMovie(int index) {
    setState(() {
      movies.removeAt(index); // Remove movie at the specified index
    });
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
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 4,
            color:
                Color(0xFF161616), // Set the card background color to #161616
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(16.0), // Rounded corners for the card
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  16.0), // Apply the same borderRadius to the content inside the card
              child: Stack(
                children: [
                  Row(
                    children: [
                      Image.network(
                        movie.imageUrl,
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover, // Ensures the image fits properly
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .start, // Ensures the content starts from the top
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .white, // Set text color to white for visibility
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Menampilkan tahun rilis film
                            Text(
                              movie.releaseYear, // Menampilkan tahun
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
                  // Icon trashcan di pojok kanan bawah menggunakan Positioned
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () {
                        // Delete the movie when the trashcan icon is clicked
                        _deleteMovie(index);
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
