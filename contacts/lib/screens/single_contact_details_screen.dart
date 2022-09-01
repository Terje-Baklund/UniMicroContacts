import 'package:contacts/models/single_contact.dart';
import 'package:contacts/providers/contacts_provider.dart';
import 'package:contacts/screens/single_contact_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleContactDetails extends StatelessWidget {
  const SingleContactDetails({Key? key, required this.contactObject})
      : super(key: key);
  final SingleContact contactObject;

  void _editContact(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SingleContactUpdateScreen(
          contact: contactObject,
        ),
      ),
    );
  }

  void _deleteContact(BuildContext context) {
    Provider.of<ContactsProvider>(context, listen: false).deleteContact(
      contactObject.id,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ContactsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: 'edit_contact',
                child: Text("Edit contact"),
              ),
              // two step delete button
              PopupMenuItem(
                value: 'delete_contact',
                child: Text("Delete contact"),
              ),
            ],
            onSelected: (value) {
              if (value == 'edit_contact') {
                _editContact(context);
              }
              if (value == 'delete_contact') {
                showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Delete Account"),
                        content: const Text(
                            "Are you sure you want to delete this contact?"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text("Delete"),
                            onPressed: () {
                              _deleteContact(context);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              }
              ;
            },
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.blue),
            height: 250,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // user icon
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 120,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(contactObject.info?.name ?? "Null",
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                  SizedBox(height: 10),
                  Text(
                    contactObject.comment,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          // contact details
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text("Name"),
                  subtitle: Text(contactObject.info?.name ?? "Null"),
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    launchURL(
                        "mailto:${contactObject.info?.defaultEmail?.emailAddress ?? "Null"}");
                  },
                  child: ListTile(
                    title: Text("Email"),
                    subtitle: Text(
                        contactObject.info?.defaultEmail?.emailAddress ??
                            "Null"),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    launchURL(
                        "tel:${contactObject.info?.defaultPhone?.number ?? "Null"}");
                  },
                  child: ListTile(
                    title: Text(contactObject.info?.defaultPhone?.description ??
                        "Null"),
                    subtitle: Row(
                      children: [
                        Text(
                            "(${contactObject.info?.defaultPhone?.countryCode})"),
                        Text(
                            contactObject.info?.defaultPhone?.number ?? "Null"),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Location"),
                  subtitle: Row(
                    children: [
                      Text("${contactObject.info?.invoiceAddress?.city}"),
                      Text(
                          ", ${contactObject.info?.invoiceAddress?.country} ${contactObject.info?.invoiceAddress?.countryCode}"),
                    ],
                  ),
                ),
                ListTile(
                  title: Text("Address"),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(contactObject
                                  .info?.invoiceAddress?.addressLine1 ??
                              "Null"),
                          Text(contactObject
                                  .info?.invoiceAddress?.addressLine2 ??
                              "Null"),
                          Text(contactObject
                                  .info?.invoiceAddress?.addressLine3 ??
                              "Null"),
                        ],
                      ),
                      Text("${contactObject.info?.invoiceAddress?.postalCode}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> launchURL(String inUrl) async {
    var url = Uri.parse(inUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
