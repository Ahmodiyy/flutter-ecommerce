import 'package:ecommerce/extensions.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class NavWidget extends StatelessWidget {
  final BoxConstraints constraints;
  final BuildContext context;
  const NavWidget({
    super.key,
    required this.constraints,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return constraints.isMobile
        ? Drawer(
            width: 200,
            backgroundColor: Colors.white,
            child: ListView(
              children: [
                buildNav("HOME", "/"),
                buildNav("PRODUCT", "/product"),
                buildNav("CART", "/cart"),
                buildNav("LOGIN", "/login"),
                buildNav("REGISTER", "/register"),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      Expanded(
                        child: buildNav("HOME", "/"),
                      ),
                      Expanded(
                        child: buildNav("PRODUCT", "/product"),
                      ),
                      Expanded(
                        child: buildNav("CART", "/cart"),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 6,
                  child: Text("ECOMAS",
                      style: TextStyle(
                        color: constantActionColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: buildNav("REGISTER", "/register"),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: buildNav("LOGIN", "/login"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget buildNav(String title, String navigation) {
    return GestureDetector(
      child: Text(
        title,
        softWrap: false,
        style: constantTextStyleLight,
      ),
      onTap: () => Navigator.pushNamed(context, navigation),
    );
  }
}
