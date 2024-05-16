import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyRidesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set a background color
      appBar: AppBar(
        title: Text('My Rides'),
        backgroundColor: Colors.deepPurple, // Change the AppBar color
        elevation: 0, // Remove shadow for a cleaner look
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // This will take you back to the previous screen
          },
        ),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('rides').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final rides = snapshot.data!.docs;
          return ListView.separated(
            itemCount: rides.length,
            itemBuilder: (context, index) {
              final ride = rides[index];
              final startingLocation = ride['startingLocation'];
              final destinationLocation = ride['destinationLocation'];
              final startingTime = ride['startingTime'];
              final endingTime = ride['endingTime'];

              return Card(
                // Wrap ListTile with Card for better visuals
                elevation: 2, // Slight shadow for depth
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  title: Text('Ride ${index + 1}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Starting Location: $startingLocation'),
                        Text('Destination Location: $destinationLocation'),
                        if (startingTime != null)
                          Text('Starting Time: $startingTime'),
                        if (endingTime != null)
                          Text('Ending Time: $endingTime'),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) =>
                Divider(), // Add dividers between list items
          );
        },
      ),
    );
  }
}
