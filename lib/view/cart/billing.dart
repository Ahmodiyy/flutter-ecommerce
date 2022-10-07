import 'package:ecommerce/extensions.dart';
import 'package:ecommerce/model/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../class/order.dart';
import '../../class/user.dart';
import '../../constant.dart';
import '../../image_build.dart';
import '../../model/order_repo.dart';

final orderProvider = StateNotifierProvider<OrderRepo, List<Order>>(
  (ref) => OrderRepo.getInstance(),
);
final userProvider = StateNotifierProvider<UserRepo, User>(
  (ref) => UserRepo.getInstance(),
);

class Billing extends ConsumerWidget {
  final TabController tabController;
  const Billing({
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraint) {
        return Padding(
          padding: constraint.isMobile
              ? const EdgeInsets.all(50.0)
              : const EdgeInsets.symmetric(horizontal: 250, vertical: 50),
          child: Column(
            children: [
              Text("Payment",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 30)),
              constantSizedBoxLarge,
              TextFormField(
                autofocus: true,
                decoration: constantTextFieldDecoration.copyWith(
                    labelText: 'NAME ON CARD', hintText: 'NAME ON CARD'),
                style: Theme.of(context).textTheme.bodyText2,
                keyboardType: TextInputType.emailAddress,
              ),
              constantSizedBoxSmall,
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      autofocus: true,
                      decoration: constantTextFieldDecoration.copyWith(
                        labelText: 'CARD NUMBER',
                        hintText: 'CARD NUMBER',
                      ),
                      style: Theme.of(context).textTheme.bodyText2,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      decoration: constantTextFieldDecoration.copyWith(
                        labelText: 'CVV',
                        hintText: 'CVV',
                      ),
                      style: Theme.of(context).textTheme.bodyText2,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
              constantSizedBoxSmall,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      decoration: constantTextFieldDecoration.copyWith(
                          labelText: 'MONTH', hintText: 'DATE'),
                      style: Theme.of(context).textTheme.bodyText2,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      decoration: constantTextFieldDecoration.copyWith(
                          labelText: 'MONTH', hintText: 'DATE'),
                      style: Theme.of(context).textTheme.bodyText2,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
              constantSizedBoxSmall,
              Container(
                color: constantSecondary,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            user.id == 0 || total == 0
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'You\'ve not logged in or cart is empty')),
                                  )
                                : {
                                    ref
                                        .read(orderProvider.notifier)
                                        .placeOrder(),
                                    tabController.animateTo(2),
                                  };
                          },
                          child: const Text('Place order')),
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
      },
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
