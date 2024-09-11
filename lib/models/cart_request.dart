// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);


import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
    final String productId;
    final List<String> additives;
    final int quantity;
    final double totalPrice;

    CartModel({
        required this.productId,
        required this.additives,
        required this.quantity,
        required this.totalPrice,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        productId: json["productId"],
        additives: List<String>.from(json["additives"].map((x) => x)),
        quantity: json["quantity"],
        totalPrice: json["totalPrice"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "additives": List<dynamic>.from(additives.map((x) => x)),
        "quantity": quantity,
        "totalPrice": totalPrice,
    };
}
