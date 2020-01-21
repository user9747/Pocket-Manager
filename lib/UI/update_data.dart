import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Repository {
  final databaseReference = Firestore.instance;
  FirebaseUser user;
  static final Repository kadam = Repository();

  Repository() {
    FirebaseAuth.instance.currentUser().then((user) {
      this.user = user;
    });
  }

  static Repository get() {
    return kadam;
  }

  void createRecord(double amount,String desc) async {
    print("Creating Record...");
    user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    var now = new DateTime.now();
    String name = "Amal";
    List arr = [];
    arr.add({'date': now, 'amount': 10, 'description': 'MSd'});
    DocumentSnapshot snap =
        await databaseReference.collection("user").document(user.uid).get();
    if (snap.exists) {
      await databaseReference
          .collection("user")
          .document(user.uid)
          .updateData({name: FieldValue.arrayUnion(arr)});
    } else {
      await databaseReference
          .collection("user")
          .document(user.uid)
          .setData({name: arr});
    }
  }

  Future getCurrentUser() async {
    return FirebaseAuth.instance.currentUser();
  }

  getRecord(String uid) {
    print('Retreiving Records..');
    Stream<DocumentSnapshot> snap =
        databaseReference.collection("user").document(uid).snapshots();
    return snap;
  }
}
