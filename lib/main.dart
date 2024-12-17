import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Conditional import:
// If we're compiling for the web, use url_strategy_web.dart
// Otherwise, use url_strategy_stub.dart
import 'url_strategy_stub.dart' if (dart.library.html) 'url_strategy_web.dart';

import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/sign_in_screen.dart';
import 'pages/reset_password.dart';
import 'pages/lupa_password.dart';
import 'pages/watchlist_page.dart';

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
        '/': (context) => HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => SignUpScreen(),
        '/reset-password': (context) => ResetPasswordPage(),
        '/forgot-password': (context) => LupaPasswordPage(),
        '/watchlist': (context) => WatchlistPage(),
      },
    );
  }
}
