import 'package:flutter/material.dart';

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
}
