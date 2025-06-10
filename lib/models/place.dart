import 'dart:io';

class Place {
  Place({required this.placeName, required this.image});

  final String placeName;
  final File image;
}

class PlaceLocation {
  PlaceLocation({required this.latitude, required this.longitude});

  final double? latitude;
  final double? longitude;
}