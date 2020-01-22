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
            Center(
              child: InkWell(
                child: MyFloatingButton(),
                onTap: () {
                  Auth().signInWithGoogle();
                },
              ),
            ),
            // const SizedBox(height: 30),
            // TextFormField(
            //   decoration: InputDecoration(labelText: 'username'),
            //   controller: usernameController,
            // ),
            // TextFormField(
            //   decoration: InputDecoration(labelText: 'password'),
            //   controller: passwordController,
            // ),
            // RaisedButton(
            //   child: Text("Login"),
            //   onPressed: () async {
            //     if (usernameController.text.isEmpty ||
            //         passwordController.text.isEmpty) {
            //       print("Empty form");
            //     } else {
            //       bool res = await Auth().signInWithEmail(
            //           usernameController.text, passwordController.text);
            //       if (res) {
            //         print("Logged In");
            //       } else {
            //         print("err");
            //       }
            //     }
            //   },
            // ),
            // RaisedButton(
            //   child: Text("Register"),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => SignUp()),
            //     );
            //   },
            // )
          ],
        ),
      ),
    );
  }
}

class MyFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
          'Google Sign In',
          style: TextStyle(color: Colors.redAccent),
        ),
        padding: const EdgeInsets.all(55.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  0.3,
                  0.9,
                ],
                colors: [
                  Colors.grey.shade100,
                  const Color(0xeec7c3),
                ]),
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(27.0),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 10.0,
                offset: Offset(-7, -7),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(.075),
                blurRadius: 10.0,
                offset: Offset(7, 7),
              )
            ]));
  }
}
