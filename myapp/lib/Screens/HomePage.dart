import 'package:flutter/material.dart';
import 'package:myapp/Screens/AddFarms.dart';
import 'package:myapp/Screens/SearchFarmer.dart';

import 'LoginPage.dart';
import 'RegisterFarmer.dart';
import 'LogCultivation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  void performRegistrationOfFarmer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterFarmer()),
    );
  }

  void performAddFarms(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddFarms()),
    );
  }
  void performAddCultivation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddCultivation()),
    );
  }
  void search(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchFarmersPage()),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade200,
        title: const Text("Home"),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.teal,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "lib/assets/logo.png",
                      // Replace with your logo asset path
                      width: 200, // Adjust width as needed
                      height: 100, // Adjust height as needed
                    ),
                    const SizedBox(width: 10),
                    // const Text(
                    //   'Menu',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 25,
                    //   ),
                    // ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Register Farmer'),
                onTap: () {
                  performRegistrationOfFarmer(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.agriculture),
                title: const Text('Add Farms'),
                onTap: () {
                  performAddFarms(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.agriculture),
                title: const Text('Log Cultivation'),
                onTap: () {
                  performAddCultivation(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.agriculture),
                title: const Text('Aids Management'),
                onTap: () {
                  search(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.agriculture),
                title: const Text('Disaster Management'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.agriculture),
                title: const Text('Log CropDiseases'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.money),
                title: const Text('Log TaxPayments '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.mail),
                title: const Text('Broadcast Messages'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile( //single fixed-height row -ListTile
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => const LoginPage()),
                  );
                  },
              ),

            ],
          ),
        ),
      ),
      body: const Center(
        child:  Column(
          children: [Text('Welcome !',style: TextStyle(fontSize: 30.0),),],
        ),
      ),
    );
  }
}

