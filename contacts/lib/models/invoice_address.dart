class InvoiceAddress {
  int? id;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  int? businessRelationId;
  String? city;
  String? country;
  String? countryCode;
  String? postalCode;
  String? region;

  InvoiceAddress({
    this.id,
    required this.addressLine1,
    required this.addressLine2,
    required this.addressLine3,
    this.businessRelationId,
    required this.city,
    required this.country,
    required this.countryCode,
    required this.postalCode,
    this.region,
  });

  InvoiceAddress.jsonToInvoiceAddress(invoiceAddress)
      : id = invoiceAddress['ID'],
        addressLine1 = invoiceAddress['AddressLine1'],
        addressLine2 = invoiceAddress['AddressLine2'],
        addressLine3 = invoiceAddress['AddressLine3'],
        businessRelationId = invoiceAddress['BusinessRelationID'],
        city = invoiceAddress['City'],
        country = invoiceAddress['Country'],
        countryCode = invoiceAddress['CountryCode'],
        postalCode = invoiceAddress['PostalCode'],
        region = invoiceAddress['Region'];

  InvoiceAddress.dummy()
      : addressLine1 = "",
        addressLine2 = "",
        addressLine3 = "",
        city = "",
        country = "",
        countryCode = "",
        postalCode = "";
}
