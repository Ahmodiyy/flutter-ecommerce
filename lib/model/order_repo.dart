import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../class/order.dart';

class OrderRepo extends StateNotifier<List<Order>> {
  OrderRepo() : super([]);

  void addOrder(Order order) {
    print('add order');
    state = [...state, order];
  }

  void removeOrder(int productId) {
    state = [
      for (final order in state)
        if (order.productId != productId) order,
    ];
  }
}
