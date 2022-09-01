import 'package:contacts/models/single_contact.dart';
import 'package:contacts/widgets/contact_widgets/create_or_update_contact_widget.dart';
import 'package:flutter/material.dart';

class CreateContact extends StatefulWidget {
  CreateContact({Key? key}) : super(key: key);

  @override
  State<CreateContact> createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
  final formKey = GlobalKey<FormState>();
  SingleContact newContact = SingleContact.dummy();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Contact"),
      ),
      resizeToAvoidBottomInset: true,
      body: CreateOrUpdateContact(
        contact: newContact,
        update: false,
      ),
    );
  }
}
