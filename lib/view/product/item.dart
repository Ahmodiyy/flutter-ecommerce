import 'package:flutter/material.dart';

import 'package:ecommerce/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant.dart';
import '../../model/class/product.dart';

final itemQuantityProvider = StateProvider<int>((ref) => 0);

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
    ref.watch(itemQuantityProvider);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
      return constraint.isMobile
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    buildImage(product),
                    buildInfo(product, context, ref),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                children: [
                  Expanded(
                    child: buildImage(
                      product,
                    ),
                  ),
                  Expanded(child: buildInfo(product, context, ref)),
                ],
              ),
            );
    });
  }

  Widget buildImage(Product product) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/${product.image}'),
        ),
      ),
    );
  }

  Widget buildInfo(Product product, BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 400,
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: constantTextStyleDark.copyWith(fontSize: 50),
              ),
              constantSizedBoxMedium,
              Text(product.price.toString(), style: constantTextStyleDark),
              constantSizedBoxMedium,
              Text(
                product.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 7,
                style: constantTextStyleLight.copyWith(
                  letterSpacing: 2,
                  wordSpacing: 3,
                  height: 2,
                ),
              ),
              constantSizedBoxMedium,
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      ref
                          .read(itemQuantityProvider.notifier)
                          .update((state) => state == 0 ? state : state - 1);
                    },
                    icon: const Icon(Icons.minimize),
                  ),
                  Text(ref.read(itemQuantityProvider).toString()),
                  IconButton(
                    onPressed: () {
                      ref
                          .read(itemQuantityProvider.notifier)
                          .update((state) => state + 1);
                    },
                    icon: const Icon(Icons.add),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Add to cart'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
