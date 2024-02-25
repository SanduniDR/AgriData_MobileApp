import 'package:flutter/material.dart';
import 'package:myapp/Screens/Activity/AdvanceSearchPage.dart';
import 'package:myapp/Screens/Activity/BroadcastMessagePage.dart';
import 'package:myapp/Screens/AidDistribution/AddAidDistribution.dart';
import 'package:myapp/Screens/Disaster/CropDiseaseReportingPage.dart';
import 'package:myapp/Screens/Disaster/DisasterHome.dart';
import 'package:myapp/Screens/Disaster/DisasterRecordReportingPage.dart';
import 'package:myapp/Screens/Farms/AddFarms.dart';
import 'package:myapp/Screens/Farmer/SearchFarmer.dart';
import 'package:myapp/Screens/Farms/SearchFarms.dart';

import '../../Widgets/FarmerPieChart.dart';
import '../DashBoard/DashBoard.dart';
import '../AgriOfficer/LoginPage.dart';
import '../Farmer/RegisterFarmer.dart';
import '../Cultivation/LogCultivation.dart';
import '../AgriOfficer/LoginPage.dart';

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

  void performAddLogAidDistribution(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddAidDistributionRecords()),
    );
  }

  void performAddLogDisaster(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DisasterRecords()),
    );
  }

  void performLogCropDiseases(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CropDiseaseRecords()),
    );
  }

  void performBroadcastMessage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  const BroadcastMessage()),
    );
  }
  void performAdvanceSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdvanceSearch()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade200,
        title: const Text("AgriData Home"),
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
                title: const Text('Log Aid Distribution'),
                onTap: () {
                  performAddLogAidDistribution(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.agriculture),
                title: const Text('Log Disaster'),
                onTap: () {
                  performAddLogDisaster(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.agriculture),
                title: const Text('Log CropDiseases'),
                onTap: () {
                  performLogCropDiseases(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.mail),
                title: const Text('Broadcast Messages'),
                onTap: () {
                  performBroadcastMessage(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.mail),
                title: const Text('Advance Search'),
                onTap: () {
                 performAdvanceSearch(context);
                },
              ),
              ListTile(
                //single fixed-height row -ListTile
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "lib/assets/home.jpg",
                    // fit: BoxFit.cover, // This ensures the image fills the available space
                    width: MediaQuery.of(context).size.width, // Adjust width as needed
                    height: MediaQuery.of(context).size.height * 0.4, // Adjust height as needed
                    fit: BoxFit.cover,

                  ),
                   Positioned.fill(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Image.asset(
                              "lib/assets/logo.png",
                              // Replace with your logo asset path
                                width: MediaQuery.of(context).size.width * 0.4, // Adjust width as needed
                                height: MediaQuery.of(context).size.width * 0.3, // Adjust height as needed
                                                      ),
                            ],
                          ),
                          const SizedBox(height: 50.0),

                           Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Text(
                                "You're welcome,\n $firstname!",
                                style: const TextStyle(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),

                          const Text(
                            "Have a Good Day ...",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the desired function screen when the button is pressed
                  // For example:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DashBoard()),
                  );
                },
                child:  Text(
                  'Explore Here >>>',
                  style: TextStyle(fontSize: 30.0, color: Colors.teal.shade400),
                ),
              ),
              const SizedBox(height: 30.0),

              const FarmerPieChart(), // PieChart custom widget
              const SizedBox(height: 30.0),

            ],
          ),
        ),
      ),
    );
  }
}
