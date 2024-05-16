import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SendRequestPage extends StatefulWidget {
  final Map<String, dynamic> rideDetails; // Add rideDetails argument
  SendRequestPage({Key? key, required this.rideDetails}) : super(key: key);

  @override
  _SendRequestPageState createState() => _SendRequestPageState();
}

class _SendRequestPageState extends State<SendRequestPage> {
  late String rideGiverUserId;
  late String currentUserID; // Added to store current user's ID
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Retrieve the userid of the ride giver from the rideDetails map
    rideGiverUserId = widget.rideDetails['userId'];
    getCurrentUserID(); // Get current user's ID
  }

  // Method to get the current user ID
  void getCurrentUserID() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserID = user.uid;
      });
    } else {
      // Handle case where user is not logged in
      print("User not logged in");
    }
    print("Current user id is $currentUserID ");
  }

  // Method to send request message
  void sendRequestMessage() {
    String message = messageController.text.trim();
    if (message.isNotEmpty) {
      // Add request message to Firestore
      FirebaseFirestore.instance.collection('requests').add({
        'senderId': currentUserID,
        'receiverId': rideGiverUserId,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
        // Add other details if needed
      }).then((value) {
        // Message sent successfully
        print('Request message sent successfully!');
        // You can add further actions here if needed
      }).catchError((error) {
        // Error occurred while sending message
        print('Error sending request message: $error');
        // Handle the error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a request to the ride giver:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Message:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Type your request message here...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: sendRequestMessage,
                child: Text('Send Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
