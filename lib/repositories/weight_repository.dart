import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WeightRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var weightCollection = FirebaseFirestore.instance.collection("user");

  Future addNewWeight(String title) async {
    return await weightCollection
        .doc(firebaseAuth.currentUser!.uid)
        .collection('Weight')
        .add({
      "title": title,
      "date": FieldValue.serverTimestamp(),
    });
  }
}
