import 'package:api_flutter/core/service_injector/service_injector.dart';
import 'package:api_flutter/shared/widget/text_field.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InputTextField(
                  controller: name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  hintText: 'John Doe',
                  labelText: 'Name',
                  icon: Icons.person,
                ),
                const SizedBox(height: 15.0),
                InputTextField(
                  controller: phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Phone number is required';
                    } else if (value.length < 11) {
                      return 'Invalid phone number';
                    }
                    return null;
                  },
                  hintText: '08012345678',
                  labelText: 'Phone',
                  icon: Icons.phone,
                  maxLength: 11,
                ),
                const SizedBox(height: 15.0),
                InputTextField(
                  controller: email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    } else if (!value.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  hintText: 'johndoe@gmail.com',
                  labelText: 'email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 15),
                MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        isLoading = true;
                      });
                      Map<String, dynamic> contact = {
                        'name': name.text,
                        'phone': phone.text,
                        'email': email.text
                      };

                      await si.contactService.addContact(contact).then(
                        (value) {
                          setState(() {
                            isLoading = false;
                          });
                          si.dialogService
                              .showToaster('${name.text} has been saved');
                          name.clear();
                          phone.clear();
                          email.clear();
                        },
                      );
                    }
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
