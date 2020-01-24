import 'package:flutter/material.dart';
import 'auth.dart';
import 'update_data.dart';
import 'custom_components.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  String filter;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(items);
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 1.5,brightness: Brightness.light,
          title: TextField(
            controller: searchController,
            cursorColor: Colors.black,
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
                focusColor: Colors.black,
                hoverColor: Colors.black,
                hintText: 'Search',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                icon: Icon(Icons.search,size: 33,)),
          ),
          backgroundColor: Colors.grey.shade100,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Auth().logout();
              },
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.black,
                size: 30,
              ),
              color: Colors.grey.shade100,
            ),
          ],
        ),
        body: FutureBuilder(
          future: Repository.get().getCurrentUser(),
          builder: (contex, futureShot) {
            if (futureShot.connectionState == ConnectionState.waiting) {
              return Center(
                  // child: CircularProgressIndicator(
                  //     backgroundColor: Colors.grey)
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
                        // child: CircularProgressIndicator(
                        //     backgroundColor: Colors.grey)
                        );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.data.keys.length,
                      itemBuilder: (_, index) {
                        // print(snapshot.data.data.keys.toList()[index]);
                        var key = snapshot.data.data.keys.toList()[index];
                        // print(snapshot.data.data[key]);
                        return (filter == null || filter == ""
                            ? InkWell(
                                child: MyCard(
                                  child: Text(key),
                                ),
                                onTap: () {
                                  // print(snapshot.data.data[key]);
                                  Navigator.pushNamed(context, '/kadam',
                                      arguments: [key, uid]);
                                },
                              )
                            : key.toLowerCase().contains(filter.toLowerCase())
                                ? InkWell(
                                    child: MyCard(
                                      child: Text(key),
                                    ),
                                    onTap: () {
                                      // print(snapshot.data.data[key]);
                                      Navigator.pushNamed(context, '/kadam',
                                          arguments: [key, uid]);
                                    },
                                  )
                                : Container());
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

// class MyCard extends StatelessWidget {
//   final String name;
//   MyCard(this.name, [String s]);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 120,
//       margin: EdgeInsets.all(15),
//       child: Center(
//         child: Text(name),
//       ),
//       decoration: BoxDecoration(
//           color: Colors.grey.shade100,
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.circular(27.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.white,
//               blurRadius: 10.0,
//               offset: Offset(-7, -7),
//             ),
//             BoxShadow(
//               color: Colors.black.withOpacity(.075),
//               blurRadius: 10.0,
//               offset: Offset(7, 7),
//             )
//           ]),
//     );
//   }
// }

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
            SizedBox(
              child: Container(
                height: 25,
              ),
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

// InkWell(
//                           child: MyCard(
//                             child: Text(key),
//                           ),
//                           onTap: () {
//                             // print(snapshot.data.data[key]);
//                             Navigator.pushNamed(context, '/kadam',
//                                 arguments: [key, uid]);
//                           },
//                         );
