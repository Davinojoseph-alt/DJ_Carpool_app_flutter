import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/driver_or_passenger/ridtiming.dart';
import 'package:my_app/ride_user/createride_backend.dart';
import 'package:my_app/ride_user/createride_database.dart';

class CreateRidePage extends StatefulWidget {
  final bool isDriver; // Add isDriver argument
  CreateRidePage({Key? key, required this.isDriver}) : super(key: key);

  @override
  _CreateRidePageState createState() => _CreateRidePageState();
}

class _CreateRidePageState extends State<CreateRidePage> {
  late String userId;
  CreateRideBackend _rideBackend = CreateRideBackend();
  CreateRideDatabase _rideDatabase = CreateRideDatabase();

  @override
  void initState() {
    super.initState();
    _rideBackend.getCurrentLocation();
    getCurrentUserId();
  }

  // Method to get the current user ID
  void getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
    } else {
      // Handle case where user is not logged in
      print("User not logged in");
    }
    print("User id is $userId ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 45, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Let\'s Create Your Ride',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Rounded edges
                color: Colors.green, // Divider color
              ),
              height: 5, // Thickness
              width: 100, // Adjust width as needed
            ),
            SizedBox(height: 20),
            Text(
              'Your addresses are kept private',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _rideBackend.updateStartingLocation();
                  },
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Set Starting Location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    controller: _rideBackend.startingLocationController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.work,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _rideBackend.showNearbyAddressesDialog(context);
                  },
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Set Destination Location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    controller: _rideBackend.destinationLocationController,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/ride_together.png', // replace with your actual map image asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: TextButton(
          onPressed: () async {
            // Save ride data to the database
            DocumentReference rideRef = await _rideDatabase.saveRideData(
              userId,
              _rideBackend.startingLocationController.text,
              _rideBackend.destinationLocationController.text,
              widget.isDriver,
            );

            // Navigate to RideTimingPage and pass the ride ID
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RideTimingPage(
                  rideId: rideRef.id,
                  userId: userId,
                  isDriver: widget.isDriver,
                ),
              ),
            );
          },
          child: Text('Next'),
        ),
      ),
    );
  }
}
