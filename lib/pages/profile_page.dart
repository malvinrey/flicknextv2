import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E), // Latar belakang gelap
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E), // Sama dengan latar belakang
        elevation: 0, // Hilangkan bayangan
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigasi kembali
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Tambahkan fungsi pengaturan
            },
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // Tambahkan fungsi share
            },
          ),
        ],
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
                    'fajhriramadhan',
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

            // Statistik Profil (Ratings, Watchlist, Lists, More)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard('Ratings', '0'),
                  _buildStatCard('Watchlist', '0'),
                  _buildStatCard('Favorites', '0'),
                  _buildStatCard('More', '0'),
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
                    'We’re still working on updating some profile features. To see badges, ratings breakdowns, and polls, please go to the previous version of your profile.',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Bagian Ratings
            _buildSectionHeader('Ratings'),
            _buildEmptySection(
              title: 'No ratings yet',
              buttonText: 'Browse popular movies',
              onPressed: () {
                // Tambahkan fungsi untuk browse film
              },
            ),

            // Bagian Watchlist
            _buildSectionHeader('Watchlist'),
            _buildEmptySection(
              title: 'No Watchlist yet',
              buttonText: 'Create a Watchlist',
              onPressed: () {
                // Tambahkan fungsi untuk membuat watchlist
              },
            ),
          ],
        ),
      ),
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 14),
        ],
      ),
    );
  }

  Widget _buildEmptySection({
    required String title,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFF292B2F),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
          SizedBox(height: 12),
          OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: const Color.fromARGB(255, 214, 139, 27)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              buttonText,
              style: TextStyle(color: const Color.fromARGB(255, 214, 139, 27)),
            ),
          ),
        ],
      ),
    );
  }
}
