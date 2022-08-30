class DefaultEmail {
  int? id;
  int? businessRelationId;
  bool? deleted;
  String? description;
  String emailAddress;

  DefaultEmail({
    this.id,
    this.businessRelationId,
    this.deleted,
    this.description,
    required this.emailAddress,
  });
}
