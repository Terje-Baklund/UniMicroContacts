import 'package:contacts/providers/contacts_provider.dart';
import 'package:contacts/providers/uni_authenticator.dart';
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
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ElevatedButton(
          child: Text(companyMap.name),
          onPressed: () => {
            Provider.of<UniAuthenticator>(context, listen: false)
                .setSelectedCompanyKey(companyMap.key),
          },
        ));
    // GestureDetector(
    //   onTap: () => {
    //     Provider.of<UniAuthenticator>(context, listen: false)
    //         .setSelectedCompanyKey(companyMap.key),
    //   },
    //   child: Padding(
    //     padding: EdgeInsets.all(20),
    //     child: Text(
    //       "${companyMap.name} Hello",
    //       style: TextStyle(fontSize: 20, color: Colors.white),
    //     ),
    //   ),
    // ));
  }
}
