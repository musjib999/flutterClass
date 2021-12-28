import 'package:api_flutter/core/service_injector/service_injector.dart';
import 'package:api_flutter/module/screen/edit_contact.dart';
import 'package:api_flutter/shared/model/contact_model.dart';
import 'package:api_flutter/shared/widget/card/primary_card.dart';
import 'package:flutter/material.dart';

class SingleContactPage extends StatefulWidget {
  final String id;
  const SingleContactPage({Key? key, required this.id}) : super(key: key);

  @override
  _SingleContactPageState createState() => _SingleContactPageState();
}

class _SingleContactPageState extends State<SingleContactPage> {
  List moreOptions = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: si.contactService.getOneContact(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          ContactModel contact = ContactModel(
            phone: snapshot.data.phone,
            name: snapshot.data.name,
            email: snapshot.data.email,
            image: snapshot.data.image,
          );
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: DropdownButton<dynamic>(
                    items:
                        si.utilityService.getDropdownItems(['Edit', 'Delete']),
                    onChanged: (value) {
                      if (value == 'Edit') {
                        si.routerService.nextScreen(
                          context,
                          EditContactPage(
                            id: widget.id,
                            contact: contact,
                          ),
                        );
                      } else {
                        si.firebaseService
                            .deleteDoc(collection: 'contacts', id: widget.id)
                            .then((value) {
                          if (value == true) {
                            si.routerService.popScreen(context);
                          }
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    underline: Container(),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.grey[200],
            body: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 25.0),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      child: Text(
                        contact.image == ''
                            ? contact.name[0].toUpperCase()
                            : '',
                        style: const TextStyle(fontSize: 40),
                      ),
                      radius: 40,
                      backgroundImage: NetworkImage(contact.image),
                    ),
                  ),
                  const SizedBox(height: 5),
                  PrimaryCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          contact.name,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Phone ',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 15.0,
                              ),
                            ),
                            InkWell(
                              child: Text(
                                contact.phone,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  PrimaryCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            'E-mail ',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            contact.email,
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          trailing: const Icon(Icons.email),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
