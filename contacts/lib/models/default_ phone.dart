class DefaultPhone {
  int? id;
  int? businessRelationId;
  String? countryCode;
  String? description;
  String? number;
  int? type;

  DefaultPhone({
    this.id,
    this.businessRelationId,
    required this.countryCode,
    required this.description,
    required this.number,
    this.type,
  });

  DefaultPhone.jsonToDefaultPhone(jsonDefaultPhone)
      : id = jsonDefaultPhone['ID'],
        businessRelationId = jsonDefaultPhone['BusinessRelationID'],
        countryCode = jsonDefaultPhone['CountryCode'],
        description = jsonDefaultPhone['Description'],
        number = jsonDefaultPhone['Number'],
        type = jsonDefaultPhone['Type'];

  DefaultPhone.dummy()
      : countryCode = "",
        description = "Mobile",
        number = "";
}
