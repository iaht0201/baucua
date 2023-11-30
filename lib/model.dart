import 'dart:convert';

Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Client {
  int ? id;
  String? firtsName;
  String? lastName;
  bool blocked;
  Client({
    this.id,
    this.firtsName,
    required this.blocked,
    this.lastName,
  });
  factory Client.fromMap(Map<String, dynamic> json) => Client(
      id: json["id"],
      firtsName: json["first_name"],
      lastName: json["last_name"],
      blocked: json["blocked"] == 1);

  Map<String, dynamic> toMap() => {
        "id": id,
        "first_name": firtsName,
        "last_name": lastName,
        "blocked": blocked
      };
}
