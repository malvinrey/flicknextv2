import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadName(); // Load the current name when Edit Profile page is opened
  }

  // Load the current name from SharedPreferences
  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? '';
    _nameController.text = name;
  }

  // Save the updated name to SharedPreferences
  Future<void> _saveName() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _nameController.text); // Save the name entered
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.grey[700],
          hoverColor: Colors.grey[800],
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            Navigator.pop(context);  // Go back
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text('Edit Profile'),
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Logo or Avatar Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/logo.png', // Replace with your image
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Edit your profile",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Name Input Field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Save Button (Centered and Styled)
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Save the name and return to profile page
                  await _saveName();
                  Navigator.pushReplacementNamed(context, '/profile'); // Ensures ProfilePage is rebuilt
                },
                child: const Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Button background color
                  foregroundColor: Colors.orange, // Button text color
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
