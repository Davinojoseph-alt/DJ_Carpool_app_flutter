import 'package:flutter/material.dart';
import 'package:my_app/External%20API/trip_create/trip_create_api.dart';
import 'package:my_app/External%20API/trip_create/trip_create_params.dart';

class TripScreen extends StatefulWidget {
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  final TripCreate _tripCreate = TripCreate();

  List<Map<String, dynamic>> _trips = [];

  @override
  void initState() {
    super.initState();
    _fetchTrips();
  }

  Future<void> _fetchTrips() async {
    try {
      final TripCreateParams params = TripCreateParams(
        partnerName: 'Your Partner Name',
        partnerKey: 'Your Partner Key',
        travelerName: 'Your Traveler Name',
        travelerPassword: 'Your Traveler Password',
        email: 'Your Email',
        homeCity: 'Your Home City',
        homeCountry: 'Your Home Country',
        olat: 0.0, // Your origin latitude
        olon: 0.0, // Your origin longitude
        workCity: 'Your Work City',
        workCountry: 'Your Work Country',
        dlat: 0.0, // Your destination latitude
        dlon: 0.0, // Your destination longitude
        regularSchedule:
            'N', // Regular schedule (N=One time trip, Y=Regular schedule, F=Flexible)
        travelDays: [
          1,
          2,
          3,
          4,
          5
        ], // Example: List of travel days (1=Monday, 2=Tuesday, ..., 7=Sunday)
        car: 'D',
        // Fill in the required parameters
      );

      final response = await _tripCreate.createTrip(params);

      if (response is List<Map<String, dynamic>>) {
        setState(() {
          _trips = response as List<Map<String, dynamic>>;
        });
      } else {
        print('Unexpected response format: $response');
      }
    } catch (e) {
      print('Error fetching trips: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trips'),
      ),
      body: ListView.builder(
        itemCount: _trips.length, // Corrected the reference to _trips
        itemBuilder: (context, index) {
          final trip = _trips[index];
          return ListTile(
            title:
                Text('Origin: ${trip['home_city']}, ${trip['home_country']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Destination: ${trip['work_city']}, ${trip['work_country']}'),
                Text('Traveler: ${trip['traveler_name']}'),
                Text('Email: ${trip['email']}'),
                Text('Departure Time: ${trip['leave_origin_time']}'),
                Text('Origin Longitude: ${trip['olon']}'),
                // Add more details as needed
              ],
            ),
          );
        },
      ),
    );
  }
}
