import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: Form(
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'John Doe',
                  label: Text('Name'),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 15.0),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '08012345678',
                  label: Text('Phone'),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 15.0),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'johndoe@gmail.com',
                  label: Text('email'),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: () {},
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
