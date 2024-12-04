import 'dart:convert';
import 'package:http/http.dart' as http;

class TMDbService {
  final String apiKey = "43b293104d588c0b1ebaf65d26e701df"; // Ganti dengan API Key Anda
  final String baseUrl = "https://api.themoviedb.org/3";

  // Fungsi untuk mencari film berdasarkan judul
  Future<Map<String, dynamic>> fetchMovie(String query) async {
    final response = await http.get(
      Uri.parse("$baseUrl/search/movie?api_key=$apiKey&query=$query"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        return data['results'][0];
      } else {
        throw Exception("Movie not found");
      }
    } else {
      throw Exception("Failed to fetch movie");
    }
  }
}
