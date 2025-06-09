import 'dart:io';
import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/providers/places.dart';
import 'package:favourite_places/widgets/image_picker.dart';
import 'package:favourite_places/widgets/location_picker.dart';
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
  File? _selectedImage;

  void _savePlace() {
    final enteredTitle = _textFieldController.text;

    if (enteredTitle.isEmpty || _selectedImage == null) {
      return;
    }

    ref
      .read(placesListProvider.notifier)
      .addPlace(Place(placeName: enteredTitle, image: _selectedImage!));
    Navigator.pop(context);
  }

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
      body: SingleChildScrollView(
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
            ImagePickerItem(
              onPickImage: (image) {
                _selectedImage = image;
              }
            ),
            LocationPickerItem(),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}