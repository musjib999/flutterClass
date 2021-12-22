import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String selectedMoreOption = '';

class UtilityService {
  List<DropdownMenuItem> getDropdownItems(List items) {
    List<DropdownMenuItem> dropdowmItems = [];

    for (String item in items) {
      var newItem = DropdownMenuItem(child: Text(item), value: item);
      dropdowmItems.add(newItem);
    }
    return dropdowmItems;
  }

  Future<XFile?> getImage({required ImageSource imgSource}) async {
    XFile? file;
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: imgSource).then((value) {
      file = value;
    });
    return file;
  }
}
