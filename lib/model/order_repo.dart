import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../class/order.dart';

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
}
