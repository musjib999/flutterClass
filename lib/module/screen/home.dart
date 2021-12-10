import 'package:api_flutter/core/service_injector/service_injector.dart';
import 'package:api_flutter/module/screen/add_contact.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact App'),
      ),
      body: FutureBuilder<dynamic>(
        future: si.contactService.getAllContact(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.error),
                SizedBox(height: 15),
                Text('There is an error!!!')
              ],
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              String name = data[index].data()['name'];
              String phone = data[index].data()['phone'];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(name[0].toUpperCase()),
                ),
                title: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(phone),
              );
            },
            itemCount: snapshot.data!.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Divider(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddContactPage();
              },
            ),
          );
        },
        label: const Text('Add Contact'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
