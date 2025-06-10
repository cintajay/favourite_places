import 'dart:io';

class Place {
  Place({required this.placeName, required this.image, required this.location});

  final String placeName;
  final File image;
  final PlaceLocation location;
}

class PlaceLocation {
  PlaceLocation({required this.latitude, required this.longitude, required this.address});

  final double? latitude;
  final double? longitude;
  final String address;
}