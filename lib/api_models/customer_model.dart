import 'dart:convert';

AddCustomerModel addCustomerModelFromJson(String str) => AddCustomerModel.fromJson(json.decode(str));

String addCustomerModelToJson(AddCustomerModel data) => json.encode(data.toJson());

class AddCustomerModel {
  String? id;
  String? name;
  String? email;
  String? contact;

  AddCustomerModel({
    this.id,
    this.name,
    this.email,
    this.contact,
  });

  factory AddCustomerModel.fromJson(Map<String, dynamic> json) => AddCustomerModel(
    id:json['id'],
    name: json["name"],
    email: json["email"],
    contact: json["contact"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "contact": contact,
  };
}


CustomersModel customersModelFromJson(String str) => CustomersModel.fromJson(json.decode(str));

String customersModelToJson(CustomersModel data) => json.encode(data.toJson());

class CustomersModel {
  String? entity;
  int? count;
  List<ItemModel>? items;

  CustomersModel({
    this.entity,
    this.count,
    this.items,
  });

  factory CustomersModel.fromJson(Map<String, dynamic> json) => CustomersModel(
    entity: json["entity"],
    count: json["count"],
    items: json["items"] == null ? [] : List<ItemModel>.from(json["items"]!.map((x) => ItemModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "entity": entity,
    "count": count,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class ItemModel {
  String? id;
  String? entity;
  String? name;
  String? email;
  String? contact;
  dynamic gstin;
  int? createdAt;

  ItemModel({
    this.id,
    this.entity,
    this.name,
    this.email,
    this.contact,
    this.gstin,
    this.createdAt,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    id: json["id"],
    entity: json["entity"],
    name: json["name"],
    email: json["email"],
    contact: json["contact"],
    gstin: json["gstin"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "entity": entity,
    "name": name,
    "email": email,
    "contact": contact,
    "gstin": gstin,
    "created_at": createdAt,
  };
}
