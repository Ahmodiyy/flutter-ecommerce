import 'package:flutter/cupertino.dart';

@immutable
class Order {
  final int quantity;
  final int productId;
  final String name;
  final String image;
  final String description;
  final int price;

  const Order({
    required this.quantity,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });

  static Order copyWith({
    required int quantity,
    required int productId,
    required int price,
    required String name,
    required String image,
    required String description,
  }) {
    return Order(
      quantity: quantity,
      productId: productId,
      name: name,
      image: image,
      price: price,
      description: description,
    );
  }
}
