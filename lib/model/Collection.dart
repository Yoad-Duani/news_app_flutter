import 'dart:convert';

Collection collectionFromJson(String str) => Collection.fromJson(json.decode(str));

String userToJson(Collection data) => json.encode(data.toJson());

class Collection {
  String collectionName;

  Collection({this.collectionName});

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        collectionName: json["collectionName"],
      );

  Map<String, dynamic> toJson() => {
        'collectionName': collectionName,
      };
}
