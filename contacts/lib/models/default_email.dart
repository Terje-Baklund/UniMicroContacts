class DefaultEmail {
  int? id;
  int? businessRelationId;
  bool? deleted;
  String? description;
  String? emailAddress;

  DefaultEmail({
    this.id,
    this.businessRelationId,
    this.deleted,
    this.description,
    required this.emailAddress,
  });

  DefaultEmail.jsonToDefaultEmail(jsonDefaultEmail)
      : id = jsonDefaultEmail['ID'],
        businessRelationId = jsonDefaultEmail['BusinessRelationID'],
        deleted = jsonDefaultEmail['Deleted'],
        description = jsonDefaultEmail['Description'],
        emailAddress = jsonDefaultEmail['EmailAddress'];

  DefaultEmail.dummy() : emailAddress = "";
}
