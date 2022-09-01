import 'package:contacts/models/single_contact.dart';
import 'package:contacts/providers/contacts_provider.dart';
import 'package:contacts/widgets/company_widgets/company_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompaniesWidget extends StatelessWidget {
  CompaniesWidget({Key? key, required this.allCompanies}) : super(key: key);
  var allCompanies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allCompanies.length,
      itemBuilder: (context, index) {
        return CompanyWidget(companyMap: allCompanies[index]);
      },
    );
  }
}
