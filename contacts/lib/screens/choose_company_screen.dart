import 'package:contacts/models/company.dart';
import 'package:contacts/providers/uni_authenticator.dart';
import 'package:contacts/widgets/company_widgets/companies_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseCompany extends StatelessWidget {
  const ChooseCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var futureCompanies =
        Provider.of<UniAuthenticator>(context, listen: false).getCompanyKeys();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Choose company'),
        ),
        body: FutureBuilder(
            future: futureCompanies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var companies = snapshot.data as List<Company>;
                return CompaniesWidget(allCompanies: companies);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
