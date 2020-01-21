import 'package:flutter/material.dart';
import 'auth.dart';
import 'register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Google Sign In"),
              color: Colors.redAccent,
              textColor: Colors.white,
              onPressed: () {
                Auth().signInWithGoogle();
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              decoration: InputDecoration(labelText: 'username'),
              controller: usernameController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'password'),
              controller: passwordController,
            ),
            RaisedButton(
              child: Text("Login"),
              onPressed: () async {
                if (usernameController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  print("Empty form");
                } else {
                  bool res = await Auth().signInWithEmail(
                      usernameController.text, passwordController.text);
                  if (res) {
                    print("Logged In");
                  } else {
                    print("err");
                  }
                }
              },
            ),
            RaisedButton(
              child: Text("Register"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
