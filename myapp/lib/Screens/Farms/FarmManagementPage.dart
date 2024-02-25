import 'package:flutter/material.dart';
import 'package:myapp/Screens/Farms/AddFarms.dart';
import 'package:myapp/Screens/Farms/SearchFarms.dart';

import '../Home/HomePage.dart';

class FarmManagement extends StatefulWidget {
  const FarmManagement({super.key});

  @override
  State<FarmManagement> createState() => _FarmManagementState();
}

class _FarmManagementState extends State<FarmManagement> {



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          "Farm Manager",
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
              Image.asset( "lib/assets/farm.jpg",
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
                          builder: (context) => const AddFarms()),
                    );
                  },
                  child: const Text(
                    'Add New Farm',
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
                          builder: (context) => const SearchFarmsPage()),
                    );
                  },
                  child: const Text(
                    'Search Farm',
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
                    'Delete Farm Record',
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
                    //       builder: (context) => const UpdateFarmersPage()),
                    // );
                  },
                  child: const Text(
                    'Update Farm Record',
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
