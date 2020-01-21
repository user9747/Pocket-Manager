import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'UI/splash.dart';
import 'UI/home.dart';
import 'UI/login.dart';
import 'UI/data.dart';
import 'UI/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("done loading...");
    return MaterialApp(title: "test login", home: MainPage(),routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    // When navigating to the "/second" route, build the SecondScreen widget.
    '/kadam': (context) => Kadam(),
  },);
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return SplashScreen();
        if (!snapshot.hasData || snapshot.data == null) return Login();
        return Home();
      },
    );
  }
}
