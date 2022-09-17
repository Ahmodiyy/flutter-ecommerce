import 'package:flutter/material.dart';

import 'package:ecommerce/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant.dart';
import '../../model/class/product.dart';

final itemQuantity = StateProvider<int>((ref) => 0);

class Item extends ConsumerWidget {
  final BoxConstraints constraints;
  final Product product;
  const Item({
    super.key,
    required this.constraints,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(itemQuantity);
    return Padding(
      padding: const EdgeInsets.all(40),
      child: constraints.isMobile
          ? Column(
              children: [
                buildImage(product),
                buildInfo(product),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: buildImage(product),
                ),
                Expanded(
                  child: buildInfo(product),
                ),
              ],
            ),
    );
  }

  Widget buildImage(Product product) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/${product.image}'),
        ),
      ),
    );
  }

  Widget buildInfo(Product product) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.name, style: ,),
          Text(product.price.toString()),
          Text(product.description),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.minimize),
              ),
              Text('${itemQuantity.state}'),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Add to cart'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
