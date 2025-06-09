import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(place.image),
        ),
        title: Text(place.placeName,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}