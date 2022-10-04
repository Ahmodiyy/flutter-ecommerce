import 'package:ecommerce/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import '../login/login.dart';

class Register extends ConsumerStatefulWidget {
  static String register = '/register';
  const Register({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  TextEditingController? textController1;
  TextEditingController? textController2;

  late bool passwordVisibility1;
  TextEditingController? textController3;

  late bool passwordVisibility2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordVisibility1 = false;
    textController3 = TextEditingController();
    passwordVisibility2 = false;
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
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
                      Text("Register",
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
                      ),
                      constantSizedBoxSmall,
                      Text(
                        'Confirm Password',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextFormField(
                        controller: textController3,
                        autofocus: true,
                        obscureText: !passwordVisibility2,
                        decoration: constantTextFieldDecoration.copyWith(
                            labelText: 'Confirm password',
                            hintText: 'Confirm password'),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      constantSizedBoxSmall,
                      GestureDetector(
                        child: Text(
                          'Already have an account?',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        onTap: () => Navigator.pushNamed(context, Login.login),
                      ),
                      constantSizedBoxSmall,
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Register'),
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
