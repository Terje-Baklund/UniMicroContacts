import 'package:contacts/models/default_%20phone.dart';
import 'package:contacts/models/default_email.dart';
import 'package:contacts/models/invoice_address.dart';

class Info {
  int? id;
  int? defaultEmailId;
  int? defaultPhoneId;
  int? invoiceAddressId;
  String name;
  DefaultPhone defaultPhone;
  DefaultEmail defaultEmail;
  InvoiceAddress invoiceAddress;

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
}
