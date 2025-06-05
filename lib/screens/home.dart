import 'package:favourite_places/providers/places.dart';
import 'package:favourite_places/screens/add_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesList = ref.watch(placesListProvider);
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
      body: ListView.builder(
        itemCount: placesList.length,
        itemBuilder: (context, index) {
          return Text(placesList[index].placeName);
        },
      )
    );
  }
}