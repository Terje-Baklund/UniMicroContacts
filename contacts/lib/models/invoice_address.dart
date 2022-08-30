class InvoiceAddress {
  int? id;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  int? businessRelationId;
  String city;
  String country;
  String countryCode;
  String postalCode;
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
}
