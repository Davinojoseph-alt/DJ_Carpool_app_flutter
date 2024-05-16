import 'package:cloud_firestore/cloud_firestore.dart';

class CreateRideDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentReference> saveRideData(
    String userId,
    String startingLocation,
    String destinationLocation,
    bool isDriver,
  ) async {
    CollectionReference rideCollection =
        _firestore.collection(isDriver ? 'driver_rides' : 'user_rides');
    DocumentReference userDoc = rideCollection.doc(userId);

    // Save the ride data to the user's document
    await userDoc.set({
      'startingLocation': startingLocation,
      'destinationLocation': destinationLocation,
    });
    return userDoc;
  }

  Future<DocumentReference> updateRideTiming(
    String userId,
    String rideId,
    String startingTime,
    String endingTime,
    bool isDriver,
  ) async {
    CollectionReference rideCollection =
        _firestore.collection(isDriver ? 'driver_rides' : 'user_rides');
    DocumentReference userDoc = rideCollection.doc(userId);

    // Update the ride data with starting time and ending time in the ride document
    await userDoc.update({
      'startingTime': startingTime,
      'endingTime': endingTime,
    });
    return userDoc;
  }

  // Function to get ride details for a specific user
  Future<Map<String, dynamic>> userRideDetails(
      String userId, bool isDriver) async {
    CollectionReference rideCollection =
        _firestore.collection(isDriver ? 'driver_rides' : 'user_rides');
    DocumentSnapshot userRideSnapshot = await rideCollection.doc(userId).get();

    // Check if the document exists
    if (userRideSnapshot.exists) {
      return userRideSnapshot.data() as Map<String, dynamic>;
    } else {
      // Return null or handle the case where the ride details are not found
      return {};
    }
  }

  // Function to get ride details for a specific driver
  Future<Map<String, dynamic>> driverRideDetails(String driverId) async {
    CollectionReference rideCollection = _firestore.collection('driver_rides');
    DocumentSnapshot driverRideSnapshot =
        await rideCollection.doc(driverId).get();

    // Check if the document exists
    if (driverRideSnapshot.exists) {
      return driverRideSnapshot.data() as Map<String, dynamic>;
    } else {
      // Return null or handle the case where the ride details are not found
      return {};
    }
  }

  // Function to get all driver rides
  Future<List<Map<String, dynamic>>> getAllDriverRides() async {
    CollectionReference rideCollection = _firestore.collection('driver_rides');
    QuerySnapshot rideSnapshot = await rideCollection.get();

    List<Map<String, dynamic>> rides = [];

    // Iterate through all rides and add them to the list
    for (var doc in rideSnapshot.docs) {
      rides.add(doc.data() as Map<String, dynamic>);
    }

    return rides;
  }
}
