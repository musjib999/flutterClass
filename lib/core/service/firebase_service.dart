import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getAllDoc(String collection) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? documets;
    try {
      await firestore
          .collection(collection)
          .orderBy('name')
          .get()
          .then((value) {
        documets = value.docs;
      });
    } catch (e) {
      documets = [];
      throw 'Error occured $e';
    }
    return documets;
  }

  Future getOneDoc({required String collection, required String id}) async {
    DocumentSnapshot<Map<String, dynamic>>? document;
    try {
      await firestore.collection(collection).doc(id).get().then((value) {
        document = value;
      });
    } catch (e) {
      throw 'Error occured $e';
    }
    return document;
  }

  Future addDoc(
      {required String collection, required Map<String, dynamic> data}) async {
    DocumentReference<Map<String, dynamic>>? document;
    try {
      await firestore.collection(collection).add(data).then((value) {
        document = value;
      });
    } catch (e) {
      throw 'Error occured $e';
    }
    return document;
  }

  Future<bool?> updateDoc(
      {required String collection,
      required String id,
      required Map<String, dynamic> data}) async {
    bool? isUpdated;
    try {
      await firestore.collection(collection).doc(id).update(data).then((value) {
        isUpdated = true;
      });
    } catch (e) {
      isUpdated = false;
      throw 'Error occured $e';
    }
    return isUpdated;
  }

  Stream<QuerySnapshot> getDocStream(String collection) {
    Stream<QuerySnapshot>? snapshot;
    try {
      snapshot = firestore.collection(collection).orderBy('name').snapshots();
    } catch (e) {
      throw 'Error occured $e';
    }
    return snapshot;
  }

  Future<bool?> deleteDoc(
      {required String collection, required String id}) async {
    bool? isDeleted;
    try {
      await firestore.collection(collection).doc(id).delete().then((value) {
        isDeleted = true;
      });
    } catch (e) {
      isDeleted = false;
      throw 'Error occured $e';
    }
    return isDeleted;
  }
}
