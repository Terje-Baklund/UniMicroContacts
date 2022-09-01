import 'dart:convert';
import 'package:contacts/models/single_contact.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        _contacts.add(SingleContact.jsonToSingleContact(contact));
      }
      return _contacts;
    } catch (error) {
      print(error);
    }
    return [];
  }

  Future<void> createContact(SingleContact newContact) async {
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
            "Name": newContact.info!.name,
            "DefaultPhone": {
              "CountryCode": newContact.info!.defaultPhone!.countryCode,
              "Number": newContact.info!.defaultPhone!.number,
              "Description": newContact.info!.defaultPhone!.description,
            },
            "DefaultEmail": {
              "EmailAddress": newContact.info!.defaultEmail!.emailAddress,
            },
            "InvoiceAddress": {
              "AddressLine1": newContact.info!.invoiceAddress!.addressLine1,
              "AddressLine2": newContact.info!.invoiceAddress!.addressLine2,
              "AddressLine3": newContact.info!.invoiceAddress!.addressLine3,
              "City": newContact.info!.invoiceAddress!.city,
              "Country": newContact.info!.invoiceAddress!.country,
              "CountryCode": newContact.info!.invoiceAddress!.countryCode,
              "PostalCode": newContact.info!.invoiceAddress!.postalCode,
            },
          },
        }),
      );
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateContact(SingleContact updatedContact) async {
    Uri url = Uri.parse(
        "https://test-api.softrig.com/api/biz/contacts/${updatedContact.id}");
    try {
      await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json text/plain, */*",
          "Authorization": "Bearer $accessToken",
          "CompanyKey": "$companyKey",
          "Access-Control-Allow-Origin": "*"
        },
        body: json.encode({
          "Comment": updatedContact.comment,
          "ID": updatedContact.id,
          "InfoID": updatedContact.infoId,
          "Info": {
            "ID": updatedContact.info!.id,
            "DefaultEmailID": updatedContact.info!.defaultEmailId,
            "DefaultPhoneID": updatedContact.info!.defaultPhoneId,
            "InvoiceAddressID": updatedContact.info!.invoiceAddressId,
            "Name": updatedContact.info!.name,
            "DefaultPhone": {
              "ID": updatedContact.info!.defaultPhone!.id,
              "CountryCode": updatedContact.info!.defaultPhone!.countryCode,
              "Number": updatedContact.info!.defaultPhone!.number,
              "Description": updatedContact.info!.defaultPhone!.description,
            },
            "DefaultEmail": {
              "ID": updatedContact.info!.defaultEmail!.id,
              "EmailAddress": updatedContact.info!.defaultEmail!.emailAddress,
            },
            "InvoiceAddress": {
              "ID": updatedContact.info!.invoiceAddress!.id,
              "AddressLine1": updatedContact.info!.invoiceAddress!.addressLine1,
              "AddressLine2": updatedContact.info!.invoiceAddress!.addressLine2,
              "AddressLine3": updatedContact.info!.invoiceAddress!.addressLine3,
              "City": updatedContact.info!.invoiceAddress!.city,
              "Country": updatedContact.info!.invoiceAddress!.country,
              "CountryCode": updatedContact.info!.invoiceAddress!.countryCode,
              "PostalCode": updatedContact.info!.invoiceAddress!.postalCode,
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
    } catch (error) {
      print(error);
    }
  }

  void notify() {
    notifyListeners();
  }
}
