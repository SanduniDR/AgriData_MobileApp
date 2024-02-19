import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//provides encoders and decoders for converting between JSON and Dart objects.
import 'dart:convert';

import 'HomePage.dart';
import 'RegisterAgriOfficer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> _login() async {
    const String apiUrl =
        'https://bluebird-balanced-drum.ngrok-free.app/user/login'; // Replace 'your_api_url' with your actual API URL
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': username.text,
        'password': password.text,
      }),
    );
    if (!mounted) return;
    if (response.statusCode == 200) {
      // Successful login
      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Failed login
      // Show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid username or password.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void performRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterOfficer()),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "lib/assets/logo.png",
                  width: 150.0,
                  height: 150.0,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: username,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed:
                      _login, // Call the _login method when the button is pressed
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.teal.shade300,
                        height: 10,
                      ),
                    ),
                    const Text("or"),
                    Expanded(
                      child: Divider(
                        color: Colors.teal.shade300,
                        height: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Don\'t have an account? ',
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        performRegistration(context);
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 16, color: Colors.teal),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
