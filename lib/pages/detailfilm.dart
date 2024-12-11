import 'package:flutter/material.dart';
import '../widgets/footer_main.dart';


class DetailFilm extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String genre;
  final String writer;
  final String actors;
  final String year;
  final String rating;
  final String duration;
  final double imdbRating;
  final int votes;

  const DetailFilm({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.genre,
    required this.writer,
    required this.actors,
    required this.year,
    required this.rating,
    required this.duration,
    required this.imdbRating,
    required this.votes,
  });

  @override
  _DetailFilmState createState() => _DetailFilmState();
}

class _DetailFilmState extends State<DetailFilm> {
  bool isFavorite = false; // Status favorit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.grey.shade800],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${widget.year} • ${widget.rating} • ${widget.duration}",
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 24),
                          SizedBox(width: 4),
                          Text(
                            widget.imdbRating.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "/10",
                            style: TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${widget.votes} votes",
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            // Movie Image
            Center(
              child: Image.network(
                widget.imageUrl,
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 16),
            // Add to Favorite Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite; // Ubah status favorit
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isFavorite
                          ? "${widget.title} added to favorites!"
                          : "${widget.title} removed from favorites!"),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, 
                  backgroundColor: isFavorite ? Colors.grey : Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                icon: Icon(
                  Icons.star,
                  color: isFavorite ? Colors.white : Colors.black,
                ),
                label: Text(
                  isFavorite ? "Remove from Favorite" : "Add to Favorite",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Movie Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.description,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            // Movie Details Section (Genre, Writer, Actors)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow("Genre", widget.genre),
                  SizedBox(height: 16),
                  _buildDetailRow("Writers", widget.writer),
                  SizedBox(height: 16),
                  _buildDetailRow("Stars", widget.actors),
                ],
              ),
            ),
            SizedBox(height: 160),
            Footer()
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
    
  }

  // Helper Method for Detail Rows
  Widget _buildDetailRow(String title, String details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          details.replaceAll('•', ' · '),
          style: TextStyle(fontSize: 14, color: Colors.blueAccent),
        ),

        
      ],
    );
  }
  
}
