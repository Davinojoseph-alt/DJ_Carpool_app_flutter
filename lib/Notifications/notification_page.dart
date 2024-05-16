import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            Navigator.pop(context);
            // Navigate back to the previous screen
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with the actual number of notifications
        itemBuilder: (context, index) {
          return _buildNotificationItem(
            title: 'Notification Title $index',
            message: 'This is a sample notification message.',
            timestamp: '2 hours ago', // Replace with the actual timestamp
          );
        },
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String message,
    required String timestamp,
  }) {
    return ListTile(
      leading: Icon(Icons.notifications),
      title: Text(title),
      subtitle: Text(message),
      trailing: Text(timestamp),
      onTap: () {
        // Handle notification item tap (e.g., navigate to a detailed view)
        // You can add your custom logic here.
      },
    );
  }
}
