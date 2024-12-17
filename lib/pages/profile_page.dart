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
          backgroundColor: Color(0xFF1C1C1E),  // Dark background
          appBar: AppBar(
            backgroundColor: Colors.black,  // Header is black
            elevation: 0,  // Remove shadow from header
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);  // Go back
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top section: Profile photo, name, and edit button
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
                        userData['name']!,  // Display name from SharedPreferences
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
                          backgroundColor: const Color.fromARGB(255, 214, 139, 27), // Button background color
                          foregroundColor: Colors.black, // Button text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Rounded button shape
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit-profile');  // Navigate to edit profile
                        },
                        child: Text('Edit profile'),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Statistics section (Favorites, Lists, etc.)
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

                // Message Information
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

  // Function to get user data from SharedPreferences
  Future<Map<String, String>> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? 'Unknown';  // Get the saved name
    String email = prefs.getString('email') ?? 'Unknown';
    String password = prefs.getString('password') ?? 'Unknown';

    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
