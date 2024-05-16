import "package:my_app/Chats/chats.dart";
import "package:my_app/External%20API/trip_create/trip_create_screen.dart";
import "package:my_app/HomePage/splash_screen.dart";
import "package:my_app/Notifications/notification_page.dart";
import "package:my_app/Payment/payment_method_list.dart";
import "package:my_app/Verify_your_profile/verifyprofile.dart";
import "package:my_app/driver_or_passenger/driver_or_pass.dart";
import "package:my_app/HomePage/homepage.dart";
import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import "package:my_app/driver_or_passenger/pledge.dart";
import "package:my_app/driver_or_passenger/vechile_details.dart";
import "package:my_app/email_login/auth_page.dart";
import "package:my_app/email_login/login_page.dart";
import "package:my_app/phone_number/otp.dart";
import "package:my_app/phone_number/phone.dart";
import "package:my_app/picklocation/location_input.dart";
import "package:my_app/ride_user/Matchedrides.dart";
import "package:my_app/ride_user/mapdisplay.dart";
import "package:my_app/ride_user/myrides.dart";
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'KidsChaupalAPP',
    initialRoute: '/matchride',
    theme: ThemeData(
      primarySwatch: Colors.green,
      textTheme: TextTheme(
        bodyText2: TextStyle(
          fontFamily: 'NanumGothic',
        ),
      ),
    ),
    routes: {
      '/pledge': (context) => Pledge(),
      '/createtripscreen': (context) => TripScreen(),
      '/matchride': (context) => CreateMatchesridePage(
            isDriver: false,
          ),
      '/myrides': (context) => MyRidesPage(),
      '/setlocationpage': (context) => SelectLocationPage(),
      '/verifyprofile': (context) => VerifyProfilePage(),
      '/chats': (context) => ChatsPage(),
      '/payments': (context) => PaymentMethodList(),
      '/notifications': (context) => NotificationsPage(),
      '/locationinput': (context) => LocationInput(),
      '/vechiledetails': (context) => VechileDetails(),
      '/splash': (context) => SplashScreen(),
      // '/ridetiming': (context) => RideTimingPage(
      //       rideId: '',
      //       isDriver: null,
      //     ),
      // '/createride': (context) => CreateRidePage(
      //       isDriver: null,
      //     ),
      '/phone': (context) => MyPhone(),
      '/myotp': (context) => MyOtp(),
      '/authpage': (context) => AuthPage(),
      '/loginpage': (context) => LoginPage(
            onTap: () {},
          ),
      '/ridegiverortaker': (context) => RideGiverOrTaker(),
      '/homepage': (context) => HomePage(),
    },
  ));
}
