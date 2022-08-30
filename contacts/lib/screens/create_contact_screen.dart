import 'package:contacts/models/default_%20phone.dart';
import 'package:contacts/models/default_email.dart';
import 'package:contacts/models/info.dart';
import 'package:contacts/models/invoice_address.dart';
import 'package:contacts/models/single_contact.dart';
import 'package:contacts/providers/contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class CreateContact extends StatefulWidget {
  CreateContact({Key? key}) : super(key: key);

  @override
  State<CreateContact> createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
  final formKey = GlobalKey<FormState>();
  List<String> descriptions = ["Mobile Phone", "Home Phone", "Work Phone"];
  String selectedDescription = "Mobile Phone";
  SingleContact newContact = SingleContact(
    comment: "",
    info: Info(
      name: "",
      defaultPhone: DefaultPhone(countryCode: "", description: "", number: ""),
      defaultEmail: DefaultEmail(emailAddress: ""),
      invoiceAddress: InvoiceAddress(
          addressLine1: "",
          addressLine2: "",
          addressLine3: "",
          city: "",
          country: "",
          countryCode: "",
          postalCode: ""),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Contact"),
        ),
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                buildName(),
                const SizedBox(height: 14),
                buildEmail(),
                const SizedBox(height: 14),
                buildAddressLine(newContact.info.invoiceAddress.addressLine1,
                    "Address Line 1",
                    validate: true),
                const SizedBox(height: 14),
                buildAddressLine(newContact.info.invoiceAddress.addressLine2,
                    "Address Line 2 (Optional)",
                    validate: false),
                const SizedBox(height: 14),
                buildAddressLine(newContact.info.invoiceAddress.addressLine3,
                    "Address Line 3 (Optional)",
                    validate: false),
                const SizedBox(height: 14),
                buildCity(),
                const SizedBox(height: 14),
                buildCountry(),
                const SizedBox(height: 14),
                buildPostalCode(),
                const SizedBox(height: 14),
                buildCountryCode(),
                const SizedBox(height: 14),
                buildPhoneCountryCode(),
                const SizedBox(height: 14),
                buildPhoneDescription(),
                const SizedBox(height: 14),
                buildPhoneNumber(),
                const SizedBox(height: 14),
                buildComment(),
                const SizedBox(height: 14),
                buildSubmitButton(),
              ],
            ),
          ),
        ));
  }

  Widget buildName() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Full Name",
      ),
      validator: (value) {
        if (value == "") {
          return 'Please enter a name';
        }
        return null;
      },
      onChanged: (value) => setState(() => newContact.info.name = value),
    );
  }

  Widget buildAddressLine(addressLine, hintText, {required validate}) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
      validator: (value) {
        if (validate) {
          if (value == "") {
            return 'Please enter an addresse';
          }
          return null;
        }
      },
      onChanged: (value) => setState(() => addressLine = value),
    );
  }

  Widget buildCity() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "City",
      ),
      validator: (value) {
        if (value == "") {
          return 'Please enter a city';
        }
        return null;
      },
      onChanged: (value) =>
          setState(() => newContact.info.invoiceAddress.city = value),
    );
  }

  Widget buildCountry() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Country",
      ),
      validator: (value) {
        if (value == "") {
          return 'Please enter a country';
        }
        return null;
      },
      onChanged: (value) =>
          setState(() => newContact.info.invoiceAddress.country = value),
    );
  }

  Widget buildCountryCode() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Country Code",
      ),
      validator: (value) {
        if (value == "") {
          return 'Please enter a country code';
        }
        return null;
      },
      onChanged: (value) =>
          setState(() => newContact.info.invoiceAddress.countryCode = value),
    );
  }

  Widget buildPostalCode() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Postal Code",
      ),
      validator: (value) {
        if (value == "") {
          return 'Please enter a postal code';
        }
        return null;
      },
      onChanged: (value) =>
          setState(() => newContact.info.invoiceAddress.postalCode = value),
    );
  }

  Widget buildPhoneCountryCode() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Country Phone Code",
      ),
      validator: (value) {
        if (value == "") {
          return 'Please enter a country phone code';
        }
        return null;
      },
      onChanged: (value) =>
          setState(() => newContact.info.defaultPhone.countryCode = value),
    );
  }

  Widget buildPhoneDescription() {
    return InputDecorator(
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(5),
        border: OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedDescription,
          items: descriptions
              .map(
                (item) =>
                    DropdownMenuItem<String>(value: item, child: Text(item)),
              )
              .toList(),
          onChanged: (value) => setState(() {
            selectedDescription = value!;
            newContact.info.defaultPhone.description = selectedDescription;
          }),
        ),
      ),
    );
  }

  Widget buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "999-999-999",
      ),
      validator: (value) {
        if (value == "" || value!.length > 15) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
      onChanged: (value) =>
          setState(() => newContact.info.defaultPhone.number = value),
    );
  }

  Widget buildEmail() {
    return TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(), hintText: "Donald.Duck@duckmail.com"),
        validator: (value) {
          final pattern =
              r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
          final regExp = RegExp(pattern);
          if (!regExp.hasMatch(value ?? "")) {
            return 'Please enter a valid Email';
          }
        },
        onChanged: (value) =>
            setState(() => newContact.info.defaultEmail.emailAddress = value));
  }

  Widget buildComment() {
    return TextFormField(
      maxLines: 3,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Comment",
      ),
      onChanged: (value) => setState(() => newContact.comment = value),
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      child: Text("Submit"),
      onPressed: () {
        final isValid = formKey.currentState!.validate();
        if (isValid) {
          Provider.of<ContactsProvider>(context, listen: false)
              .createContact(newContact);
          Navigator.pop(context);
        }
      },
    );
  }
}
