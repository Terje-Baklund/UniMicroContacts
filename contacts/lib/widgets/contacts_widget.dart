import 'package:contacts/models/single_contact.dart';
import 'package:contacts/providers/contacts_provider.dart';
import 'package:contacts/widgets/single_contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ContactsWidget extends StatefulWidget {
  ContactsWidget({Key? key}) : super(key: key);

  @override
  State<ContactsWidget> createState() => _ContactsWidgetState();
}

class _ContactsWidgetState extends State<ContactsWidget> {
  var futureContacts;

  @override
  void initState() {
    super.initState();
    // var contactProvider = Provider.of<ContactsProvider>(context);
    // futureContacts = contactProvider.getContacts();
  }

  @override
  Widget build(BuildContext context) {
    var contacts =
        Provider.of<ContactsProvider>(context, listen: false).getContacts();
    return FutureBuilder(
        future: contacts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var contacts = snapshot.data! as List<SingleContact>;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return SingleContactWidget(contactObject: contacts[index]);
              },
            );
          } else {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
          // var contacts = snapshot.data;
          // return ListView.builder(
          //   itemCount: contacts.length,
          //   itemBuilder: (context, index) {
          //     return SingleContactWidget(contactObject: contacts[index]);
          //   },
          // );
        });
  }
}
