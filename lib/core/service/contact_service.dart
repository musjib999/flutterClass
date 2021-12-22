import 'dart:io';

import 'package:api_flutter/shared/model/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ContactService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<ContactModel>> getAllContact() async {
    List<ContactModel> contactList = [];
    try {
      await firestore
          .collection('contacts')
          .orderBy('name')
          .get()
          .then((value) {
        List<QueryDocumentSnapshot<Map<String, dynamic>>> contacts = value.docs;
        for (var contact in contacts) {
          contactList.add(
            ContactModel(
              name: contact.data()['name'],
              email: contact.data()['email'],
              phone: contact.data()['phone'],
              image: contact.data()['image'],
            ),
          );
        }
      });
    } catch (e) {
      contactList.add(
        ContactModel(name: 'N/A', email: 'N/A', phone: 'N/A', image: 'N/A'),
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
            image: value.data()!['image'],
          );
        });
      });
    } catch (e) {
      contactModel =
          ContactModel(name: 'N/A', email: 'N/A', phone: 'N/A', image: 'N/A');
      throw 'Error occured $e';
    }
    return contactModel;
  }

  Stream<QuerySnapshot> getContactStream() {
    Stream<QuerySnapshot>? snapshot;
    try {
      snapshot = firestore.collection('contacts').orderBy('name').snapshots();
    } catch (e) {
      throw 'Error occured $e';
    }
    return snapshot;
  }

  Future<ContactModel?> getOneContact(String id) async {
    ContactModel? contact;
    try {
      await firestore.collection('contacts').doc(id).get().then((value) {
        contact = ContactModel(
          name: value.data()!['name'],
          email: value.data()!['email'],
          phone: value.data()!['phone'],
          image: value.data()!['image'],
        );
      });
    } catch (e) {
      contact =
          ContactModel(name: 'N/A', email: 'N/A', phone: 'N/A', image: 'N/A');
      throw 'Error occured $e';
    }
    return contact;
  }

  Future<bool?> deleteOneContact(String id) async {
    bool? isDeleted;
    try {
      await firestore.collection('contacts').doc(id).delete().then((value) {
        isDeleted = true;
      });
    } catch (e) {
      isDeleted = false;
      throw 'Error occured $e';
    }
    return isDeleted;
  }

  Future<bool?> updateContact(
      {required String id, required Map<String, dynamic> data}) async {
    bool? isUpdated;
    try {
      await firestore.collection('contacts').doc(id).update(data).then((value) {
        isUpdated = true;
      });
    } catch (e) {
      isUpdated = false;
      throw 'Error occured $e';
    }
    return isUpdated;
  }

  Future<int> savedImage({required String path, required File file}) async {
    int totalBytes = 0;
    await storage.ref(path).putFile(file).then((p0) {
      // ignore: avoid_print
      print('${p0.bytesTransferred} of ${p0.totalBytes}');
      totalBytes = p0.totalBytes;
    });
    return totalBytes;
  }

  Future<String?> getImageUrl(String path) async {
    String? url;
    await storage.ref(path).getDownloadURL().then((value) {
      url = value;
    });
    return url;
  }
}
