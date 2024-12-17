import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    Key? key,
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
  }) : super(key: key);

  @override
  _DetailFilmState createState() => _DetailFilmState();
}

class _DetailFilmState extends State<DetailFilm> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  // Mengecek apakah film sudah ada di dalam watchlist
  Future<void> _checkIfFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteMovies = prefs.getStringList('watchlist');
    if (favoriteMovies != null && favoriteMovies.contains(widget.title)) {
      setState(() {
        isFavorite = true;
      });
    }
  }

  // Menambahkan atau menghapus film dari watchlist
  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteMovies = prefs.getStringList('watchlist') ?? [];

    if (isFavorite) {
      favoriteMovies.remove(widget.title);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${widget.title} removed from favorites!")),
      );
    } else {
      // Menambahkan data film lengkap ke SharedPreferences
      prefs.setString(widget.title, widget.imageUrl);
      prefs.setString('${widget.title}_year', widget.year);
      favoriteMovies.add(widget.title);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${widget.title} added to favorites!")),
      );
    }

    await prefs.setStringList('watchlist', favoriteMovies);
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                            style:
                                TextStyle(fontSize: 16, color: Colors.white70),
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
            Center(
              child: Image.network(
                widget.imageUrl,
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: _toggleFavorite,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: isFavorite ? Colors.grey : Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.description,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
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
            Footer(),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

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
