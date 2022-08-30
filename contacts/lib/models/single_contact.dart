import 'package:contacts/models/info.dart';

class SingleContact {
  int? id;
  int? infoId;
  String comment;
  Info info;

  SingleContact(
      {this.id, this.infoId, required this.comment, required this.info});
}
