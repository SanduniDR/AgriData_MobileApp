import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'
    as http; // Import http package for making HTTP requests
import 'package:flutter/material.dart';
import '../AgriOfficer/LoginPage.dart';
import '../AgriOfficer/LoginPage.dart';
import '../AgriOfficer/LoginPage.dart';
import '../AgriOfficer/LoginPage.dart';
import '../AgriOfficer/LoginPage.dart';
import '../Home/HomePage.dart';


class BroadcastMessage extends StatefulWidget {
  const BroadcastMessage({super.key});

  @override
  State<BroadcastMessage> createState() => _BroadcastMessageState();
}

class _BroadcastMessageState extends State<BroadcastMessage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController toEmailsController = TextEditingController();
  TextEditingController messageSubjectController = TextEditingController();
  TextEditingController messageBodyController = TextEditingController();
  late String fromSender;
  List<dynamic> searchResults = [];
  int selectRole = 5;
  // late String fromEmail;


  Future<void> _getFarmerEmails() async {
    String apiUrl =
        'https://bluebird-balanced-drum.ngrok-free.app/user/officer/$userid/farmer';

    // GET request to the login API
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {

      List<dynamic> data = jsonDecode(response.body)['farmers'];
      List<String> emailList = data.map<String>((item) => item['email'].toString()).toList();
      // Map<String, dynamic> emailMap = {
      //   'receivers': emailList,
      // };
      String jsonString = jsonEncode(emailList);

      setState(() {
        toEmailsController.text = jsonString;
      });
    } else {
    }
  }


  Future<void> _sendEmails() async {
    String apiUrl =
        'https://bluebird-balanced-drum.ngrok-free.app/communication/send';

    // GET request to the login API
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'message': messageBodyController.text,
        'receivers': toEmailsController.text,
        'subject': messageSubjectController.text,
      }),
    );

    if (response.statusCode == 200) {

      Fluttertoast.showToast(
        msg: "Mails Sent Success",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.transparent,
        textColor: Colors.green,
        fontSize: 16.0,
      );
    } else {
      print(response.body.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "System Message Broadcast Service",
          style: TextStyle(fontSize: 25.0),
        ),
        backgroundColor: Colors.teal.shade200,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomePage()),
            );          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text("Agriculture Officer Name:"),
                Text(
                  "\n$firstname\t$lastname",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),                const SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 200.0, // Adjust the width as needed
                    height: 40.0, // Adjust the height as needed
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _getFarmerEmails();
                      },

                      icon: const Icon(Icons.people), // Add your desired icon
                      label: const Text('All Farmers Emails',
                          style: TextStyle(
                              fontSize: 14)), // Adjust the font size as needed
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: toEmailsController,
                  decoration: const InputDecoration(
                      labelText: 'To Emails List',
                      prefixIcon: Icon(Icons.mail_outline)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter recipient emails';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: messageSubjectController,
                  decoration: const InputDecoration(
                      labelText: 'Message Subject',
                      prefixIcon: Icon(Icons.subject)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: messageBodyController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Message Body',
                    hintText: 'Enter your message here...',
                    border: OutlineInputBorder(),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a message';
                    }
                    return null;
                  },
                  maxLines: null, // This allows for unlimited lines of text
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {_sendEmails();},
                  child: const Text('Send Message'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
