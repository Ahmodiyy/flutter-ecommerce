import 'package:ecommerce/view/product/home_argument.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../class/order.dart';
import '../../class/product.dart';
import '../../constant.dart';
import '../../model/order_repo.dart';

final itemQuantityProvider = StateProvider.autoDispose<int>((ref) => 1);
final orderProvider = StateNotifierProvider<OrderRepo, List<Order>>(
  (ref) => OrderRepo.getInstance(),
);

class Item extends ConsumerStatefulWidget {
  static const item = '/item';

  const Item({
    super.key,
  });

  @override
  ConsumerState createState() => _ItemState();
}

class _ItemState extends ConsumerState<Item> {
  double opacityValue = 0;
  bool itemAlreadyAdded = false;
  @override
  Widget build(BuildContext context) {
    HomeArgument homeArgument =
        ModalRoute.of(context)!.settings.arguments as HomeArgument;
    Product product = homeArgument.products;

    int quantity = ref.watch(itemQuantityProvider);
    List<Order> order = ref.watch(orderProvider);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
      return constraint.isMobile
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    buildImage(product),
                    buildInfo(context, product, ref, quantity, order),
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
                  Expanded(
                      child: buildInfo(context, product, ref, quantity, order)),
                ],
              ),
            );
    });
  }

  Widget buildImage(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/${product.image}'),
          ),
        ),
      ),
    );
  }

  Widget buildInfo(BuildContext context, Product product, WidgetRef ref,
      int quantity, List<Order> orderList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 400,
        child: Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              constantSizedBoxMedium,
              Text(
                '\$${product.price.toString()}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              constantSizedBoxMedium,
              Text(
                product.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 7,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      letterSpacing: 2,
                      wordSpacing: 3,
                      height: 2,
                    ),
              ),
              constantSizedBoxMedium,
              Row(
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(5),
                    onPressed: () {
                      ref
                          .read(itemQuantityProvider.notifier)
                          .update((state) => state == 1 ? state : state - 1);
                    },
                    icon: const Text("-",
                        style: TextStyle(
                          fontSize: 25,
                        )),
                  ),
                  Text(quantity.toString()),
                  IconButton(
                    padding: const EdgeInsets.all(5),
                    color: Colors.black,
                    onPressed: () {
                      ref
                          .read(itemQuantityProvider.notifier)
                          .update((state) => state + 1);
                    },
                    icon: const Text("+",
                        style: TextStyle(
                          fontSize: 25,
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      for (Order order in orderList) {
                        if (order.productId == product.id) {
                          setState(() {
                            debugPrint('setstate');
                            itemAlreadyAdded = true;
                            opacityValue = 1;
                          });

                          return;
                        }
                      }
                      debugPrint("create order 1");
                      opacityValue = 1;
                      ref.read(orderProvider.notifier).addOrder(
                            Order(
                              quantity: quantity,
                              productId: product.id,
                              price: product.price,
                              image: product.image,
                              name: product.name,
                              description: product.description,
                            ),
                          );
                    },
                    child: const Text(
                      'Add to cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  AnimatedOpacity(
                    opacity: opacityValue,
                    duration: const Duration(
                      seconds: 1,
                    ),
                    child: itemAlreadyAdded
                        ? const Text(
                            'item already in cart',
                            style: constantTextStyleRed,
                          )
                        : Text(
                            'successfully added',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
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
