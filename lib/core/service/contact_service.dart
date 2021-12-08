import 'package:cloud_firestore/cloud_firestore.dart';

class ContactService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<QueryDocumentSnapshot>> getAllContact() async {
    List<QueryDocumentSnapshot> contacts = [];
    await firestore.collection('contacts').get().then((value) {
      contacts = value.docs;
    });
    return contacts;
  }
}
