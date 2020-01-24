import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'UI/splash.dart';
import 'UI/home.dart';
import 'UI/login.dart';
import 'UI/data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("done loading...");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "test login",
      color: Colors.grey.shade100,
      home: MainPage(),
      routes: {
        '/kadam': (context) => Kadam(),
      },
    );
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
