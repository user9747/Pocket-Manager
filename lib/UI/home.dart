import 'package:flutter/material.dart';
import 'auth.dart';
import 'update_data.dart';

class Home extends StatelessWidget {
  // Future<List> items =  Repository().getRecord();
  @override
  Widget build(BuildContext context) {
    // print(items);
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.grey.shade100,
          actions: <Widget>[
            RaisedButton.icon(
                onPressed: () {
                  Auth().logout();
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                color: Colors.grey.shade100,
                label: Text("Logout"),
                textColor: Colors.black),
          ],
        ),
        body: FutureBuilder(
          future: Repository.get().getCurrentUser(),
          builder: (contex, futureShot) {
            if (futureShot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                backgroundColor: Colors.white,
              );
            } else {
              String uid = futureShot.data.uid;
              // print('hello ${uid}');
              return StreamBuilder(
                stream: Repository.get().getRecord(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.white));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.data.keys.length,
                      itemBuilder: (_, index) {
                        // print(snapshot.data.data.keys.toList()[index]);
                        var key = snapshot.data.data.keys.toList()[index];
                        // print(snapshot.data.data[key]);
                        return InkWell(
                          child: MyCard(key),
                          onTap: () {
                            // print(snapshot.data.data[key]);
                            Navigator.pushNamed(context, '/kadam',
                                arguments: [key, uid]);
                          },
                        );
                      },
                    );
                  }
                },
              );
            }
          },
        ),
        floatingActionButton: InkWell(
          child: MyFloatingButton(),
          onTap: () {
            return myDialog(context);
          },
        ));
  }

  myDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.grey.shade100.withOpacity(0),
            child: DialogueForm(),
          );
        });
  }
}

class MyCard extends StatelessWidget {
  final String name;
  MyCard(this.name, [String s]);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(15),
      child: Center(
        child: Text(name),
      ),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(27.0),
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
          ]),
    );
  }
}

class MyFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Icon(Icons.add),
        padding: const EdgeInsets.all(28.0),
        decoration:
            BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle,
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

class DialogueForm extends StatefulWidget {
  @override
  _DialogueFormState createState() => _DialogueFormState();
}

class _DialogueFormState extends State<DialogueForm> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
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
              decoration:
                  InputDecoration(labelText: 'Name', icon: Icon(Icons.person)),
              controller: nameController,
            ),
            RaisedButton(
              child: Text('Add'),
              onPressed: () {
                print(nameController.text);
                if (nameController.text != null) {
                  Repository.get().createUserDoc(nameController.text);
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
