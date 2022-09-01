import 'package:contacts/models/default_%20phone.dart';
import 'package:contacts/models/default_email.dart';
import 'package:contacts/models/invoice_address.dart';

class Info {
  int? id;
  int? defaultEmailId;
  int? defaultPhoneId;
  int? invoiceAddressId;
  String? name;
  DefaultPhone? defaultPhone;
  DefaultEmail? defaultEmail;
  InvoiceAddress? invoiceAddress;

  Info({
    this.id,
    this.defaultEmailId,
    this.defaultPhoneId,
    this.invoiceAddressId,
    required this.name,
    required this.defaultPhone,
    required this.defaultEmail,
    required this.invoiceAddress,
  });

  Info.jsonToInfo(info) {
    id = info['ID'];
    defaultEmailId = info['DefaultEmailID'];
    defaultPhoneId = info['DefaultPhoneID'];
    invoiceAddressId = info['InvoiceAddressID'];
    name = info['Name'];
    if (info['DefaultPhone'] == null) {
      defaultPhone = null;
    } else {
      defaultPhone = DefaultPhone.jsonToDefaultPhone(info['DefaultPhone']);
    }
    if (info['DefaultEmail'] == null) {
      defaultEmail = null;
    } else {
      defaultEmail = DefaultEmail.jsonToDefaultEmail(info['DefaultEmail']);
    }
    if (info['InvoiceAddress'] == null) {
      invoiceAddress = null;
    } else {
      invoiceAddress =
          InvoiceAddress.jsonToInvoiceAddress(info['InvoiceAddress']);
    }
  }

  Info.dummy()
      : name = "",
        defaultPhone = DefaultPhone.dummy(),
        defaultEmail = DefaultEmail.dummy(),
        invoiceAddress = InvoiceAddress.dummy();
}
