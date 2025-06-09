import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationPickerItem extends StatefulWidget {
  const LocationPickerItem({super.key});

  @override
  State<LocationPickerItem> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPickerItem> {
  bool _isLoading = false;

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
    print("locationData=$locationData");

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget noLocation = Text("No location chosen", style: TextStyle(color: Theme.of(context).colorScheme.primary),);

    return Column(
      children: [
        Container(
        height: 150,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
        child: _isLoading ? const CircularProgressIndicator() : noLocation
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