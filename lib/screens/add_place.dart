import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/providers/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

//converted to Stateful to use TextEditingController
class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _textFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
  
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
            TextField(
              controller: _textFieldController,
              decoration: InputDecoration(labelText: "Title"),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              )
            ),
            ElevatedButton.icon(
              onPressed: () {
                ref
                  .read(placesListProvider.notifier)
                  .addPlace(Place(placeName: _textFieldController.text));
                Navigator.pop(context);
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