import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final userData = snapshot.data as Map<String, String>;

        return Scaffold(
          backgroundColor: Color(0xFF1C1C1E),  // Latar belakang gelap
          appBar: AppBar(
            backgroundColor: Colors.black,  // Set header ke hitam
            elevation: 0,  // Hilangkan bayangan pada header
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);  // Navigasi kembali
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian atas: Foto profil, nama, dan tombol edit
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[700],
                        child: Icon(Icons.person, size: 40, color: Colors.white),
                      ),
                      SizedBox(height: 12),
                      Text(
                        userData['name']!,  // Menampilkan nama yang didapat dari SharedPreferences
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Joined Dec 2024',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 214, 139, 27), // Warna latar belakang tombol
                          foregroundColor: Colors.black, // Warna teks tombol
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Bentuk tombol
                          ),
                        ),
                        onPressed: () {
                          // Tambahkan fungsi edit profil
                        },
                        child: Text('Edit profile'),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Statistik Profil (Favorites, Lists, Other, etc.)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatCard('Favorites', '0'),
                      _buildStatCard('Lists', '0'),
                      _buildStatCard('Other', '0'),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Informasi Pesan
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF292B2F),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to your new profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'We’re still working on updating some profile features. Some statistics and previous features will be available soon.',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // Fungsi untuk mengambil data pengguna dari SharedPreferences
  Future<Map<String, String>> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? 'Unknown';
    String email = prefs.getString('email') ?? 'Unknown';
    String password = prefs.getString('password') ?? 'Unknown';

    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
