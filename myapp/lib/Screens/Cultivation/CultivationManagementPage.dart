import 'package:flutter/material.dart';
import 'package:myapp/Screens/Cultivation/LogCultivation.dart';
import 'package:myapp/Screens/Cultivation/SearchCultivation.dart';

import '../Home/HomePage.dart';

class CultivationManagement extends StatefulWidget {
  const CultivationManagement({super.key});

  @override
  State<CultivationManagement> createState() => _CultivationManagementState();
}

class _CultivationManagementState extends State<CultivationManagement> {



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cultivation Manager",
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
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset( "lib/assets/cultivation.jpg",
                fit: BoxFit.cover,width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 60,),
              SizedBox(
                width: 300,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddCultivation()),
                    );
                  },
                  child: const Text(
                    'Add New Cultivation Record',
                    style: TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                ),
              ),const SizedBox(height: 30,),
              SizedBox(
                width: 300,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchCultivationPage()),
                    );
                  },
                  child: const Text(
                    'Search Cultivation Records',
                    style: TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                ),
              ),const SizedBox(height: 30,),
              SizedBox(
                width: 300,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const DeleteFarmer()),
                    // );
                  },
                  child: const Text(
                    'Delete Cultivation Records',
                    style: TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                ),
              ),const SizedBox(height: 30,),
              SizedBox(
                width: 300,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const SearchFarmersPage()),
                    // );
                  },
                  child: const Text(
                    'Update Cultivation Records',
                    style: TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(height: 60,),

            ],
          ),
        ),
      ),
    );
  }
}
