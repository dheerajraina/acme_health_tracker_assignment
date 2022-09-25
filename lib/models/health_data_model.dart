import 'dart:convert';

List<UserDataModel> userFromJson(String str) => List<UserDataModel>.from(json.decode(str).map((x) => UserDataModel.fromJson(x)));


class UserDataModel{
  UserDataModel({
    required this.type,
    required this.value,
    required this.createdOn,
  });

  String type;
  String value;
  DateTime createdOn;
  
factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        type: json["type"],
        value: json["value"],
        createdOn: json["createdOn"].toDate(),
       
    );


}