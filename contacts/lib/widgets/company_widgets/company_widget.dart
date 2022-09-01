import 'package:contacts/providers/contacts_provider.dart';
import 'package:contacts/providers/uni_authenticator.dart';
import 'package:contacts/screens/contacts_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyWidget extends StatelessWidget {
  CompanyWidget({Key? key, required this.companyMap}) : super(key: key);

  var companyMap;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ElevatedButton(
          child: Text(
            companyMap.name,
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          onPressed: () => {
            Provider.of<UniAuthenticator>(context, listen: false)
                .setSelectedCompanyKey(companyMap.key),
            // navigator push Contacts
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Contacts()),
            )
          },
        ));
  }
}
