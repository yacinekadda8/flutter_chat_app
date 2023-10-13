class MessageModel {
  late String msg;
  late String read;
  late String told;
  late String fromid;
  late String sent;
  late Type type;

  MessageModel({
    required this.msg,
    required this.read,
    required this.told,
    required this.fromid,
    required this.sent,
    required this.type,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'].toString();
    read = json['read'].toString();
    told = json['told'].toString();
    fromid = json['fromid'].toString();
    sent = json['sent'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['read'] = read;
    data['told'] = told;
    data['type'] = type.name;
    data['fromid'] = fromid;
    data['sent'] = sent;
    return data;
  }
}

enum Type { text, image }
