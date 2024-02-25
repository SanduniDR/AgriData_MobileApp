import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../Farms/AddFarms.dart';
import '../Home/HomePage.dart';
import '../AgriOfficer/LoginPage.dart';

class RegisterFarmer extends StatefulWidget {
  const RegisterFarmer({super.key});

  @override
  State<RegisterFarmer> createState() => _RegisterFarmerState();
}

class _RegisterFarmerState extends State<RegisterFarmer> {
  bool showFirstSet = true;
  bool successfullyAddedFarmer = false;
  int userId = 0;

  TextEditingController email = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController middlename = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController nic = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController areaCode = TextEditingController();
  TextEditingController homeName = TextEditingController();
  TextEditingController homeNo = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController town = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController taxFileNo = TextEditingController();
  TextEditingController assignedOfficeId = TextEditingController() ;
  TextEditingController assignedFieldAreaId = TextEditingController() ;


  // TextEditingController assignedOfficeIdController = TextEditingController() ;
  // TextEditingController assignedFieldAreaIdController = TextEditingController() ;
  //
  // int assignedOfficeId = int.parse(assignedOfficeIdController);
  // int assignedFieldAreaId = int.parse(assignedFieldAreaIdController);

  //register farmer as a user
  Future<void> _registerFarmerAsUser() async {
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
        'password': password.text,
        'dob': DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(dob.text)), // Format date as "yyyy-MM-dd"
      }),
    );

    if (!mounted) return;
    if (response.statusCode == 201) {
      //You should first access the `user` object from `responseData`, and then access `user_id` from the `user` object.
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final Map<String, dynamic> user = responseData['user'];
      userId = user['user_id'];

      setState(() {
        showFirstSet = false;
      });

      Fluttertoast.showToast(
        msg: "Registered as a user \n User_id: $userId",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white10,
        textColor: Colors.green,
        fontSize: 16.0,
      );
    } else {
      // print(response.body.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content:
                const Text('Registration as a user failed, Please try again'),
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

  //Add address of the farmer
  Future<void> _addAddress() async {
    const String apiUrl =
        'https://bluebird-balanced-drum.ngrok-free.app/communication/address'; // Replace 'your_api_url' with your actual API URL

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': userId,
        'city': city.text,
        'town': town.text,
        'street': street.text,
        'home_no': homeNo.text,
        'home_name': homeName.text,
      }),
    );
  }

  //Add ContactNo of the farmer
  Future<void> _addContactDetails() async {
    const String apiUrl =
        'https://bluebird-balanced-drum.ngrok-free.app/communication/contacts'; // Replace 'your_api_url' with your actual API URL

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': userId,
        'number': contactNumber.text,
        'area_code': areaCode.text,
      }),
    );
  }

  //add a registered user to farmer table
  Future<void> _addFarmer() async {
    const String apiUrl =
        'https://bluebird-balanced-drum.ngrok-free.app/user/farmer';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': userId,
        'assigned_office_id': int.parse(assignedOfficeId.text),
        'assigned_field_area_id': int.parse(assignedFieldAreaId.text),
        'tax_file_no': taxFileNo.text,
      }),
    );

    if (!mounted) return;
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AddFarms()),
      );

      Fluttertoast.showToast(
        msg: "Successfully registered farmer \n User_id: $userId",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white10,
        textColor: Colors.green,
        fontSize: 16.0,
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content:
                const Text("Registration Failed! \n LogIn again and continue."),
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

  //select data for dob
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
          "Farmer Registration",
          style: TextStyle(fontSize: 30.0),
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
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showFirstSet) ...[
                const Text("Section 1",
                    style: TextStyle(
                        fontSize: 15.0, backgroundColor: Colors.black12)),
                //const SizedBox(height: 20),
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
                      return 'Please enter farmer NIC';
                    }
                    // Regex for NIC validation
                    RegExp regExp = RegExp(r'^[0-9]{9}[vVxX]$');

                    if (!regExp.hasMatch(value)) {
                      // Means if NIC is invalid
                      return 'Please enter a valid NIC';
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
                    String p =
                        "[a-zA-Z0-9+._%-+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
                    RegExp regExp = RegExp(p);

                    if (regExp.hasMatch(value)) {
                      // Means if email is valid
                      return null;
                    }
                    return 'Please enter a valid email';
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: password,
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
                      return 'Please confirm farmer password';
                    }
                    if (value != password.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    _registerFarmerAsUser(); // Call the _registerFarmerAsUser method
                    // _addContactDetails(); // Call the _addContactDetails method
                    // _addAddress(); // Call the _addAddress method
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                const SizedBox(height: 20),
              ] else ...[
                const SizedBox(height: 20),
                const Text("Section 2",
                    style: TextStyle(
                        fontSize: 15.0, backgroundColor: Colors.black12)),
                TextFormField(
                  controller: homeName,
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: "Home Name",
                    prefixIcon: Icon(Icons.home_filled),
                  ),
                ),
                TextFormField(
                  controller: homeNo,
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: "Home No",
                      prefixIcon: Icon(Icons.home_filled),
                      hintText: 'Eg:452/2',
                      hintStyle: TextStyle(color: Colors.black12)),
                ),
                TextFormField(
                  controller: street,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: "Street",
                      prefixIcon: Icon(Icons.home_filled),
                      hintText: 'Eg: 1st lane',
                      hintStyle: TextStyle(color: Colors.black12)),
                ),
                TextFormField(
                  controller: town,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: "Town",
                      prefixIcon: Icon(Icons.home_filled),
                      hintText: 'Eg: Nagoda',
                      hintStyle: TextStyle(color: Colors.black12)),
                ),
                TextFormField(
                  controller: city,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: "City",
                      prefixIcon: Icon(Icons.home_filled),
                      hintText: 'Eg: Kalutara',
                      hintStyle: TextStyle(color: Colors.black12)),
                ),

                const SizedBox(height: 20),
                TextFormField(
                  controller: areaCode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: "Area Code",
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'Eg: +94',
                      hintStyle: TextStyle(color: Colors.black12)),
                ),

                TextFormField(
                  controller: contactNumber,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: "Contact No",
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'Eg:7169***87',
                      hintStyle: TextStyle(color: Colors.black12)),
                ),
                const SizedBox(height: 30),
                // ElevatedButton(
                //   onPressed:
                //   _addContactDetails, // Call the _login method when the button is pressed
                //   child: const Text('Register', style: TextStyle(fontSize: 20.0),),
                // ),

                const Text("Section 3",
                    style: TextStyle(
                        fontSize: 15.0, backgroundColor: Colors.black12)),

                const SizedBox(height: 20),
                TextFormField(
                  controller: assignedOfficeId,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: "Assigned Office Id",
                      prefixIcon: Icon(Icons.home_work_outlined),
                      hintText: 'Eg: if Dodangoda , it is 02',
                      hintStyle: TextStyle(color: Colors.black12)),
                ),
                TextFormField(
                  controller: assignedFieldAreaId,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: "Assigned Field Area Id",
                      prefixIcon: Icon(Icons.home_work_outlined),
                      hintText: 'Eg: if Field xxx , it is 03',
                      hintStyle: TextStyle(color: Colors.black12)),
                ),
                TextFormField(
                  controller: taxFileNo,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: "Tax File No",
                      prefixIcon: Icon(Icons.file_copy),
                      hintText: 'Eg: acretax0001',
                      hintStyle: TextStyle(color: Colors.black12)),
                ),

                const SizedBox(height: 30),
                // ElevatedButton(
                //   onPressed:
                //       _registerFarmerAsUser, // Call the _login method when the button is pressed
                //   child: const Text(
                //     'Next',
                //     style: TextStyle(fontSize: 20.0),
                //   ),
                // ),
                ElevatedButton(
                  onPressed: () {
                    _addContactDetails(); // Call the _addContactDetails method
                    _addAddress(); // Call the _addAddress method
                    _addFarmer();
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                // ElevatedButton(
                //   onPressed:
                //   _registerFarmer, // Call the _login method when the button is pressed
                //   child: const Text('Register', style: TextStyle(fontSize: 20.0),),
                // ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
