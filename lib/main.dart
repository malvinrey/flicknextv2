import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Conditional import:
// If we're compiling for the web, use url_strategy_web.dart
// Otherwise, use url_strategy_stub.dart
import 'url_strategy_stub.dart' if (dart.library.html) 'url_strategy_web.dart';

import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/sign_up_screen.dart';
import 'pages/reset_password.dart';
import 'pages/lupa_password.dart';
import 'pages/watchlist_page.dart';
import 'pages/profile_page.dart';  // Tambahkan import untuk ProfilePage
import 'pages/edit_profile_page.dart'; // Import halaman EditProfilePage


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Only set the URL strategy if on web
  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flicknext',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => SignUpScreen(),
        '/reset-password': (context) => ResetPasswordPage(),
        '/forgot-password': (context) => LupaPasswordPage(),
        '/watchlist': (context) => WatchlistPage(), // Rute untuk WatchlistPage
        '/profile': (context) => ProfilePage(), // Rute untuk halaman profil
        '/edit-profile': (context) => EditProfilePage(), // Rute untuk halaman EditProfilePage


      },
    );
  }
}
