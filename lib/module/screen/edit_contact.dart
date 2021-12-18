import 'package:api_flutter/core/service_injector/service_injector.dart';
import 'package:api_flutter/shared/model/contact_model.dart';
import 'package:api_flutter/shared/widget/form/text_field.dart';
import 'package:flutter/material.dart';

class EditContactPage extends StatefulWidget {
  final String id;
  final ContactModel contact;
  const EditContactPage({Key? key, required this.id, required this.contact})
      : super(key: key);

  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  bool isLoading = false;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                const Center(
                  child: CircleAvatar(
                    child: Icon(Icons.camera_alt),
                    radius: 40,
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
                MaterialButton(
                  onPressed: () async {
                    Map<String, dynamic> updatedContact = {
                      'name': name.text,
                      'email': email.text,
                      'phone': phone.text,
                    };
                    isLoading = true;
                    si.contactService
                        .updateContact(id: widget.id, data: updatedContact)
                        .then((value) {
                      if (value == true) {
                        isLoading = false;
                        si.routerService.popScreen(context);
                      }
                    });
                  },
                  child: isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
