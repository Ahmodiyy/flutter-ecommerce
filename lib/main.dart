import 'package:ecommerce/view/cart/cart.dart';
import 'package:ecommerce/view/home/home.dart';
import 'package:ecommerce/view/login/login.dart';
import 'package:ecommerce/view/product/item.dart';
import 'package:ecommerce/view/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.all(20),
            ),
            backgroundColor: MaterialStateProperty.all(
              const Color(0xff4247CB),
            ),
          ),
        ),
      ),
      initialRoute: "/",
      routes: {
        Home.home: (context) => const Home(),
        Item.item: (context) => const Item(),
        Cart.cart: (context) => const Cart(),
        Login.login: (context) => const Login(),
        Register.register: (context) => const Register(),
      },
    );
  }
}
