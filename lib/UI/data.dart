import 'package:flutter/material.dart';
import 'update_data.dart';

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
                        data['amount'], data['date'], data['description']),
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
            return myDialog(context,key);
          },
        ));
  }

  myDialog(BuildContext context,String name) {
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

class MyCard extends StatelessWidget {
  double amount;
  DateTime date;
  String desc;

  MyCard(amount, date, desc) {
    this.amount = amount;
    this.date = date.toDate();
    this.desc = desc;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('₹${amount}'),
              Text(
                  '${date.day}-${date.month}-${date.year}(${date.hour}:${date.minute})')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text(desc)],
          )
        ],
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
  final String name ;
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
              decoration:
                  InputDecoration(labelText: 'Amount', icon: Icon(Icons.monetization_on)),
                  keyboardType: TextInputType.number,
              controller: amountController,
            ),
            TextFormField(
              decoration:
                  InputDecoration(labelText: 'Description', icon: Icon(Icons.description)),
              controller: descController,
            ),
            RaisedButton(
              child: Text('Add'),
              onPressed: () {
                print(amountController.text);
                if (amountController.text != null && descController.text != null) {
                  Repository.get().createRecord(widget.name,double.parse(amountController.text), descController.text);
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
