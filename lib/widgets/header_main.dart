// ignore_for_file: use_super_parameters  

import 'package:flutter/material.dart';  

class Header extends StatelessWidget implements PreferredSizeWidget {  
  final Function() onMenuTap;  // Callback to handle sidebar menu toggle  

  const Header({  
    Key? key,  
    required this.onMenuTap,  // Receive the callback function  
  }) : super(key: key);  

  @override  
  Size get preferredSize => const Size.fromHeight(60);  // Fixed height for header  

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
            // Menu Icon to toggle sidebar  
            GestureDetector(  
              onTap: onMenuTap,  // Trigger the callback to toggle sidebar  
              child: const Icon(Icons.menu, color: Colors.white),  
            ),  
            const SizedBox(width: 16),  

            // Logo  
            ClipRRect(  
              borderRadius: BorderRadius.circular(8),  
              child: Container(  
                padding: const EdgeInsets.all(4.0),  
                child: Image.asset(  
                  'assets/images/logo.png',  // Logo image  
                  height: 40,  
                  width: 40,  
                  fit: BoxFit.contain,  
                ),  
              ),  
            ),  
            const SizedBox(width: 16),  

            // Search Field  
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),  
                    hintStyle: const TextStyle(fontSize: 14),  
                  ),  
                  onSubmitted: (text) {  
                    // Handle search action here  
                  },  
                ),  
              ),  
            ),  
            const SizedBox(width: 16),  

            // Login Section  
            GestureDetector(  
              onTap: () {  
                Navigator.pushNamed(context, '/login');  
              },  
              child: const Row(  
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