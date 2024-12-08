import 'package:flutter/material.dart';
import 'sidebar.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  final SideBarAnimatedState sideBarAnimatedState;

  const Header({
    Key? key,
    required this.sideBarAnimatedState,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
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
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.sideBarAnimatedState.toggleVisibility();
                });
              },
              child: Icon(Icons.menu, color: Colors.white),
            ),
            SizedBox(width: 16),

            // Logo
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  '../assets/images/logo.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
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

            GestureDetector(
              onTap: () {
                // Navigate to LoginPage using named route
                Navigator.pushNamed(context, '/login');
              },
              child: Row(
                children: [
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.notifications, color: Colors.yellow, size: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}