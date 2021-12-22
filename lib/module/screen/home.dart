import 'package:api_flutter/core/service_injector/service_injector.dart';
import 'package:api_flutter/module/screen/add_contact.dart';
import 'package:api_flutter/module/screen/single_contact.dart';
import 'package:api_flutter/shared/model/contact_model.dart';
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
      body: StreamBuilder<dynamic>(
        stream: si.contactService.getContactStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
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
          final data = snapshot.data!.docs;
          return data.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.person_off,
                        size: 45.0,
                      ),
                      SizedBox(height: 15),
                      Text('No Contact added Yet!!!'),
                    ],
                  ),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    String id = data[index].id;
                    ContactModel contact = ContactModel(
                      phone: data[index].data()['phone'],
                      name: data[index].data()['name'],
                      email: data[index].data()['email'],
                      image: data[index].data()['image'],
                    );
                    return ListTile(
                      leading: CircleAvatar(
                        child: contact.image == ''
                            ? Text(
                                contact.name[0].toUpperCase(),
                              )
                            : null,
                        backgroundImage: NetworkImage(contact.image),
                      ),
                      title: Text(
                        contact.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(contact.phone),
                      onTap: () => si.routerService.nextScreen(
                        context,
                        SingleContactPage(id: id),
                      ),
                    );
                  },
                  itemCount: data.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                    child: Divider(),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => si.routerService.nextScreen(
          context,
          const AddContactPage(),
        ),
        label: const Text('Add Contact'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
