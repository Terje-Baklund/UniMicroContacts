import 'package:contacts/providers/contacts_provider.dart';
import 'package:contacts/providers/uni_authenticator.dart';
import 'package:contacts/screens/contacts_screen.dart';
import 'package:contacts/widgets/companies_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ChooseCompany extends StatelessWidget {
  const ChooseCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<UniAuthenticator>(context);
    auth.getCompanyKeys();
    return (auth.companyKey == null
        ? Scaffold(
            appBar: AppBar(
              actions: [
                FloatingActionButton(onPressed: () => auth.getCompanyKeys())
              ],
              title: const Text('Choose company'),
            ),
            body: CompaniesWidget(allCompanies: auth.allCompanies))
        : const Contacts());
  }
}
