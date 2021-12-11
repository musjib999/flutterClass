import 'package:api_flutter/shared/model/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<ContactModel>> getAllContact() async {
    List<ContactModel> contactList = [];
    try {
      await firestore.collection('contacts').get().then((value) {
        List<QueryDocumentSnapshot<Map<String, dynamic>>> contacts = value.docs;
        for (var contact in contacts) {
          contactList.add(
            ContactModel(
              name: contact.data()['name'],
              email: contact.data()['email'],
              phone: contact.data()['phone'],
            ),
          );
        }
      });
    } catch (e) {
      contactList.add(
        ContactModel(name: 'N/A', email: 'N/A', phone: 'N/A'),
      );
      throw 'Error occured $e';
    }
    return contactList;
  }

  Future<ContactModel?> addContact(Map<String, dynamic> data) async {
    ContactModel? contactModel;
    try {
      await firestore.collection('contacts').add(data).then((value) {
        value.get().then((value) {
          contactModel = ContactModel(
            name: value.data()!['name'],
            email: value.data()!['email'],
            phone: value.data()!['phone'],
          );
        });
      });
    } catch (e) {
      contactModel = ContactModel(name: 'N/A', email: 'N/A', phone: 'N/A');
      throw 'Error occured $e';
    }
    return contactModel;
  }
}
