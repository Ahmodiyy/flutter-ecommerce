import 'package:adaptive_components/adaptive_components.dart';
import 'package:ecommerce/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../class/product.dart';
import '../../image_build.dart';
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
              title: const Text('Ecommerce'),
            ),
            endDrawer: NavWidget(context: context, constraints: constraint),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  homeImage(),
                  products.when(
                    data: (data) =>
                        HomeProduct(constraints: constraint, products: data),
                    error: (object, stack) =>
                        const Center(child: Text('Start backend server')),
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
                      error: (object, stack) =>
                          const Center(child: Text('start backend server')),
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
    return const ImageBuild(
      height: 200,
      imagePath: "images/home.jpg",
    );
  }
}
