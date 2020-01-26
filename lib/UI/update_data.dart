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

  void createRecord(String name, double amount, String desc) async {
    print("Creating Record...");
    user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    var now = new DateTime.now();
    // String name = "Amal";
    List arr = [];
    arr.add({'date': now, 'amount': amount, 'description': desc});
    await databaseReference
        .collection("user")
        .document(user.uid)
        .setData({name: FieldValue.arrayUnion(arr)}, merge: true);

    // DocumentSnapshot snap =
    //     await databaseReference.collection("user").document(user.uid).get();
    // if (snap.exists) {
    //   await databaseReference
    //       .collection("user")
    //       .document(user.uid)
    //       .updateData({name: FieldValue.arrayUnion(arr)});
    // } else {
    //   await databaseReference
    //       .collection("user")
    //       .document(user.uid)
    //       .setData({name: arr});
    // }
  }

  void removeRecord(
      String name, double amount, String desc, Timestamp now) async {
    print("Creating Record...");
    user = await FirebaseAuth.instance.currentUser();
    List arr = [];
    arr.add({'date': now, 'amount': amount, 'description': desc});
    DocumentSnapshot snap =
        await databaseReference.collection("user").document(user.uid).get();
    if (snap.exists) {
      await databaseReference
          .collection("user")
          .document(user.uid)
          .updateData({name: FieldValue.arrayRemove(arr)});
    }
  }

  snapshotExists() async {
    user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot snap =
        await databaseReference.collection("user").document(user.uid).get();
    if (snap.exists) {
      return true;
    }
    return false;
  }

  void createUserDoc(String name) async {
    user = await FirebaseAuth.instance.currentUser();
    List arr = [];
    // DocumentSnapshot snap =
    //     await databaseReference.collection("user").document(user.uid).get();

    await databaseReference
        .collection("user")
        .document(user.uid)
        .setData({name: FieldValue.arrayUnion(arr)}, merge: true);
    // if (snap.exists) {
    //   await databaseReference
    //       .collection("user")
    //       .document(user.uid)
    //       .updateData({name: FieldValue.arrayUnion(arr)});
    // } else {
    //   await databaseReference
    //       .collection("user")
    //       .document(user.uid)
    //       .setData({name: arr});
    // }
  }

  void deleteArray(String name) async {
    await databaseReference
        .collection("user")
        .document(user.uid)
        .updateData({name: FieldValue.delete()});
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
