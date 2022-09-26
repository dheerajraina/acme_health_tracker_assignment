import 'dart:convert';

List<UserDataModel> userFromJson(String str) => List<UserDataModel>.from(json.decode(str).map((x) => UserDataModel.fromJson(x)));


class UserDataModel{
  UserDataModel({
    required this.id,
    required this.type,
    required this.value,
    required this.createdOn,
  });

  String id;

  String type;
  String value;
  DateTime createdOn;
  
factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
        createdOn: json["createdOn"].toDate(),
       
    );


}