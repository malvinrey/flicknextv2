import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      titleSpacing: 0,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            // Menu Icon
            Icon(Icons.menu, color: Colors.white),
            SizedBox(width: 16),

            // Logo
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                //color: Colors.yellow,
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  '../assets/images/logo.png', // Path ke logo
                  height: 40, // Tinggi logo
                  width: 40, // Lebar logo (opsional, agar proporsional)
                  fit: BoxFit.contain, // Menjaga rasio aspek
                ),
              ),
            ),
            SizedBox(width: 16),

            // Search Field (Selalu Tampil)
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter movie...",
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    hintStyle: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),

            // Sign In and Icon
            Text(
              "Sign In",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(width: 8),
            Icon(Icons.notifications, color: Colors.yellow, size: 24),
          ],
        ),
      ),
    );
  }
}
