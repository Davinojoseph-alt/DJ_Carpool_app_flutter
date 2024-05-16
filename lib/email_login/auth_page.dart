import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/driver_or_passenger/driver_or_pass.dart';
import 'package:my_app/email_login/login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // user is logged in
              if (snapshot.hasData) {
                return RideGiverOrTaker();
              } else {
                return LoginOrRegisterPage();
              }

              // user is not logged in
            }));
  }
}
