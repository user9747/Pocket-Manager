import 'package:flutter/material.dart';

void main() => runApp(MyCustomForm());

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  @override
  void initState() {

    super.initState();
    // myController.addListener(_printLastEdit);
  }
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "hello",
        home: Scaffold(
          appBar: AppBar(
            title: Text("Custom Form"),
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: myController,
                  decoration: InputDecoration(hintText: 'Enter name',border: InputBorder.none),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Builder(builder: (context)=>RaisedButton(
                  child: Text("press"),
                  color: Colors.lightBlue,
                  textColor: Colors.black,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text(myController.text)));
                    }
                  },
                ),)
              ],
            ),
          ),
        ));
  }
  void _printLastEdit(){
    print("Last Edit: ${myController.text}");
  }
}
