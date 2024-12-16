import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  final bool isSidebarExpanded;

  const Header({super.key, required this.isSidebarExpanded});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _searchController = TextEditingController();

  // Menampilkan overlay pencarian
  void _showOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 80,
        left: 16,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search for movies...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: _removeOverlay,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  // Menghapus overlay
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Set background to white
      appBar: AppBar(
        backgroundColor: Colors.black,  // Set header to black
        elevation: 0,  // Remove shadow from header
        leading: InkWell(
          splashColor: Colors.grey[700],
          hoverColor: Colors.grey[800],
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            Navigator.pop(context);  // Back navigation
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Header Title',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Logo
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  'assets/images/logo.png',  // Path to logo
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 16),

            // Search Field (Always Visible)
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Enter movie...",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    hintStyle: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),

            // Profile Icon (Using Icon)
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');  // Navigate to profile page
              },
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,  // Profile icon background color
                ),
                child: Icon(
                  Icons.person,  // Profile icon
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            SizedBox(width: 16),

            // Search Icon
            GestureDetector(
              onTap: _showOverlay,
              child: Icon(
                Icons.search,
                color: Colors.black,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeOverlay();  // Remove the overlay when the widget is disposed
    super.dispose();
  }
}
