import 'dart:convert';
import 'dart:ffi';

import 'package:favourite_places/environment_variables.dart';
import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationPickerItem extends StatefulWidget {
  const LocationPickerItem({super.key});

  @override
  State<LocationPickerItem> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPickerItem> {
  bool _isLoading = false;
  PlaceLocation? _pickedLocation;
  
  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=14&size=600x300&maptype=roadmap&markers=color:red%7C$lat,$lng&key=$API_KEY';
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

  setState(() {
    _isLoading = true;
  });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$API_KEY');
    final response = await http.get(url);
    final resData = jsonDecode(response.body);
    final address = resData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: lat,
        longitude: lng,
      );
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content =
        _pickedLocation != null
            ? Image.network(
              locationImage,
              width: double.infinity,
              fit: BoxFit.cover,
            )
            : Text(
              "No location chosen",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            );

    return Column(
      children: [
        Container(
        height: 150,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
        child: _isLoading ? const CircularProgressIndicator() : content
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(onPressed: _getCurrentLocation, label: Text("Get Current Location"), icon: Icon(Icons.pin_drop,)),
            TextButton.icon(onPressed: () {}, label: Text("Select On Map"), icon: Icon(Icons.map,))
          ],
        )
      ],
    );
  }
}