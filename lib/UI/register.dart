import 'package:flutter/material.dart';
import 'auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              child: Text("SignUp"),
              onPressed: () async{
                if(usernameController.text.isEmpty || passwordController.text.isEmpty){
                  print("Empty form");
                }
                else {
                  bool res = await Auth().registerWithEmail(usernameController.text, passwordController.text);
                  if(res){
                    print("User Created");
                  }
                  else{
                    print("Error in Creating User");
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
