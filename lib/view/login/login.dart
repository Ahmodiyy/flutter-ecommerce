import 'package:ecommerce/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constant.dart';
import '../cart/cart.dart';
import '../register/register.dart';

class Login extends ConsumerStatefulWidget {
  static String login = '/login';
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  late bool passwordVisibility1;

  final _formKey = GlobalKey<FormState>();

  bool showProgressBar = false;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility1 = false;
  }

  @override
  void dispose() {
    emailController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Padding(
          padding: constraint.isMobile
              ? const EdgeInsets.all(50.0)
              : const EdgeInsets.symmetric(horizontal: 250, vertical: 50),
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Login",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 30)),
                      constantSizedBoxLarge,
                      TextFormField(
                        controller: emailController,
                        autofocus: true,
                        obscureText: false,
                        decoration: constantTextFieldDecoration,
                        style: Theme.of(context).textTheme.bodyText2,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      constantSizedBoxSmall,
                      StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return TextFormField(
                            controller: passwordController,
                            autofocus: true,
                            obscureText: passwordVisibility1,
                            decoration: constantTextFieldDecoration.copyWith(
                              labelText: 'Password',
                              hintText: 'Password',
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    passwordVisibility1 = !passwordVisibility1;
                                  });
                                },
                                child: Icon(
                                  passwordVisibility1
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                ),
                              ),
                            ),
                            style: Theme.of(context).textTheme.bodyText2,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      constantSizedBoxSmall,
                      GestureDetector(
                        child: Text(
                          'Don\'t have an account?',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        onTap: () =>
                            Navigator.pushNamed(context, Register.register),
                      ),
                      constantSizedBoxSmall,
                      StatefulBuilder(
                        builder: ((context, setState) => ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => showProgressBar = true);
                                  int status = await ref
                                      .read(userProvider.notifier)
                                      .login(emailController!.value.text,
                                          passwordController!.value.text);
                                  if (status == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('User does not exists')),
                                    );

                                    ;
                                  } else {
                                    ref
                                        .read(userProvider.notifier)
                                        .setUser(status);

                                    Navigator.pushNamed(context, Cart.cart);
                                  }
                                  setState(() => showProgressBar = false);
                                }
                              },
                              child: showProgressBar
                                  ? const CircularProgressIndicator()
                                  : const Text('Login'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
