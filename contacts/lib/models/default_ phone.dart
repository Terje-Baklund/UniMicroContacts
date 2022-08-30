class DefaultPhone {
  int? id;
  int? businessRelationId;
  String countryCode;
  String description;
  String number;
  int? type;

  DefaultPhone({
    this.id,
    this.businessRelationId,
    required this.countryCode,
    required this.description,
    required this.number,
    this.type,
  });
}
