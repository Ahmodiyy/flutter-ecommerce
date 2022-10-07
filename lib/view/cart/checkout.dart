import 'package:ecommerce/extensions.dart';
import 'package:ecommerce/model/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../class/ordered_product.dart';
import '../../model/product_repo.dart';

final orderedProductProvider = FutureProvider<List<OrderedProduct>>(
  (ref) =>
      ProductRepo().fetchOrders(http.Client(), UserRepo.user.id.toString()),
);

class Checkout extends ConsumerWidget {
  const Checkout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderedProductProvider);
    orders.when(
        data: (data) => print('product ordered ${data.length}'),
        error: (o, s) => print(s),
        loading: () => print('loading'));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          Table(
            children: [
              TableRow(
                children: [
                  Text(
                    'ORDER ID',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    'PRODUCT ID',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    'QUANTITY',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              orders.when(
                data: (data) {
                  for (OrderedProduct order in data) {
                    print(data);
                    return buildRow(order, ref);
                  }
                  return const TableRow(children: [
                    Text(''),
                    Text(''),
                    Text(''),
                  ]);
                },
                error: (object, stack) => const TableRow(children: [
                  Text(''),
                  Text(''),
                  Text(''),
                ]),
                loading: () => const TableRow(children: [
                  Text(''),
                  Text(''),
                  Text(''),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildRow(OrderedProduct order, WidgetRef ref) {
    return TableRow(
      children: [
        Text(order.orderId.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('\$${order.productId.toString()}'),
        Text(order.quantity.toString()),
      ],
    );
  }
}
