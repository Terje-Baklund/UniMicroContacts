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

class CreateOrUpdateContact extends StatefulWidget {
  CreateOrUpdateContact({Key? key, required this.contact, required this.update})
      : super(key: key);
  final SingleContact contact;
  final bool update;
  @override
  State<CreateOrUpdateContact> createState() => _CreateOrUpdateContactState();
}

class _CreateOrUpdateContactState extends State<CreateOrUpdateContact> {
  final formKey = GlobalKey<FormState>();
  List<String> descriptions = ["Mobile", "Home", "Work"];
  late String selectedDescription =
      widget.contact.info?.defaultPhone?.description ?? "Null";

  late SingleContact updatedContact = widget.contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            buildName(),
            const SizedBox(height: 14),
            buildEmail(),
            const SizedBox(height: 14),
            buildAddressLine(
                addressLine: 1,
                hintText: "Address Line 1",
                initialValue: widget.contact.info?.invoiceAddress?.addressLine1,
                validate: true),
            const SizedBox(height: 14),
            buildAddressLine(
                addressLine: 2,
                hintText: "Address Line 2 (Optional)",
                initialValue: widget.contact.info?.invoiceAddress?.addressLine2,
                validate: false),
            const SizedBox(height: 14),
            buildAddressLine(
                addressLine: 3,
                hintText: "Address Line 3 (Optional)",
                initialValue: widget.contact.info?.invoiceAddress?.addressLine3,
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
    );
  }

  Widget buildName() {
    return Column(
      children: [
        Text(
          "Name",
          style: TextStyle(fontSize: 18),
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Full Name",
          ),
          initialValue: widget.contact.info?.name,
          validator: (value) {
            if (value == "") {
              return 'Please enter a name';
            }
            return null;
          },
          onChanged: (value) =>
              setState(() => updatedContact.info!.name = value),
        ),
      ],
    );
  }

  Widget buildAddressLine(
      {required addressLine,
      required hintText,
      required initialValue,
      required validate}) {
    return Column(
      children: [
        Text(
          hintText,
          style: TextStyle(fontSize: 18),
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
          ),
          initialValue: initialValue,
          validator: (value) {
            if (validate) {
              if (value == "") {
                return 'Please enter an addresse';
              }
              return null;
            }
          },
          onChanged: (value) => setState(() {
            switch (addressLine) {
              case 1:
                updatedContact.info!.invoiceAddress!.addressLine1 = value;
                break;
              case 2:
                updatedContact.info!.invoiceAddress!.addressLine2 = value;
                break;
              case 3:
                updatedContact.info!.invoiceAddress!.addressLine3 = value;
                break;
            }
          }),
        )
      ],
    );
  }

  Widget buildCity() {
    return Column(
      children: [
        Text(
          "City",
          style: TextStyle(fontSize: 18),
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "City",
          ),
          initialValue: widget.contact.info?.invoiceAddress?.city,
          validator: (value) {
            if (value == "") {
              return 'Please enter a city';
            }
            return null;
          },
          onChanged: (value) =>
              setState(() => updatedContact.info!.invoiceAddress!.city = value),
        ),
      ],
    );
  }

  Widget buildCountry() {
    return Column(
      children: [
        Text(
          "Country",
          style: TextStyle(fontSize: 18),
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Country",
          ),
          initialValue: widget.contact.info?.invoiceAddress?.country,
          validator: (value) {
            if (value == "") {
              return 'Please enter a country';
            }
            return null;
          },
          onChanged: (value) => setState(
              () => updatedContact.info!.invoiceAddress!.country = value),
        ),
      ],
    );
  }

  Widget buildCountryCode() {
    return Column(
      children: [
        Text(
          "Country Code",
          style: TextStyle(fontSize: 18),
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Country Code",
          ),
          initialValue: widget.contact.info?.invoiceAddress?.countryCode,
          validator: (value) {
            if (value == "") {
              return 'Please enter a country code';
            }
            return null;
          },
          onChanged: (value) => setState(
              () => updatedContact.info!.invoiceAddress!.countryCode = value),
        ),
      ],
    );
  }

  Widget buildPostalCode() {
    return Column(
      children: [
        Text(
          "Postal Code",
          style: TextStyle(fontSize: 18),
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Postal Code",
          ),
          initialValue: widget.contact.info?.invoiceAddress?.postalCode,
          validator: (value) {
            if (value == "") {
              return 'Please enter a postal code';
            }
            return null;
          },
          onChanged: (value) => setState(
              () => updatedContact.info!.invoiceAddress!.postalCode = value),
        ),
      ],
    );
  }

  Widget buildPhoneCountryCode() {
    return Column(
      children: [
        Text(
          "Phone Country Code",
          style: TextStyle(fontSize: 18),
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "+47",
          ),
          initialValue: widget.contact.info?.defaultPhone?.countryCode,
          validator: (value) {
            final pattern = r'^(?:[+])[0-9]', regex = RegExp(pattern);
            if (value == "" || value!.length > 4 || !regex.hasMatch(value)) {
              return 'Please enter a valid phone number';
            }
            return null;
          },
          onChanged: (value) => setState(
              () => updatedContact.info!.defaultPhone!.countryCode = value),
        ),
      ],
    );
  }

  Widget buildPhoneDescription() {
    return Column(
      children: [
        Text(
          "Phone Description",
          style: TextStyle(fontSize: 18),
        ),
        InputDecorator(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(5),
            border: OutlineInputBorder(),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedDescription,
              items: descriptions
                  .map(
                    (item) => DropdownMenuItem<String>(
                        value: item, child: Text(item)),
                  )
                  .toList(),
              onChanged: (value) => setState(() {
                selectedDescription = value!;
                updatedContact.info!.defaultPhone!.description =
                    selectedDescription;
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPhoneNumber() {
    return Column(
      children: [
        Text(
          "Phone Number",
          style: TextStyle(fontSize: 18),
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "5599885533",
          ),
          initialValue: widget.contact.info?.defaultPhone?.number,
          validator: (value) {
            final pattern = r'^[0-9]*$', regex = new RegExp(pattern);
            if (value == "" || value!.length > 15 || !regex.hasMatch((value))) {
              return 'Please enter a valid phone number';
            }
            return null;
          },
          onChanged: (value) =>
              setState(() => updatedContact.info!.defaultPhone!.number = value),
        ),
      ],
    );
  }

  Widget buildEmail() {
    return Column(
      children: [
        Text(
          "Email",
          style: TextStyle(fontSize: 18),
        ),
        TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Donald.Duck@duckmail.com"),
            initialValue: widget.contact.info?.defaultEmail?.emailAddress,
            validator: (value) {
              final pattern =
                  r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
              final regExp = RegExp(pattern);
              if (!regExp.hasMatch(value ?? "")) {
                return 'Please enter a valid Email';
              }
            },
            onChanged: (value) => setState(
                () => updatedContact.info!.defaultEmail!.emailAddress = value)),
      ],
    );
  }

  Widget buildComment() {
    return Column(
      children: [
        Text(
          "Comment",
          style: TextStyle(fontSize: 18),
        ),
        TextFormField(
          maxLines: 3,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Comment",
          ),
          initialValue: widget.contact.comment,
          onChanged: (value) => setState(() => updatedContact.comment = value),
        ),
      ],
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      child: (widget.update ? Text("Update") : Text("Create")),
      onPressed: () {
        final isValid = formKey.currentState!.validate();
        if (isValid) {
          if (widget.update) {
            Provider.of<ContactsProvider>(context, listen: false)
                .updateContact(updatedContact);
          } else {
            Provider.of<ContactsProvider>(context, listen: false)
                .createContact(updatedContact);
          }
          Navigator.pop(context);
        }
      },
    );
  }
}
