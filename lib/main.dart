import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/sign_up_screen.dart';
import 'pages/reset_password.dart';
import 'pages/lupa_password.dart';
import 'pages/cobacoba.dart';
import 'pages/video_test.dart';
import 'pages/watchlist_page.dart';
import 'pages/profile_page.dart';  // Tambahkan import untuk ProfilePage


void main() {
  // Pastikan PathUrlStrategy digunakan agar URL bisa berfungsi dengan benar di web
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(
      PathUrlStrategy()); // Enable URL handling for web compatibility
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
      title: 'Flicknext',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Menentukan rute default
      routes: {
        '/': (context) => HomePage(), // Rute untuk halaman utama
        '/login': (context) => LoginPage(),
        '/register': (context) => SignUpScreen(),  // Update this route
        '/reset-password': (context) => ResetPasswordPage(),
        '/forgot-password': (context) => LupaPasswordPage(),
        '/cobacoba': (context) => Cobacoba(),
        '/videotest': (context) => VideoTestApp(),
        '/watchlist': (context) => WatchlistPage(), // Rute untuk WatchlistPage
        '/profile': (context) => ProfilePage(), // Rute untuk halaman profil

      },
    );
  }
}
