import 'package:ecommerce/class/order.dart';
import 'package:ecommerce/model/order_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'billing.dart';
import 'cart_item.dart';
import 'checkout.dart';

const List<Text> tabs = <Text>[
  Text(
    'Shopping cart',
    style: TextStyle(
      color: Color(0xff9C9B9C),
    ),
  ),
  Text(
    'Billing information',
    style: TextStyle(
      color: Color(0xff9C9B9C),
    ),
  ),
  Text(
    'Completed',
    style: TextStyle(
      color: Color(0xff9C9B9C),
    ),
  )
];
final cartItemsProvider = StateNotifierProvider<OrderRepo, List<Order>>((ref) {
  return OrderRepo();
});

class Cart extends ConsumerWidget {
  static const String cart = "/cart";
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Order> cartItems = ref.watch(cartItemsProvider);
    print('cartItem length ${cartItems.length}');
    return LayoutBuilder(builder: (context, constraint) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: DefaultTabController(
          length: tabs.length,
          // The Builder widget is used to have a different BuildContext to access
          // closest DefaultTabController.
          child: Builder(builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context)!;
            tabController.addListener(() {
              if (!tabController.indexIsChanging) {
                // Your code goes here.
                // To get index of current tab use tabController.index
              }
            });
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text("Shopping cart",
                    style: Theme.of(context).textTheme.headline5),
                bottom: const TabBar(
                  tabs: tabs,
                ),
              ),
              body: TabBarView(children: [
                CartItem(cartItems),
                const Billing(),
                const Checkout(),
              ]),
            );
          }),
        ),
      );
    });
  }
}
