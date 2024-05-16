import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String locationMessage = "Current location of the User";
  late String lat;
  late String long;

  // Getting current location of the User
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission are permanently denied');
    }
    return await Geolocator.getCurrentPosition();
  }

  // Listen to location updates
  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();

      setState(() {
        locationMessage = 'Latitude: $lat, Longitude: $long';
      });
    });
  }

  // Open the current location in Google Map
  Future<void> _openMap(String lat, String long) async {
    try {
      String googleURL =
          'https://www.google.com/maps/search/?api=1&query=$lat,$long';
      if (await canLaunchUrlString(googleURL)) {
        await launchUrlString(googleURL);
      } else {
        throw 'Could not launch $googleURL';
      }
    } catch (e) {
      // Handle the exception (e.g., log it or show an error message)
      print('Error launching map: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Location', style: TextStyle(fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.blue, // Custom app bar color
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Handle back button press
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              locationMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Text(
              'Select an option:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle current location button press
                _getCurrentLocation().then((value) {
                  lat = '${value.latitude}';
                  long = '${value.longitude}';
                  setState(() {
                    locationMessage = 'Latitude: $lat, Longitude: $long';
                  });
                });
                _liveLocation();
              },
              child: Text('Current Location'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Custom button color
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Handle choose on map button press
                _openMap(lat, long);
              },
              child: Text('Choose on Map'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Custom button color
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 30),
            // Add other creative elements here:
            Icon(Icons.location_on,
                size: 50, color: Colors.red), // Location icon
            Text(
              'Explore nearby places!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
