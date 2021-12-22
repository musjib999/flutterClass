import 'dart:io';

import 'package:api_flutter/core/helper/file_upload.dart';
import 'package:api_flutter/core/service_injector/service_injector.dart';
import 'package:api_flutter/shared/model/contact_model.dart';
import 'package:api_flutter/shared/widget/button/primary_button.dart';
import 'package:api_flutter/shared/widget/form/text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditContactPage extends StatefulWidget {
  final String id;
  final ContactModel contact;
  const EditContactPage({Key? key, required this.id, required this.contact})
      : super(key: key);

  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  String imagePath = '';
  String imageUrl = '';
  bool isLoading = false;

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  final Helper _helper = Helper();

  @override
  void initState() {
    super.initState();
    setState(() {
      name.text = widget.contact.name;
      phone.text = widget.contact.phone;
      email.text = widget.contact.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> updatedContact = {
      'name': name.text,
      'email': email.text,
      'phone': phone.text,
      'image': '',
    };
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      await si.utilityService
                          .getImage(imgSource: ImageSource.gallery)
                          .then((file) {
                        setState(() {
                          imagePath = file!.path;
                        });
                      });
                    },
                    child: CircleAvatar(
                      child:
                          imagePath != '' ? null : const Icon(Icons.camera_alt),
                      radius: 40,
                      backgroundImage: FileImage(File(imagePath)),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                InputTextField(
                  controller: name,
                  hintText: widget.contact.name,
                  labelText: 'Name',
                  icon: Icons.person,
                ),
                const SizedBox(height: 15.0),
                InputTextField(
                  controller: phone,
                  hintText: widget.contact.phone,
                  labelText: 'Phone',
                  icon: Icons.phone,
                  maxLength: 11,
                ),
                const SizedBox(height: 15.0),
                InputTextField(
                  controller: email,
                  hintText: widget.contact.email,
                  labelText: 'email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 15),
                PrimaryButton(
                  title: 'Save',
                  onTap: (startLoading, stopLoading, btnState) {
                    startLoading();
                    if (imagePath == '') {
                      _helper
                          .updateContact(widget.id, updatedContact)
                          .then((value) {
                        stopLoading();
                        si.routerService.popScreen(context);
                      });
                    } else {
                      _helper.imageUpload(widget.id, imagePath).then((value) {
                        setState(() {
                          imageUrl = value;
                        });
                        _helper.updateContact(widget.id, {
                          'name': name.text,
                          'email': email.text,
                          'phone': phone.text,
                          'image': value,
                        }).then((value) {
                          stopLoading();
                          si.routerService.popScreen(context);
                        });
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
