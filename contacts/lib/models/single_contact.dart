import 'package:contacts/models/info.dart';

class SingleContact {
  int? id;
  int? infoId;
  late String comment;
  Info? info;

  SingleContact(
      {this.id, this.infoId, required this.comment, required this.info});

  SingleContact.jsonToSingleContact(jsonSingleContact) {
    id = jsonSingleContact['ID'];
    infoId = jsonSingleContact['InfoID'];
    comment = jsonSingleContact['Comment'];
    if (jsonSingleContact['Info'] == null) {
      info = null;
    } else {
      info = Info.jsonToInfo(jsonSingleContact['Info']);
    }
  }

  SingleContact.dummy()
      : comment = "",
        info = Info.dummy();
}
