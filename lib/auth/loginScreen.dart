import 'package:chat/Utils/Colors.dart';
import 'package:chat/Utils/String.dart';
import 'package:chat/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Utils/Widget.dart';
import '../screens/chatScreen.dart';
import '../stateManagement/stateManegementClass.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final prvider = Provider.of<StateManagementClass>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 0),
              child: Image.asset(
                'images/logo.png',
                width: 140,
                height: 140,
              ),
            ),
            const SizedBox(height: spacing_xxLarge),
            Form(
              key: formkey,
              child: Column(
                children: [
                  textformfield(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    obscureText: false,
                    hinttext: AppStrings.SignUp_Email_Address,
                    prefixIcons: const Icon(Icons.email_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is Required';
                      } else if (!value.contains('@gmail')) {
                        return "Enter a Valid Email Address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: spacing_xlarge,
                  ),
                  Consumer<StateManagementClass>(
                    builder: (context, Consumervalue, child) {
                      return textformfield(
                        controller: passwordController,
                        obscureText: prvider.passwordObsecure,
                        hinttext: AppStrings.SignUp_Password,
                        prefixIcons: const Icon(Icons.lock_outline),
                        suffixIcons: IconButton(
                            onPressed: () {
                              prvider.setIconChange();
                            },
                            icon: Consumervalue.passwordObsecure
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: colorPrimary,
                                  )
                                : const Icon(Icons.visibility)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is Required';
                          }
                          return null;
                        },
                      );
                    },
                  )
                ],
              ).paddingAll(spacing_standard_new),
            ),
            const SizedBox(
              height: spacingBig,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacing_twinty),
              child: elevatedButton(
                context,
                widget: text(AppStrings.welcome_Login, textColor: color_white),
                borderRadius: 20.0,
                onPress: () {
                  if (formkey.currentState!.validate()) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Chat()));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
