import 'dart:async';

import 'package:flutter/material.dart';

import '../AgriOfficer/LoginPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState(){
    super.initState();
    // Simulate a time-consuming operation:Loading...
    Timer(const Duration(seconds: 5), () {
      // After 3 seconds, navigate to the LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.teal.shade100,
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Image.asset(
              "lib/assets/logo.png",
              width: 250.0,
              height: 250.0,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            const Text(
              "Loading...",
            ),
          ],
        ),
      )
    );
  }
}
