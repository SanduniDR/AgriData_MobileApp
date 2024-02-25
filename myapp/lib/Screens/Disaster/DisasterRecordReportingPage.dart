import 'package:flutter/material.dart';
import 'package:myapp/Screens/Disaster/AddDisasterIssues.dart';
import 'package:myapp/Screens/Farms/AddFarms.dart';
import 'package:myapp/Screens/Farms/SearchFarms.dart';

import '../Home/HomePage.dart';

class DisasterRecords extends StatefulWidget {
  const DisasterRecords({super.key});

  @override
  State<DisasterRecords> createState() => _DisasterRecordsState();
}

class _DisasterRecordsState extends State<DisasterRecords> {



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          "Disaster Issues ",
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
              Image.asset( "lib/assets/flood.jpg",
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
                          builder: (context) => const AddDisasterIssues()),
                    );
                  },
                  child: const Text(
                    'Add Records',
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
                    //       builder: (context) => const SearchDisasterIssues()),
                    // );
                  },
                  child: const Text(
                    'Search Records',
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
                    //       builder: (context) => const DeleteDisasterIssues()),
                    // );
                  },
                  child: const Text(
                    'Delete Records',
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
                    //       builder: (context) => const SearchDisasterIssues()),
                    // );
                  },
                  child: const Text(
                    'Update Records',
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
