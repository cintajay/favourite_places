import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerItem extends StatefulWidget {
  const ImagePickerItem({super.key});

  @override
  State<ImagePickerItem> createState() => _ImagePickerItemState();
}

class _ImagePickerItemState extends State<ImagePickerItem> {
  File? _selectedImage;

  void _openCamera() async {
      final imagePicker = ImagePicker();
      final image = await imagePicker.pickImage(source: ImageSource.camera);

      if (image == null) {
        return;
      }

      setState(() {
        _selectedImage = File(image.path);
      });
    }

  @override
  Widget build(BuildContext context) {
    return _selectedImage == null
        ? TextButton.icon(
          onPressed: _openCamera,
          icon: const Icon(Icons.camera),
          label: const Text('Take Picture'),
        )
        : Container(height: 250,
        width: double.infinity,
        alignment: Alignment.center, 
        child: Image.file(_selectedImage!)
    );
  }
}
