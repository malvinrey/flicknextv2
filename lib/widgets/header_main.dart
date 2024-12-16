import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const Header({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          const Text(
            "FlickNext",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          // Search bar
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 12, bottom: 10),
                  hintText: "Enter movies...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          // Login, Register, and Notification
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.notifications,
                color: Colors.yellow,
                size: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
