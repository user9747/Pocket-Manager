import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'update_data.dart';
import 'custom_components.dart';

class Kadam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context).settings.arguments;
    // AsyncSnapshot<dynamic> snapshot = args[0];
    String key = args[0];
    String uid = args[1];
    // print(args);
    // print(snapshot.data.data);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        body: StreamBuilder(
          stream: Repository.get().getRecord(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.white));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.data[key].length,
                itemBuilder: (_, index) {
                  // print(snapshot.data.data.keys.toList()[index]);
                  // var key = snapshot.data.data.keys.toList()[index];
                  print(snapshot.data.data[key][index]);
                  var data = snapshot.data.data[key][index];
                  return InkWell(
                    child: MyCard(
                      child: Details(key, data['amount'], data['date'],
                          data['description']),
                    ),
                    onTap: () {
                      // print(snapshot.data.data [key]);
                      // Navigator.pushNamed(context, '/kadam',arguments: snapshot);
                    },
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: InkWell(
          child: MyFloatingButton(),
          onTap: () {
            return myDialog(context, key);
          },
        ));
  }

  myDialog(BuildContext context, String name) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.grey.shade100.withOpacity(0),
            child: DialogueForm(name),
          );
        });
  }
}

class Details extends StatelessWidget {
  String name;
  double amount;
  DateTime date;
  String desc;
  Timestamp timeStamp;

  Details(name, amount, date, desc) {
    this.name = name;
    this.amount = amount;
    this.timeStamp = date;
    this.date = date.toDate();
    this.desc = desc;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('₹${amount}'),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                confirm(context);
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(desc),
            Text(
                '${date.day}-${date.month}-${date.year}(${date.hour}:${date.minute})')
          ],
        )
      ],
    );
  }

  confirm(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.grey.shade100.withOpacity(0),
            child: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Do you want to delete?'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Yes'),
                        onPressed: () {
                          Repository.get()
                              .removeRecord(name, amount, desc, timeStamp);
                          Navigator.pop(context);
                        },
                      ),
                      RaisedButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(27.0),
              ),
            ),
          );
        });
  }
}

class DialogueForm extends StatefulWidget {
  final String name;
  DialogueForm(this.name);
  @override
  _DialogueFormState createState() => _DialogueFormState();
}

class _DialogueFormState extends State<DialogueForm> {
  final amountController = TextEditingController();
  final descController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Amount', icon: Icon(Icons.monetization_on)),
              keyboardType: TextInputType.number,
              controller: amountController,
            ),
            SizedBox(
              child: Container(
                height: 15,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Description', icon: Icon(Icons.description)),
              controller: descController,
            ),
            SizedBox(
              child: Container(
                height: 25,
              ),
            ),
            RaisedButton(
              child: Text('Add'),
              onPressed: () {
                print(amountController.text);
                if (amountController.text != null &&
                    descController.text != null) {
                  Repository.get().createRecord(widget.name,
                      double.parse(amountController.text), descController.text);
                }
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(27.0),
      ),
    );
  }
}
