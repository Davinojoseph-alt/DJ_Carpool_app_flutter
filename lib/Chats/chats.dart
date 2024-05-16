import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with the actual number of chats
        itemBuilder: (context, index) {
          return _buildChatItem(
            username: 'User $index',
            lastMessage: 'Hello there!',
            unreadCount: index % 3, // Replace with actual unread count
          );
        },
      ),
    );
  }

  Widget _buildChatItem({
    required String username,
    required String lastMessage,
    required int unreadCount,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
            AssetImage('assets/male_dp.png'), // Replace with user avatars
      ),
      title: Text(username),
      subtitle: Text(lastMessage),
      trailing: unreadCount > 0
          ? Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Text(
                unreadCount.toString(),
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
      onTap: () {
        // Handle chat item tap (e.g., open chat screen)
        // You can add your custom logic here.
      },
    );
  }
}
