import 'package:flutter/material.dart';
import 'package:myapp/Screens/Home/HomePage.dart';
import 'package:myapp/Screens/Farmer/RegisterFarmer.dart';
import 'package:myapp/Screens/Farmer/SearchFarmer.dart';

class FarmerManagement extends StatefulWidget {
  const FarmerManagement({super.key});

  @override
  State<FarmerManagement> createState() => _FarmerManagementState();
}

class _FarmerManagementState extends State<FarmerManagement> {




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          "Farmer Manager",
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
              Image.asset( "lib/assets/farmer.jpg",
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
                          builder: (context) => const RegisterFarmer()),
                    );
                  },
                  child: const Text(
                    'Register New Farmer',
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
                          builder: (context) => const SearchFarmersPage()),
                    );
                  },
                  child: const Text(
                    'Search Farmer',
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
                    'Delete Farmer Record',
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
                    'Update Farmer Record',
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
