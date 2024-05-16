import 'package:flutter/material.dart';

class VerifyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Your Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verification builds trust among the community',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Let others know that your profile is authentic.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle verification button press
                // You can add your custom logic here.
              },
              child: Text('Verify Your Profile'),
            ),
            SizedBox(height: 20),
            Text(
              'Choose a verification method:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            VerificationMethodTile(
              icon: Icons.business,
              title: 'Verify by Organization',
              description: 'Use your organization email ID',
            ),
            VerificationMethodTile(
              icon: Icons.people,
              title: 'Get Endorsed by Others',
              description: 'Get endorsements from verified users you know',
            ),
            VerificationMethodTile(
              icon: Icons.person,
              title: 'Verify Personal Identity',
              description:
                  'Upload official documents (e.g., Aadhar, Driver\'s License)',
            ),
            SizedBox(height: 20),
            Text(
              'VERIFICATION SYMBOLS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            VerificationSymbolTile(
              icon: Icons.check_circle,
              label: 'Organisation Verified',
            ),
            VerificationSymbolTile(
              icon: Icons.check_circle,
              label: 'Government ID Verified',
            ),
            VerificationSymbolTile(
              icon: Icons.check_circle,
              label: 'Organisation + Government ID Verified',
            ),
            VerificationSymbolTile(
              icon: Icons.swap_horizontal_circle,
              label: 'Endorsed by Riders',
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationMethodTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const VerificationMethodTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(description),
      onTap: () {
        // Handle verification method tap
        // You can add your custom logic here.
      },
    );
  }
}

class VerificationSymbolTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const VerificationSymbolTile({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
    );
  }
}
