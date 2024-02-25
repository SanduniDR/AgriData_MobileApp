import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:myapp/Screens/AgriOfficer/LoginPage.dart';

//provides encoders and decoders for converting between JSON and Dart objects.
import 'dart:convert';

import '../Home/HomePage.dart';

class RegisterOfficer extends StatefulWidget {
  const RegisterOfficer({super.key});

  @override
  State<RegisterOfficer> createState() => _RegisterOfficer();
}


class _RegisterOfficer extends State<RegisterOfficer> {
    //final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController middlename = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController nic = TextEditingController();
  TextEditingController passwordc = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  TextEditingController dob = TextEditingController();
  int role = 4;

  Future<void> _registerOfficer() async {
    const String apiUrl =
        'https://bluebird-balanced-drum.ngrok-free.app/user/register'; // Replace 'your_api_url' with your actual API URL

    

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email.text,
        'first_name': firstname.text,
        'middle_name': firstname.text,
        'last_name': firstname.text,
        'nic': nic.text,
        'password': passwordc.text,
        'dob': DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(dob.text)), // Format date as "yyyy-MM-dd"
        'role': role,
      }),
    );
    if (!mounted) return;
    if (response.statusCode == 201) {
      // Successful login
      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      Fluttertoast.showToast(
        msg: "Registration Success",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.transparent,
        textColor: Colors.green,
        fontSize: 16.0,
      );
    } else {
      // Failed login
      // Show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Registration Failed'),
            content: const Text('Registration Failed, Please try again'),
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


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dob.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Agri Field Officer Registration",
          style: TextStyle(fontSize: 30.0),
        ),
        backgroundColor: Colors.teal.shade200,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: firstname,
                decoration: const InputDecoration(
                  labelText: "First Name",
                  prefixIcon: Icon(Icons.person),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: middlename,
                decoration: const InputDecoration(
                  labelText: "Middle Name",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: lastname,
                decoration: const InputDecoration(
                  labelText: "Last Name",
                  prefixIcon: Icon(Icons.person),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nic,
                decoration: const InputDecoration(
                  labelText: "NIC",
                  prefixIcon: Icon(Icons.credit_card),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your NIC';
                  }
                  // Regex for NIC validation
                  RegExp regExp = RegExp(r'^[0-9]{9}[vVxX]$');

                  if (!regExp.hasMatch(value)) { // Means if NIC is invalid
                    return 'Please enter a valid NIC';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  // Regex for email validation
                  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
                  RegExp regExp = RegExp(p);

                  if (regExp.hasMatch(value)) { // Means if email is valid
                    return null;
                  }
                  return 'Please enter a valid email';
                },
              ),

              const SizedBox(height: 20),
              TextFormField(
                controller: passwordc,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.password),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: confirmpassword,
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon: Icon(Icons.password),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != passwordc.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                controller: dob,
                decoration: InputDecoration(
                  labelText: "DOB",
                  prefixIcon: const Icon(Icons.calendar_today),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.edit_calendar_rounded),
                    onPressed: () => _selectDate(context),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    _registerOfficer, // Call the _login method when the button is pressed
                child: const Text('Register'),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                child: Image.asset(
                  "lib/assets/logo.png",
                  width: 200.0,
                  height: 100.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
