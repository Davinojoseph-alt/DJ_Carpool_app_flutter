import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CreateRideBackend {
  late Position _currentPosition;
  TextEditingController _startingLocationController = TextEditingController();
  TextEditingController get startingLocationController =>
      _startingLocationController;
  TextEditingController _destinationLocationController =
      TextEditingController();
  TextEditingController get destinationLocationController =>
      _destinationLocationController;

  Future<void> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _currentPosition = position;
      print("Latitude: ${position.latitude}");
      print("Longitude: ${position.longitude}");

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

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

        print('Address: $address');
        _startingLocationController.text = address;
      } else {
        print('No placemarks found');
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<List<String>> getNearbyAddresses() async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition.latitude,
        _currentPosition.longitude,
      );

      List<String> nearbyAddresses = placemarks
          .map((placemark) =>
              "${placemark.name}, ${placemark.subLocality}, ${placemark.locality}")
          .toList();

      return nearbyAddresses;
    } catch (e) {
      print("Error getting nearby addresses: $e");
      return [];
    }
  }

  void updateStartingLocation() {
    getCurrentLocation();
  }

  void updateDestinationLocation(String address) {
    _destinationLocationController.text = address;
  }

  Future<void> showNearbyAddressesDialog(BuildContext context) async {
    List<String> nearbyAddresses = await getNearbyAddresses();
    if (nearbyAddresses.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Choose Nearby Address'),
            content: SingleChildScrollView(
              child: ListBody(
                children: nearbyAddresses
                    .map(
                      (address) => ListTile(
                        title: Text(address),
                        onTap: () {
                          updateDestinationLocation(address);
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No nearby addresses found.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
