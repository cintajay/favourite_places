import 'package:favourite_places/screens/add_place.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void addNew() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddPlaceScreen()),
      );
    }
    return Scaffold (
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(onPressed: addNew, icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Placeholder();
      },),
    );
  }
}