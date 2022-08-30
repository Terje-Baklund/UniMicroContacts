import 'dart:convert';
import 'dart:developer';

import 'package:contacts/models/company.dart';
import 'package:contacts/models/default_%20phone.dart';
import 'package:contacts/models/default_email.dart';
import 'package:contacts/models/info.dart';
import 'package:contacts/models/invoice_address.dart';
import 'package:contacts/models/single_contact.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart';

class ContactsProvider with ChangeNotifier {
  late String? accessToken;
  late String? companyKey;
  bool isLoading = false;

  List<SingleContact> _contacts = [];
  List<SingleContact> get contacts => _contacts;

  ContactsProvider({required this.accessToken, required this.companyKey});

  Future<List<SingleContact>> getContacts() async {
    isLoading = true;
    _contacts = [];
    var same = true;
    Uri url = Uri.parse(
        "https://test-api.softrig.com/api/biz/contacts?expand=Info,Info.InvoiceAddress,Info.DefaultPhone,Info.DefaultEmail,Info.DefaultAddress&hateoas=false&top=10");
    // http get request with header
    try {
      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json, text/plain, */*",
        "Authorization": "Bearer $accessToken",
        "CompanyKey": "$companyKey",
        "Access-Control-Allow-Origin": "*"
      });
      final extractedData = json.decode(response.body);
      var contactsId = _contacts.map((con) => con.id).toList();
      for (var contact in extractedData) {
        if (contactsId.contains(contact['ID'])) {
          break;
        }
        same = false;
        _contacts.add(fillInSingleContact(contact));
        print("Finished filling contact");
      }
      // isLoading = false;
      // if (same) return;
      // notifyListeners();
      return _contacts;
    } catch (error) {
      print(error);
    }
    return [];
  }

  SingleContact fillInSingleContact(contact) {
    print("Filling contact");
    return SingleContact(
      id: contact['ID'],
      infoId: contact['InfoID'],
      comment: contact['Comment'],
      info: Info(
        id: contact['Info']['ID'],
        defaultEmailId: contact['Info']['DefaultEmailID'],
        defaultPhoneId: contact['Info']['DefaultPhoneID'],
        invoiceAddressId: contact['Info']['InvoiceAddressID'],
        name: contact['Info']['Name'],
        defaultPhone: DefaultPhone(
          id: contact['Info']['DefaultPhone']['ID'],
          businessRelationId: contact['Info']['DefaultPhone']
              ['BusinessRelationID'],
          countryCode: contact['Info']['DefaultPhone']['CountryCode'],
          description: contact['Info']['DefaultPhone']['Description'],
          number: contact['Info']['DefaultPhone']['Number'],
          type: contact['Info']['DefaultPhone']['Type'],
        ),
        defaultEmail: DefaultEmail(
          id: contact['Info']['DefaultEmail']['ID'],
          businessRelationId: contact['Info']['DefaultEmail']
              ['BusinessRelationID'],
          deleted: contact['Info']['DefaultEmail']['Deleted'],
          description: contact['Info']['DefaultEmail']['Description'],
          emailAddress: contact['Info']['DefaultEmail']['EmailAddress'],
        ),
        invoiceAddress: InvoiceAddress(
          id: contact['Info']['InvoiceAddress']['ID'],
          addressLine1: contact['Info']['InvoiceAddress']['AddressLine1'],
          addressLine2: contact['Info']['InvoiceAddress']['AddressLine2'],
          addressLine3: contact['Info']['InvoiceAddress']['AddressLine3'],
          businessRelationId: contact['Info']['InvoiceAddress']
              ['BusinessRelationID'],
          city: contact['Info']['InvoiceAddress']['City'],
          country: contact['Info']['InvoiceAddress']['Country'],
          countryCode: contact['Info']['InvoiceAddress']['CountryCode'],
          postalCode: contact['Info']['InvoiceAddress']['PostalCode'],
          region: contact['Info']['InvoiceAddress']['Region'],
        ),
      ),
    );
  }

  Future<void> createContact(SingleContact newContact) async {
    print("creating new contact");
    Uri url = Uri.parse("https://test-api.softrig.com/api/biz/contacts");
    try {
      await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json text/plain, */*",
          "Authorization": "Bearer $accessToken",
          "CompanyKey": "$companyKey",
          "Access-Control-Allow-Origin": "*"
        },
        body: json.encode({
          "Comment": newContact.comment,
          "Info": {
            "Name": newContact.info.name,
            "DefaultPhone": {
              "CountryCode": newContact.info.defaultPhone.countryCode,
              "Number": newContact.info.defaultPhone.number,
              "Description": newContact.info.defaultPhone.description,
            },
            "DefaultEmail": {
              "EmailAddress": newContact.info.defaultEmail.emailAddress,
            },
            "InvoiceAddress": {
              "AddressLine1": newContact.info.invoiceAddress.addressLine1,
              "AddressLine2": newContact.info.invoiceAddress.addressLine2,
              "AddressLine3": newContact.info.invoiceAddress.addressLine3,
              "City": newContact.info.invoiceAddress.city,
              "Country": newContact.info.invoiceAddress.country,
              "CountryCode": newContact.info.invoiceAddress.countryCode,
              "PostalCode": newContact.info.invoiceAddress.postalCode,
            },
          },
        }),
      );
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteContact(id) async {
    print("deleting contact");
    Uri url = Uri.parse("https://test-api.softrig.com/api/biz/contacts/$id");
    try {
      var response = await http.delete(
        url,
        headers: {
          "Accept": "application/json text/plain, */*",
          "Authorization": "Bearer $accessToken",
          "CompanyKey": "$companyKey",
          "Access-Control-Allow-Origin": "*"
        },
      );
      notifyListeners();
      print("Deelete successful");
    } catch (error) {
      print(error);
    }
  }

  void notify() {
    notifyListeners();
  }
}
