import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Controller untuk input email dan password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Simpan data pengguna lokal
  List<Map<String, String>> users = [
    {'email': 'user@example.com', 'password': '123456'},
  ];

  void signIn() {
    String email = emailController.text.trim(); // Menghapus spasi awal/akhir
    String password = passwordController.text;

    // Cari pengguna yang sesuai
    final Map<String, String>? user =
        users.cast<Map<String, String>?>().firstWhere(
              (user) => user!['email'] == email && user['password'] == password,
              orElse: () => null,
            );

    if (user != null) {
      // Login berhasil
      Navigator.pushNamed(context, '/home');
    } else {
      // Login gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email atau password salah')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.grey[700],
          hoverColor: Colors.grey[800],
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text('Sign In'),
        backgroundColor: Colors.black, // Warna latar belakang hitam
        titleTextStyle: TextStyle(
          color: Colors.white, // Warna teks putih
          fontSize: 20, // Ukuran font teks
          fontWeight: FontWeight.bold, // Menebalkan teks
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menambahkan Logo dan Nama Aplikasi
            Column(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(8), // Rounded corners for logo
                  child: Image.asset(
                    'assets/images/logo.png', // Ganti dengan path logo Anda
                    height: 100, // Atur tinggi logo
                    width: 100, // Atur lebar logo
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16), // Jarak antara logo dan nama aplikasi
                Text(
                  'Flick NEXT', // Ganti dengan nama aplikasi Anda
                  style: TextStyle(
                    fontSize: 24, // Ukuran font nama aplikasi
                    fontWeight: FontWeight.bold, // Menebalkan nama aplikasi
                  ),
                ),
                SizedBox(
                    height: 32), // Jarak antara nama aplikasi dan form login
              ],
            ),

            // Form Login
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true, // Agar password tidak terlihat
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: signIn,
              child: Text('Sign In'),
            ),
            SizedBox(height: 5),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/forgot-password');
              },
              child: Text('Forgot Password?'),
            ),

            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Belum punya akun? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
