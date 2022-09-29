import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../class/order.dart';

class CartItem extends ConsumerWidget {
  final List<Order> orders;
  const CartItem(
    this.orders, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Table(
      children: [
        TableRow(
          children: [
            Text(
              'PRODUCT',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'PRICE',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'QUANTITY',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'DELETE',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
        for (Order order in orders) buildRow(order)
      ],
    );
  }

  buildRow(Order order) {
    print('inside buildRow');
    return TableRow(children: [
      Row(
        children: [
          Container(
            height: 20,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/home.jpg"),
              ),
            ),
          ),
          Text(order.name),
        ],
      ),
      Text(order.price.toString()),
      Text(order.quantity.toString()),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.delete),
      )
    ]);
  }
}
