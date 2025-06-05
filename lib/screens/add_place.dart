import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/providers/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerWidget {
  const AddPlaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              onPressed: () {
                ref
                  .read(placesListProvider.notifier)
                  .addPlace(Place(placeName: "new Place"));
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}