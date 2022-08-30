import 'package:contacts/providers/contacts_provider.dart';
import 'package:contacts/screens/create_contact_screen.dart';
import 'package:contacts/widgets/contacts_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Contacts extends StatelessWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contactProvider = Provider.of<ContactsProvider>(context);
    print("Contacts screen");
    //contactProvider.getContacts();
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
            FloatingActionButton(onPressed: () => contactProvider.notify())
          ],
          title: const Text('Contacts'),
        ),
        body: ContactsWidget());
  }
}
