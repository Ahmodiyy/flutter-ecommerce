import 'package:ecommerce/class/user.dart';
import 'package:ecommerce/extensions.dart';
import 'package:ecommerce/model/user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constant.dart';
import '../login/login.dart';

final userProvider = StateNotifierProvider<UserRepo, User>((ref) {
  return UserRepo.getInstance();
});

class Register extends ConsumerStatefulWidget {
  static String register = '/register';
  const Register({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  late bool passwordVisibility1;
  TextEditingController? confirmPasswordController;

  late bool passwordVisibility2;
  final _formKey = GlobalKey<FormState>();

  bool showProgressBar = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    passwordVisibility1 = false;
    passwordVisibility2 = false;
  }

  @override
  void dispose() {
    emailController?.dispose();
    passwordController?.dispose();
    confirmPasswordController?.dispose();
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
                      Text("Register",
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
                            return 'Please enter your email';
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
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      constantSizedBoxSmall,
                      StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return TextFormField(
                            controller: confirmPasswordController,
                            autofocus: true,
                            obscureText: passwordVisibility2,
                            decoration: constantTextFieldDecoration.copyWith(
                              labelText: 'Confirm password',
                              hintText: 'Confirm password',
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    passwordVisibility2 = !passwordVisibility2;
                                  });
                                },
                                child: Icon(
                                  passwordVisibility2
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                ),
                              ),
                            ),
                            style: Theme.of(context).textTheme.bodyText2,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          );
                        },
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
                      StatefulBuilder(
                        builder: ((context, setState) => ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => showProgressBar = true);
                                  int status = await ref
                                      .read(userProvider.notifier)
                                      .register(emailController!.value.text,
                                          passwordController!.value.text);
                                  if (status == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Email already exists')),
                                    );
                                  } else {
                                    Navigator.pushNamed(context, Login.login);
                                  }
                                  setState(() => showProgressBar = false);
                                }
                              },
                              child: showProgressBar
                                  ? const CircularProgressIndicator()
                                  : const Text('Register'),
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
