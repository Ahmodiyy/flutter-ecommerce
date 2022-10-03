import 'package:ecommerce/extensions.dart';
import 'package:ecommerce/view/product/home_argument.dart';
import 'package:flutter/material.dart';

import '../../class/product.dart';
import '../../constant.dart';

import '../../image.dart';

class HomeProduct extends StatelessWidget {
  final BoxConstraints constraints;
  final List<Product> products;
  const HomeProduct({
    super.key,
    required this.constraints,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return constraints.isMobile
        ? Column(
            children: [
              for (Product product in products) buildProduct(product, context)
            ],
          )
        : GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 40,
              mainAxisSpacing: 20,
              mainAxisExtent: 300,
            ),
            children: [
              for (Product product in products) buildProduct(product, context)
            ],
          );
  }

  Widget buildProduct(Product product, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          GestureDetector(
            child:
                ImageBuild(height: 200, imagePath: 'images/${product.image}'),
            onTap: () {
              Navigator.pushNamed(context, '/item',
                  arguments: HomeArgument(products: product));
            },
          ),
          constantSizedBoxSmall,
          Text(
            product.name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          constantSizedBoxSmall,
          Text(
            '\$${product.price.toString()}',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
