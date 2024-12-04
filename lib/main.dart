import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/sign_in_screen.dart';
import 'pages/reset_password.dart';
import 'pages/lupa_password.dart';
import 'pages/cobacoba.dart';
import 'pages/video_test.dart';

void main() {
  // Ensure proper initialization for WebView and PathUrlStrategy
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy()); // Enable URL handling for web compatibility
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      title: 'Flicknext',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Set default home page
      routes: {
        '/login': (context) => LoginPage(), // Route for LoginPage
        '/register': (context) => RegisterPage(), // Route for RegisterPage
        '/sign-in': (context) => SignInScreen(), // Route for SignInScreen
        '/reset-password': (context) => ResetPasswordPage(), // Route for ResetPasswordPage
        '/forgot-password': (context) => LupaPasswordPage(), // Route for ForgotPassword
        '/cobacoba': (context) => Cobacoba(), // Route for Cobacoba with WebView
        '/videotest': (context) => VideoTestApp(), // Route for Cobacoba with WebView
      },
    );
  }
}
