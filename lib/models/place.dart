import 'dart:io';

import 'package:uuid/uuid.dart';

class Place {
  Place({
    required this.placeName,
    required this.image,
    required this.location,
    String? id
  }) : id = id ?? Uuid().v4(); //when place is loaded from db, id is copied. Otherwise id is created here using pkg

  final String placeName;
  final File image;
  final PlaceLocation location;
  final String id;
}

class PlaceLocation {
  const PlaceLocation({required this.latitude, required this.longitude, required this.address}); //added const here to use const PlaceLocation in MapsScreen

  final double latitude;
  final double longitude;
  final String address;
}