import 'package:contacts/models/single_contact.dart';
import 'package:contacts/providers/contacts_provider.dart';
import 'package:contacts/screens/create_contact_screen.dart';
import 'package:contacts/widgets/contact_widgets/contacts_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contacts extends StatelessWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contactProvider = Provider.of<ContactsProvider>(context);
    var futureContacts = contactProvider.getContacts();
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'create_contact',
                  child: Text("Create new contact"),
                ),
              ],
              onSelected: (value) {
                if (value == 'create_contact') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreateContact(),
                    ),
                  );
                }
              },
            ),
          ],
          title: const Text('Contacts'),
        ),
        body: FutureBuilder(
            future: futureContacts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var contacts = snapshot.data as List<SingleContact>;
                return ContactsWidget(
                  incomingContacts: contacts,
                  key: UniqueKey(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
