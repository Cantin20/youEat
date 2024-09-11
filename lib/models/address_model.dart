// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
    final String addressLine1;
    final String postalCode;
    final bool addressModelDefault;
    final double longitude;
    final double latitude;
    final String deliveryInstructions;

    AddressModel({
        required this.addressLine1,
        required this.postalCode,
        required this.addressModelDefault,
        required this.longitude,
        required this.latitude,
        required this.deliveryInstructions,
    });

    factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        addressLine1: json["addressLine1"],
        postalCode: json["postalCode"],
        addressModelDefault: json["default"],
        longitude: json["Longitude"]?.toDouble(),
        latitude: json["Latitude"]?.toDouble(),
        deliveryInstructions: json["deliveryInstructions"],
    );

    Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "postalCode": postalCode,
        "default": addressModelDefault,
        "Longitude": longitude,
        "Latitude": latitude,
        "deliveryInstructions": deliveryInstructions,
    };
}
