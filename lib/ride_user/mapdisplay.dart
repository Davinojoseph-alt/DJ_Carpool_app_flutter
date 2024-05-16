import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class SelectLocationPage extends StatefulWidget {
  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center:
                    LatLng(37.4219983, -122.084), // Set to Mountain View, CA
                zoom: 13.0, // Initial zoom level
                onTap: _handleMapTap, // Callback for map tap event
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'], // Subdomains for tile fetching
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Selected Location',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Callback function to handle map tap event
  void _handleMapTap(TapPosition tapPosition, LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String address = placemark.name ?? '';
        address += placemark.subThoroughfare != null
            ? ', ${placemark.subThoroughfare}'
            : '';
        address +=
            placemark.thoroughfare != null ? ', ${placemark.thoroughfare}' : '';
        address +=
            placemark.subLocality != null ? ', ${placemark.subLocality}' : '';
        address += placemark.locality != null ? ', ${placemark.locality}' : '';
        address += placemark.administrativeArea != null
            ? ', ${placemark.administrativeArea}'
            : '';
        address += placemark.country != null ? ', ${placemark.country}' : '';
        address +=
            placemark.postalCode != null ? ', ${placemark.postalCode}' : '';
        setState(() {
          _locationController.text =
              address; // Set the address to the text field
        });
      } else {
        setState(() {
          _locationController.text = 'No address found';
        });
      }
    } catch (e) {
      print('Error fetching address: $e');
      setState(() {
        _locationController.text = 'Error fetching address';
      });
    }
  }
}
