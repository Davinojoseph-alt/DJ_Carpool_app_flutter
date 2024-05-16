import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/Chats/chats.dart';
import 'package:my_app/Notifications/notification_page.dart';
import 'package:my_app/Payment/payment_method_list.dart';
import 'package:my_app/Verify_your_profile/verifyprofile.dart';
import 'package:my_app/picklocation/location_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSwitched = false;
  final user = FirebaseAuth.instance.currentUser;

  // sign user out method
  Future<void> signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () {
                    // Open the drawer when the menu icon is pressed
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            );
          }),
          // title: Text(
          //   'Hi ' + (user?.email ?? 'Guest'),
          //   style: TextStyle(
          //     color: Colors.white,
          //   ),
          // ),
          actions: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 20,
                  child: IconButton(
                    icon: Icon(Icons.chat),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ChatsPage()));
                    },
                    padding: EdgeInsets.zero,
                  )),
            ),
            CircleAvatar(
                backgroundColor: Colors.black,
                radius: 20,
                child: IconButton(
                  icon: Icon(Icons.notifications),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationsPage()));
                  },
                  padding: EdgeInsets.zero,
                )),
            SizedBox(
              width: 8,
            ),
            CircleAvatar(
                backgroundColor: Colors.black,
                radius: 20,
                child: IconButton(
                  icon: Icon(Icons.logout),
                  color: Colors.white,
                  onPressed: signUserOut,
                  padding: EdgeInsets.zero,
                )),
          ],
          flexibleSpace: Image.asset(
            'assets/sky.png',
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              // Add the user avatar and name
              UserAccountsDrawerHeader(
                accountName: Text('Davino Joseph'),
                accountEmail: Text('davino@example.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/male_dp.png'), // Replace with your image
                ),
              ),
              Divider(), // Add a divider for separation

              // Add your settings items here
              _buildSettingsItem(
                  'Post Ride', Icons.directions_car, Colors.blue),
              _buildSettingsItem('My Rides', Icons.history, Colors.green),
              _buildSettingsItem('Payments', Icons.payment, Colors.orange),
              _buildSettingsItem(
                  'Subscription', Icons.subscriptions, Colors.purple),
              _buildSettingsItem(
                  'My Vehicle', Icons.directions_car_filled, Colors.teal),
              _buildSettingsItem(
                  'My Contribution', Icons.volunteer_activism, Colors.red),
              _buildSettingsItem('My Community', Icons.group, Colors.amber),
              _buildSettingsItem('My Favorites', Icons.favorite, Colors.pink),
              _buildSettingsItem(
                  'Offers', Icons.local_offer, Colors.deepOrange),
              _buildSettingsItem(
                  'Refer & Rewards', Icons.card_giftcard, Colors.indigo),
              _buildSettingsItem('Settings', Icons.settings, Colors.grey),
              _buildSettingsItem('Help', Icons.help, Colors.brown),
              _buildSettingsItem('Logout', Icons.logout, Colors.red),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Find Pool and Offer Pool tabs
              TabBar(
                tabs: [
                  Tab(text: 'Find Pool'),
                  Tab(text: 'Offer Pool'),
                ],
              ),

              // Pickup and Drop location fields
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationInput()),
                            );
                          },
                        ),
                        SizedBox(
                            width:
                                10), // You can adjust this value as per your need
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                labelText:
                                    'F-1, MGR Residency, Himagiri Meadows',
                                contentPadding: EdgeInsets.only(bottom: 5)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationInput()),
                            );
                          },
                        ),
                        SizedBox(
                            width:
                                10), // You can adjust this value as per your need
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: 'Enter Drop Location',
                                contentPadding: EdgeInsets.only(bottom: 5)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.0),

              Divider(color: Colors.grey[200]),

              // Verifify your profile tick Mark
              Container(
                //Verify Your Profile Container
                padding: EdgeInsets.fromLTRB(
                  20.0, // left
                  20.0, // top
                  0.0, // right
                  10.0, // bottom
                ),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // This will center the items
                  children: <Widget>[
                    Icon(Icons.verified, color: Colors.green[700]),
                    SizedBox(
                        width: 8.0), // Add some space between the icon and text
                    Text(
                      'Verify your profile and get first ride FREE',
                      style: TextStyle(color: Colors.green[600]),
                    ),
                    SizedBox(
                        width: 5.0), // Add some space between the text and icon
                    IconButton(
                      icon: Icon(Icons.navigate_next, color: Colors.green),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyProfilePage()),
                        );
                        // Your action when the button is pressed
                      },
                    )
                  ],
                ),
              ),

              Container(
                height: 20.0,
                color: Colors.grey[100],
              ), //Empty Container

              // Refer and Earn section
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    20.0, // left
                    20.0, // top
                    20.0, // right
                    20.0, // bottom
                  ), // Increase padding
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the left
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: 0.0), // Adjust this value as per your need
                        child: Text(
                          'REFER AND EARN',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                          height:
                              4.0), // Add some space between the heading and description
                      Padding(
                        padding: EdgeInsets.only(
                            left: 0.0), // Adjust this value as per your need
                        child: Text(
                          'Refer to earn 50 points plus 2% commission on every ride',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ),
                      SizedBox(
                          height:
                              10.0), // Add some space between the description and image
                      Image.asset(
                        'assets/refer_and_earn.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: 20.0,
                color: Colors.grey[100],
              ), //Empty Container

              // Complete your profile
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      20.0, 20.0, 20.0, 20.0), // Increase padding
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the left
                    children: <Widget>[
                      Text(
                        'YOUR PROFILE',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          height:
                              4.0), // Add some space between the heading and description
                      Text(
                        'Complete your profile',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      SizedBox(
                          height:
                              10.0), // Add some space between the description and image
                      Image.asset(
                        'assets/male_dp.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: 20.0,
                color: Colors.grey[100],
              ), // Add some space between the containers

              // Ride and Recieve Payments
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'RECIEVE RIDE PAYMENTS',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20.0),
                      // Add some space between the heading and description
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 40, // Adjust the width as needed
                            height: 40, // Adjust the height as needed
                            child: Image.asset(
                              'assets/payment.png', // Replace with your payment image path
                            ),
                          ), // Replace with your wallet icon
                          SizedBox(width: 20.0),
                          // Add some space between the icon and text

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Add Redemption Mode',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 2.0),
                                Text(
                                  'Get ride points directly to your preferred mode after every ride',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                              width:
                                  10.0), // Add some space between the text and icon
                          IconButton(
                            icon:
                                Icon(Icons.navigate_next, color: Colors.black),
                            onPressed: () {
                              // Navigate to the PaymentMethodList screen here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PaymentMethodList()),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: 20.0,
                color: Colors.grey[100],
              ),

              // Auto Match Rides
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              width: 40, // Adjust the width as needed
                              height: 40, // Adjust the height as needed
                              child: Icon(
                                Icons.autorenew_outlined,
                                color: Colors.green[600],
                              )), // Replace with your wallet icon
                          SizedBox(width: 20.0),
                          // Add some space between the icon and text

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AUTO MATCH RIDES',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 2.0),
                                Text(
                                  'Join rides automatically with following criteria',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                              width:
                                  10.0), // Add some space between the text and icon
                          Switch(
                            value: _isSwitched,
                            onChanged: (value) {
                              setState(() {
                                _isSwitched = value;
                              });
                            },
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.grey,
                            activeTrackColor: Colors.lightGreenAccent,
                            inactiveTrackColor: Colors.grey[300],
                            activeThumbImage: AssetImage('assets/male_dp.png'),
                            inactiveThumbImage:
                                AssetImage('assets/male_dp.png'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: 20.0,
                color: Colors.grey[100],
              ),
              //YOUR contribution
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'YOUR CONTRIBUTION',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        'Ecometer to check your savings and CO2 reduction',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 12,
                        ),
                      ),
                      // Add some space between the heading and description
                      SizedBox(
                        height: 15.0,
                      ),

                      Container(
                        height: 150.0,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the roundness as needed
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(35.0, 14.0, 14.0, 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 40.0, // Half of the screen height
                                child: Icon(
                                  Icons.energy_savings_leaf_rounded,
                                  color: Colors.green,
                                ),
                              ),

                              SizedBox(
                                width: 18.0,
                              ),
                              // Add some space between the icon and text

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '0 rides . 0 kg of ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'CO2 reduced',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
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

              Container(
                height: 20.0,
                color: Colors.grey[100],
              ),

              // Whats New
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    20.0, // left
                    20.0, // top
                    20.0, // right
                    20.0, // bottom
                  ), // Increase padding
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the left
                    children: <Widget>[
                      // Adjust this value as per your need
                      Text(
                        "WHAT'S NEW",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          height:
                              10.0), // Add some space between the description and image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          height: 150.0,
                          width: double.infinity,
                          'assets/carview.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                          height:
                              15.0), // Add some space between the image and description
                      Text(
                        "Referal: The strength of Carpool network",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: 20.0,
                color: Colors.grey[100],
              ),

              // NEED HELP
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.all(16.0), // Increase padding
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the left
                    children: <Widget>[
                      Text(
                        'NEED HELP ?',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          height:
                              4.0), // Add some space between the heading and description
                      Text(
                        'You can look for answers in our help center or contact our support agents by phone or email',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),

                      SizedBox(
                          height:
                              10.0), // Add some space between the description and image
                      Text(
                        'Go to help',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: 20.0,
                color: Colors.grey[100],
              ),

              // For latest updated follow us
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'For latest updates, follow us',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(FontAwesomeIcons.facebookF,
                                size: 20, color: Colors.white),
                          ),
                          SizedBox(width: 25),
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(FontAwesomeIcons.xTwitter,
                                size: 20, color: Colors.white),
                          ),
                          SizedBox(width: 25),
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(FontAwesomeIcons.linkedinIn,
                                size: 20, color: Colors.white),
                          ),
                          SizedBox(width: 25),
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(FontAwesomeIcons.instagram,
                                size: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.blueGrey,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'RIDE Together',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Save money, Reduce carbon footprints & grow your network',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the roundness as needed
                        child: Image.asset(
                          'assets/ride_together.png',
                          width: double.infinity,
                          // Full width
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.local_taxi),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.directions_car),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, Color color) {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title),
        onTap: () {
          if (title == 'My Vehicle') {
            Navigator.pushNamed(context, '/vechiledetails');
            // Handle the tap on the settings item
            // You can navigate to a specific screen or perform an action here
          } else if (title == 'Payments') {
            Navigator.pushNamed(context, '/payments');
          }
        });
  }
}
