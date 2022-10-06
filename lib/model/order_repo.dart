import 'dart:convert';

import 'package:ecommerce/model/user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../class/order.dart';
import '../class/user.dart';

class OrderRepo extends StateNotifier<List<Order>> {
  static OrderRepo? _orderRepoInstance;
  OrderRepo._() : super([]);

  static OrderRepo getInstance() {
    return _orderRepoInstance ??= OrderRepo._();
  }

  void addOrder(Order order) {
    state = [...state, order];
  }

  void removeOrder(int productId) {
    state = [
      for (final order in state)
        if (order.productId != productId) order,
    ];
  }

  void placeOrder() {
    User user = UserRepo.user;
    for (Order order in state) {
      http.post(
        Uri.parse('http://localhost:8082/api/order'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'user': {
            'id': user.id,
            'email': user.email,
            'password': user.password
          },
          'product': {
            'id': order.productId,
            'name': order.name,
            'description': order.description,
            'image': order.image,
            'price': order.price
          },
          'quantity': order.quantity,
        }),
      );
    }
  }
}
