import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/ride_user/createride_database.dart';
import 'package:my_app/ride_user/sendrequest.dart';

class CreateMatchesridePage extends StatefulWidget {
  final bool isDriver;

  CreateMatchesridePage({required this.isDriver});

  @override
  _CreateMatchesridePageState createState() => _CreateMatchesridePageState();
}

class _CreateMatchesridePageState extends State<CreateMatchesridePage> {
  late String userId;
  Map<String, dynamic> userRideDetails = {};
  List<Map<String, dynamic>> matchedRides = [];
  late CreateRideDatabase _rideDatabase;

  @override
  void initState() {
    super.initState();
    _rideDatabase = CreateRideDatabase();
    getCurrentUserId();
  }

  void getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
      getUserRideDetails();
    } else {
      print("User not logged in");
      // Handle case where user is not logged in
    }
    print("User id is $userId ");
  }

  Future<void> getUserRideDetails() async {
    try {
      Map<String, dynamic> details =
          await _rideDatabase.userRideDetails(userId, widget.isDriver);
      setState(() {
        userRideDetails = details;
      });
      print('User Ride Details: $details');
      findMatches();
    } catch (e) {
      print('Error fetching user ride details: $e');
      // Handle the error
    }
  }

  Future<void> findMatches() async {
    try {
      List<Map<String, dynamic>> driverRides =
          await _rideDatabase.getAllDriverRides();
      List<Map<String, dynamic>> matches = [];

      print('User Ride Details: $userRideDetails');

      for (var ride in driverRides) {
        print('Checking Driver Ride: $ride');
        if (isMatch(userRideDetails, ride)) {
          matches.add(ride);
        }
      }

      setState(() {
        matchedRides = matches;
      });
    } catch (e) {
      print('Error finding matches: $e');
      // Handle the error
    }
  }

  bool isMatch(Map<String, dynamic> userRide, Map<String, dynamic> driverRide) {
    bool isStartingLocationMatch =
        userRide['startingLocation'] == driverRide['startingLocation'];
    bool isDestinationLocationMatch =
        userRide['destinationLocation'] == driverRide['destinationLocation'];
    bool isStartingTimeMatch =
        userRide['startingTime'] == driverRide['startingTime'];
    bool isEndingTimeMatch = userRide['endingTime'] == driverRide['endingTime'];

    return isStartingLocationMatch &&
        isDestinationLocationMatch &&
        isStartingTimeMatch &&
        isEndingTimeMatch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Matcher'),
        backgroundColor: Colors.deepPurple.shade400,
        actions: [
          IconButton(
            icon: Icon(Icons.light_mode),
            onPressed: () {
              // Implement theme switcher or other action
            },
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 2),
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.indigo.shade800, Colors.red.shade600],
            center: Alignment(0.1, 0.3),
            focal: Alignment(-0.1, 0.6),
            focalRadius: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Ride Details',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent.shade400,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            // Display user ride details here using userRideDetails map

            Text(
              'Matched Rides',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent.shade400,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: matchedRides.isEmpty
                  ? Center(
                      child: Text(
                        'No matches found.',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: matchedRides.length,
                      itemBuilder: (context, index) {
                        final ride = matchedRides[index];
                        return Transform.scale(
                          scale: 1.05,
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 12.0),
                            color: Colors.pink.shade200,
                            elevation: 6.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ListTile(
                              leading: Icon(Icons.directions_car_filled,
                                  color: Colors.deepOrange.shade400),
                              title: Text(
                                '${ride['startingLocation']} 🚀 ${ride['destinationLocation']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple.shade300,
                                ),
                              ),
                              subtitle: Text(
                                '🕒 Starting Time: ${ride['startingTime']} | 🕔 Ending Time: ${ride['endingTime']}',
                                style: TextStyle(color: Colors.black54),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Colors.green.shade400),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SendRequestPage(
                                            rideDetails: ride,
                                            // Pass ride details
                                          )),
                                );
                                // Implement ride selection action
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
