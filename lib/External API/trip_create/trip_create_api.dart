import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/External%20API/trip_create/trip_create_params.dart';

class TripCreate {
  Future<Map<String, dynamic>> createTrip(TripCreateParams params) async {
    final url = 'https://www.carpoolworld.com/rest_trip.html/json';

    final requestBody = {
      'trip': {
        'partner_name': params.partnerName,
        'partner_key': params.partnerKey,
        'traveler_name': params.travelerName,
        'traveler_password': params.travelerPassword,
        'trip_id': '0',
        'email': params.email,
        'home_city': params.homeCity,
        'home_country': params.homeCountry,
        'olat': params.olat.toString(),
        'olon': params.olon.toString(),
        'work_city': params.workCity,
        'work_country': params.workCountry,
        'dlat': params.dlat.toString(),
        'dlon': params.dlon.toString(),
        'regular_schedule': params.regularSchedule,
        'car': params.car,
      }
    };

    final response = await http.post(
      Uri.parse(url),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Trip created successfully');
      return json.decode(response.body);
    } else {
      print('Failed to create trip. Status code: ${response.statusCode}');
      throw Exception('Failed to create trip');
    }
  }
}
