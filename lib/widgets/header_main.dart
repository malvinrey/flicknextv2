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

  void _showOverlay() {
    // Hapus overlay jika sudah ada
    _removeOverlay();

    // Buat OverlayEntry baru
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 50, // Jarak dari atas header
          left: 20,
          right: 20,
          child: Material(
            elevation: 8,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      autofocus: true, // Fokus otomatis saat overlay muncul
                      decoration: const InputDecoration(
                        hintText: "Search for movies...",
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        _removeOverlay(); // Tutup overlay setelah submit
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: _removeOverlay, // Tutup overlay ketika ditekan
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // Menampilkan overlay
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        color: Colors.black,
        child: widget.isSidebarExpanded // Jika sidebar expand
            ? const Center(
                child: Text(
                  "FlickNext",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "FlickNext",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: _showOverlay,
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
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
      ),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }
}
