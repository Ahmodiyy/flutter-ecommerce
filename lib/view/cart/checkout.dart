import 'package:ecommerce/extensions.dart';
import 'package:ecommerce/model/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../class/ordered_product.dart';
import '../../class/user.dart';
import '../../constant.dart';
import '../../image_build.dart';
import '../../model/product_repo.dart';

final userProvider = StateNotifierProvider<UserRepo, User>(
  (ref) => UserRepo.getInstance(),
);
final orderedProductProvider = FutureProvider.autoDispose<List<OrderedProduct>>(
  (ref) => ProductRepo()
      .fetchOrders(http.Client(), ref.read(userProvider).id.toString()),
);

class Checkout extends ConsumerWidget {
  const Checkout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderedProductProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: ListView(
        children: [
          orders.when(
            data: (data) => buildTile(data),
            error: (object, stack) =>
                const Center(child: Text('Service Unavailable')),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  buildTile(List<OrderedProduct> ordered) {
    List<Card> listListTile = [];

    for (OrderedProduct orderedProduct in ordered) {
      listListTile.add(
        Card(
          child: ListTile(
            leading: ImageBuild(
              height: 72,
              width: 72,
              imagePath: 'images/${orderedProduct.image}',
            ),
            title: Text(orderedProduct.name),
            subtitle: Text(orderedProduct.description),
            trailing: Text(orderedProduct.quantity.toString(),
                style: const TextStyle(color: actionColor)),
            isThreeLine: true,
          ),
        ),
      );
    }
    return Column(
      children: listListTile,
    );
  }
}
