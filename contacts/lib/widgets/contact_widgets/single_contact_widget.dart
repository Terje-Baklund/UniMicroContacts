import 'package:contacts/models/single_contact.dart';
import 'package:contacts/providers/contacts_provider.dart';
import 'package:contacts/screens/single_contact_details_screen.dart';
import 'package:contacts/screens/single_contact_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleContactWidget extends StatefulWidget {
  SingleContactWidget({Key? key, required this.contactObject})
      : super(key: key);

  @override
  State<SingleContactWidget> createState() => _SingleContactWidgetState();
  SingleContact contactObject;
}

class _SingleContactWidgetState extends State<SingleContactWidget> {
  void _callDeleteContact({required id}) {
    Provider.of<ContactsProvider>(context, listen: false).deleteContact(id);
  }

  void _callEditContact({required id}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            SingleContactUpdateScreen(contact: widget.contactObject),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var contactObject = widget.contactObject;
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SingleContactDetails(
              contactObject: contactObject,
            ),
          ),
        ),
      },
      child: Container(
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 178, 216, 248),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: ListTile(
              style: ListTileStyle.list,
              title: Text(contactObject.info?.name ?? "Null"),
              subtitle: Text(
                  contactObject.info?.defaultEmail?.emailAddress ?? "Null"),
              leading: CircleAvatar(
                child: Text(contactObject.info?.name?[0] ?? "Null"),
              ),
              trailing: DropdownButtonHideUnderline(
                child: DropdownButton(
                  items: const [
                    DropdownMenuItem(child: Text("Edit"), value: "edit"),
                    DropdownMenuItem(child: Text("Delete"), value: "delete"),
                  ],
                  onChanged: (value) {
                    switch (value) {
                      case "delete":
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
                                      _callDeleteContact(id: contactObject.id);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });

                        break;
                      case "edit":
                        _callEditContact(id: contactObject.id);
                    }
                  },
                ),
              ))),
    );
    // PopupMenuButton(
    //   icon: const Icon(Icons.filter_list),
    //   itemBuilder: (context) => [
    //     const PopupMenuItem(
    //       value: 'edit',
    //       child: Text('Edit'),
    //     ),
    //     const PopupMenuItem(
    //       value: 'delete',
    //       child: Text('Delete'),
    //     ),
    //   ],
    //   onSelected: (value) {
    //     switch (value) {
    //       case 'delete':
    //         Provider.of<ContactsProvider>(context, listen: false)
    //             .deleteContact(contactObject.id);
    //         break;
    //     }
    //   },
    // )));
  }
}
