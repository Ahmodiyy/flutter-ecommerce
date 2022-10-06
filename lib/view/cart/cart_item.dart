import 'package:ecommerce/model/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../class/order.dart';
import '../../class/user.dart';
import '../../constant.dart';
import '../../image_build.dart';
import '../../model/order_repo.dart';
import '../register/register.dart';

final orderProvider = StateNotifierProvider<OrderRepo, List<Order>>(
  (ref) => OrderRepo.getInstance(),
);
final userProvider = StateNotifierProvider<UserRepo, User>(
  (ref) => UserRepo.getInstance(),
);

class CartItem extends ConsumerWidget {
  final TabController tabController;
  const CartItem({
    required this.tabController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Order> orders = ref.watch(orderProvider);
    User user = ref.watch(userProvider);
    double total = 0;
    for (var order in orders) {
      total += order.price * order.quantity;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                children: [
                  Text(
                    'PRODUCT',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    'PRICE',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    'QUANTITY',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    'DELETE',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              for (Order order in orders) buildRow(order, ref)
            ],
          ),
          Container(
            color: constantSecondary,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        user.id == 0
                            ? Navigator.pushNamed(context, Register.register)
                            : tabController.animateTo(1);
                      },
                      child: const Text('Process checkout')),
                  const Spacer(),
                  Column(
                    children: [
                      const Text('Cart total'),
                      Text('\$${total.toString()}',
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildRow(Order order, WidgetRef ref) {
    return TableRow(children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ImageBuild(
                height: 50, width: 50, imagePath: 'images/${order.image}'),
          ),
          Text(order.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      SizedBox(
          height: 70,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(order.price.toString()))),
      SizedBox(
          height: 70,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(order.quantity.toString()))),
      SizedBox(
        height: 70,
        child: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              ref.read(orderProvider.notifier).removeOrder(order.productId);
            },
            icon: const Icon(Icons.delete),
          ),
        ),
      )
    ]);
  }
}
