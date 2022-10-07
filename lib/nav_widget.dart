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
            width: 100,
            backgroundColor: Colors.white,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildNavForHome("HOME", "/"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildNav("CART", "/cart"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildNav("LOGIN", "/login"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildNav("REGISTER", "/register"),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      Expanded(
                        child: buildNavForHome("HOME", "/"),
                      ),
                      Expanded(
                        child: buildNav("CART", "/cart"),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 6,
                  child: Text("Ecommerce",
                      style: TextStyle(
                        color: constantActionColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
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
        style: Theme.of(context).textTheme.bodyText2,
      ),
      onTap: () => Navigator.pushNamed(context, navigation),
    );
  }

  Widget buildNavForHome(String title, String navigation) {
    return GestureDetector(
      child: Text(
        title,
        softWrap: false,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: actionColor,
            ),
      ),
      onTap: () => Navigator.pushNamed(context, navigation),
    );
  }
}
