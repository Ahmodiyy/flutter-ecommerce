import 'package:ecommerce/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
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
  TextEditingController? textController1;
  TextEditingController? textController2;

  late bool passwordVisibility1;

  late bool passwordVisibility2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordVisibility1 = false;
    passwordVisibility2 = false;
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
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
            key: scaffoldKey,
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
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
                      Text(
                        'Email',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextFormField(
                        controller: textController1,
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
                      Text(
                        'Password',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextFormField(
                        controller: textController2,
                        autofocus: true,
                        obscureText: !passwordVisibility1,
                        decoration: constantTextFieldDecoration.copyWith(
                            labelText: 'Password', hintText: 'Password'),
                        style: Theme.of(context).textTheme.bodyText2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
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
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Login')),
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
