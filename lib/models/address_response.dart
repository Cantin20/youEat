// To parse this JSON data, do
//
//     final List<AddressResponse> addresses = addressResponseListFromJson(jsonString);

import 'dart:convert';

// Function to parse a list of AddressResponse objects from JSON
List<AddressResponse> addressResponseFromJson(String str) =>
    List<AddressResponse>.from(json.decode(str).map((x) => AddressResponse.fromJson(x)));

// Function to convert a list of AddressResponse objects to JSON
String addressResponseToJson(List<AddressResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressResponse {
  final String id;
  final String userId;
  final String addressLine1;
  final String postalCode;
  final bool addressResponseDefault;
  final String deliveryInstructions;
  final int v;

  AddressResponse({
    required this.id,
    required this.userId,
    required this.addressLine1,
    required this.postalCode,
    required this.addressResponseDefault,
    required this.deliveryInstructions,
    required this.v,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) => AddressResponse(
        id: json["_id"],
        userId: json["userId"],
        addressLine1: json["addressLine1"],
        postalCode: json["postalCode"],
        addressResponseDefault: json["default"],
        deliveryInstructions: json["deliveryInstructions"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "addressLine1": addressLine1,
        "postalCode": postalCode,
        "default": addressResponseDefault,
        "deliveryInstructions": deliveryInstructions,
        "__v": v,
      };
}
