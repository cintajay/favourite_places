import 'package:flutter/material.dart';

class AddPlaceScreen extends StatelessWidget {
  const AddPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Places")        
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: 20,
          children: [            
            TextField(decoration: InputDecoration(labelText: "Title"),),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}