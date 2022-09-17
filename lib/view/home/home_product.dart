import 'package:ecommerce/extensions.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../model/class/product.dart';
import '../product/item.dart';

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
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/${product.image}'),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Item(
                    constraints: constraints,
                    product: product,
                  ),
                ),
              );
            },
          ),
          constantSizedBoxSmall,
          Text(
            product.name,
            style: constantTextStyleDark,
          ),
          constantSizedBoxSmall,
          Text(
            '\$${product.price.toString()}',
            style: constantTextStyleLight,
          ),
        ],
      ),
    );
  }
}
