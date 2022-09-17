import 'package:adaptive_components/adaptive_components.dart';
import 'package:ecommerce/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../model/class/product.dart';
import '../../model/product_repo.dart';
import '../../nav_widget.dart';
import 'home_product.dart';

final productProvider = FutureProvider<List<Product>>(
  (ref) => ProductRepo().fetchProduct(http.Client()),
);

class Home extends ConsumerWidget {
  static const String home = "/";
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);
    return LayoutBuilder(
      builder: (context, constraint) {
        if (constraint.isMobile) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Ecomas'),
            ),
            endDrawer: NavWidget(context: context, constraints: constraint),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  homeImage(),
                  products.when(
                    data: (data) =>
                        HomeProduct(constraints: constraint, products: data),
                    error: (object, stack) => Text('$stack.toString()'),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          );
        }
        return Scaffold(
          body: LayoutBuilder(builder: (context, constraint) {
            return SingleChildScrollView(
              child: AdaptiveColumn(
                children: [
                  AdaptiveContainer(
                    columnSpan: 12,
                    child: NavWidget(context: context, constraints: constraint),
                  ),
                  AdaptiveContainer(
                    columnSpan: 12,
                    child: homeImage(),
                  ),
                  AdaptiveContainer(
                    height: 300,
                    columnSpan: 12,
                    child: products.when(
                      data: (data) =>
                          HomeProduct(constraints: constraint, products: data),
                      error: (object, stack) => Text('$stack.toString()'),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Widget homeImage() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("images/home.jpg"),
        ),
      ),
    );
  }
}
