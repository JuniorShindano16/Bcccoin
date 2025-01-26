import 'package:flutter/material.dart';
import 'dart:async'; // Pour utiliser Timer
import 'package:bcccoin/views/auth/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Délai de 5 secondes avant de naviguer vers LoginScreen
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Couleur de fond du splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/CBC.png', // Remplacez par le chemin de votre image
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            // Text(
            //   'Congolese Bitcoin',
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.green.shade700,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}