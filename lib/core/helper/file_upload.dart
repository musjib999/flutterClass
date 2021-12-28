import 'dart:io';

import 'package:api_flutter/core/service_injector/service_injector.dart';

class Helper {
  Future<String> imageUpload(String imageId, String imagePath) async {
    String imageUrl = '';
    await si.contactService
        .savedImage(
      path: '$imageId.png',
      file: File(imagePath),
    )
        .then((value) async {
      await si.contactService
          .getImageUrl(
        '$imageId.png',
      )
          .then((value) {
        imageUrl = value!;
      });
    });
    return imageUrl;
  }

  Future updateContact(
    String id,
    Map<String, dynamic> updatedContact,
  ) async {
    await si.firebaseService
        .updateDoc(collection: 'contacts', id: id, data: updatedContact);
  }
}
