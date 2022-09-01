import 'package:contacts/models/default_%20phone.dart';
import 'package:contacts/models/default_email.dart';
import 'package:contacts/models/info.dart';
import 'package:contacts/models/invoice_address.dart';
import 'package:contacts/models/single_contact.dart';
import 'package:contacts/providers/contacts_provider.dart';
import 'package:contacts/widgets/contact_widgets/create_or_update_contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SingleContactUpdateScreen extends StatefulWidget {
  const SingleContactUpdateScreen({Key? key, required this.contact})
      : super(key: key);
  final SingleContact contact;
  @override
  State<SingleContactUpdateScreen> createState() =>
      _SingleContactUpdateScreenState();
}

class _SingleContactUpdateScreenState extends State<SingleContactUpdateScreen> {
  final formKey = GlobalKey<FormState>();

  late SingleContact updatedContact = widget.contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update Contact"),
        ),
        resizeToAvoidBottomInset: true,
        body: CreateOrUpdateContact(contact: widget.contact, update: true));
  }
}
