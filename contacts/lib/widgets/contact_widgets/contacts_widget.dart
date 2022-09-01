import 'package:contacts/models/single_contact.dart';
import 'package:contacts/providers/contacts_provider.dart';
import 'package:contacts/widgets/contact_widgets/single_contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ContactsWidget extends StatefulWidget {
  ContactsWidget({Key? key, required this.incomingContacts}) : super(key: key);
  List<SingleContact> incomingContacts;

  @override
  State<ContactsWidget> createState() => _ContactsWidgetState();
}

class _ContactsWidgetState extends State<ContactsWidget> {
  late List<SingleContact> contacts;

  @override
  void initState() {
    super.initState();
    contacts = widget.incomingContacts;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              contacts = widget.incomingContacts
                  .where((contact) =>
                      (contact.info?.name?.toLowerCase() ?? "Null")
                          .contains(value.toLowerCase()))
                  .toList();
            });
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return SingleContactWidget(contactObject: contacts[index]);
            },
          ),
        )
      ],
    );
  }
}
