import 'package:flutter/material.dart';
import 'package:my_app/ride_user/ridelocation.dart';

class RideGiverOrTaker extends StatefulWidget {
  const RideGiverOrTaker({Key? key}) : super(key: key);

  @override
  State<RideGiverOrTaker> createState() => _RideGiverOrTakerState();
}

class _RideGiverOrTakerState extends State<RideGiverOrTaker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(48, 48, 48, 0),
            child: Text(
              'Select Your Carpooling Role',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 48), // Added SizedBox for spacing
          _buildCard(
            title: 'Ride Taker',
            subtitle: 'Looking for Ride',
            imagePath: 'assets/male_dp.png',
          ),
          _buildCard(
            title: 'Ride Giver',
            subtitle: 'Share Seats',
            imagePath: 'assets/ride_together.png',
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Image.asset(
          'assets/bottombar.png',
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required String imagePath,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48, vertical: 10),
      child: GestureDetector(
        onTap: () {
          if (title == 'Ride Taker') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CreateRidePage(isDriver: false),
              ),
            );
          } else if (title == 'Ride Giver') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CreateRidePage(isDriver: true),
              ),
            );
          }
        },
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
