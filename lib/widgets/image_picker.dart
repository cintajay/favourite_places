import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerItem extends StatefulWidget {
  const ImagePickerItem({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

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
      widget.onPickImage(File(image.path));
    }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
          onPressed: _openCamera,
          icon: const Icon(Icons.camera),
          label: const Text('Take Picture'),
        );

    if (_selectedImage != null) {
      content = GestureDetector(
          onTap: _openCamera,
          child: Image.file(
            _selectedImage!, 
            fit: BoxFit.cover,
            width: double.infinity,
        ),
      );
    }

    return Container(
        height: 250,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
        child: content
    );
  }
}
