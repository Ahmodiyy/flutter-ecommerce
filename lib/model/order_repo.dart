import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../class/order.dart';

class OrderRepo extends StateNotifier<List<Order>> {
  static List<Order>? list;
  OrderRepo() : super(list!);

  void addOrder(Order order) {
    print('add order');
    state.forEach((element) {
      print(element.name);
    });
    state = [...state, order];
    state.forEach((element) {
      print(element.name);
    });
  }

  void removeOrder(int productId) {
    state = [
      for (final order in state)
        if (order.productId != productId) order,
    ];
  }
}
