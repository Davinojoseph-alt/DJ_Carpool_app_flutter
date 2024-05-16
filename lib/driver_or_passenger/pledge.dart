import 'package:flutter/material.dart';
import 'package:my_app/driver_or_passenger/driver_or_pass.dart';

class Pledge extends StatefulWidget {
  const Pledge({Key? key}) : super(key: key);

  @override
  State<Pledge> createState() => _PledgeState();
}

class _PledgeState extends State<Pledge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 45, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Kids Chaupal\'s Pledge',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                height: 5,
                width: 100,
              ),
              SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      pledgeContainer(
                          'Respect Each Other',
                          'I will respect fellow riders and value their time & space. I would never treat them as Driver/Passenger',
                          'assets/respect.png'),
                      SizedBox(height: 20),
                      pledgeContainer(
                          'Be Environment Friendly',
                          'I will carpool regularly and be the reason for at least one less car on the road',
                          'assets/env.png'),
                      SizedBox(height: 20),
                      pledgeContainer(
                          'Spread Goodness',
                          'I will encourage others to start carpooling to make city greener and pollution free',
                          'assets/spread_goodness.png'),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RideGiverOrTaker()));
                  // Add functionality when the container is tapped
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'I AGREE',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 20.0), // Adjust this value as needed
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pledgeContainer(String title, String description, String imgPath) {
    return Container(
      // height: 100,
      // width: 100,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(10),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            height: 200,
            width: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                imgPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
