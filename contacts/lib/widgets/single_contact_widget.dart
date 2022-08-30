import 'package:contacts/models/single_contact.dart';
import 'package:contacts/providers/contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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

  @override
  Widget build(BuildContext context) {
    var contactObject = widget.contactObject;
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 178, 216, 248),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 5,
          //     blurRadius: 7,
          //     offset: Offset(0, 3), // changes position of shadow
          //   ),
          // ],
        ),
        child: ListTile(
            style: ListTileStyle.list,
            title: Text(contactObject.info.name),
            subtitle: Text(contactObject.info.defaultEmail.emailAddress),
            leading: CircleAvatar(
              child: Text(contactObject.info.name[0]),
            ),
            trailing: DropdownButton(
              items: const [
                DropdownMenuItem(child: Text("Edit"), value: "edit"),
                DropdownMenuItem(child: Text("Delete"), value: "delete"),
              ],
              onChanged: (value) {
                switch (value) {
                  case "delete":
                    _callDeleteContact(id: contactObject.id);
                    break;
                }
              },
            )));
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
