import 'package:chat/auth/loginScreen.dart';
import 'package:chat/utils/colors.dart';
import 'package:chat/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../Utils/Constant.dart';
import '../Utils/Widget.dart';
import '../stateManagement/stateManegementClass.dart';

class SignUp extends StatefulWidget {
  static String tag = '/GrocerySignIn';

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final conformpasswordController = TextEditingController();
  final roleController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();

  // String role = 'User Side';
  bool islooding = false;

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prvider = Provider.of<StateManagementClass>(context, listen: false);
    return Scaffold(
      appBar: appBarWidget("", elevation: 0),
      backgroundColor: color_white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    text(AppStrings.signUp_hello,
                            fontSize: textSizeLarge,
                            fontWeight: FontWeight.w500,
                            maxLine: 5,
                            fontFamily: fontPoppins)
                        .paddingOnly(top: spacingBig, right: spacingBig),
                    Consumer<StateManagementClass>(
                      builder: (context, val, child) {
                        return Form(
                          key: _formKey,
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textformfield(
                                keyboardType: TextInputType.name,
                                controller: userNameController,
                                obscureText: false,
                                hinttext: AppStrings.SignUp_UserName,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter your Username';
                                  }
                                  return null;
                                },
                                prefixIcons: const Icon(Icons.person_outline),
                              ).paddingTop(spacing_standard_new),
                              textformfield(
                                // keyboardType: TextInputType.emailAddress,
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
                              ).paddingTop(spacing_standard_new),
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
                              ).paddingTop(spacing_standard_new),
                              Consumer<StateManagementClass>(
                                builder: (context, value, child) {
                                  return textformfield(
                                    controller: conformpasswordController,
                                    obscureText: prvider.passwordObsecure2,
                                    hinttext: AppStrings.SignUp_ConfirmPassword,
                                    prefixIcons: const Icon(Icons.lock_outline),
                                    suffixIcons: IconButton(
                                        onPressed: () {
                                          prvider.setIconChange2();
                                        },
                                        icon: value.passwordObsecure2
                                            ? const Icon(
                                                Icons.visibility_off,
                                                color: colorPrimary,
                                              )
                                            : const Icon(Icons.visibility)),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Conform the Password';
                                      }
                                      return null;
                                    },
                                  );
                                },
                              ).paddingTop(spacing_standard_new),
                              textformfield(
                                // keyboardType: TextInputType.emailAddress,
                                controller: roleController,
                                obscureText: false,
                                hinttext: AppStrings.SignUp_role,
                                prefixIcons: const Icon(Icons.email_outlined),

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Role is Required';
                                  }
                                  return null;
                                },
                              ).paddingTop(spacing_standard_new),
                              textformfield(
                                // keyboardType: TextInputType.emailAddress,
                                controller: ageController,
                                obscureText: false,
                                hinttext: AppStrings.SignUp_age,
                                prefixIcons: const Icon(Icons.email_outlined),

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Age is Required';
                                  }
                                  return null;
                                },
                              ).paddingTop(spacing_standard_new),
                              textformfield(
                                // keyboardType: TextInputType.emailAddress,
                                controller: genderController,
                                obscureText: false,
                                hinttext: AppStrings.SignUp_gender,
                                prefixIcons: const Icon(Icons.email_outlined),

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Gender is Required';
                                  }
                                  return null;
                                },
                              ).paddingTop(spacing_standard_new),
                              elevatedButton(
                                context,
                                looding: islooding,
                                onPress: () {},
                                width: double.infinity,
                                widget: text(AppStrings.SignUp_SignUp,
                                    textColor: Colors.white,
                                    fontFamily: fontMedium),
                              ).paddingTop(spacing_xxLarge),
                            ],
                          ),
                        ).paddingTop(spacing_thirty);
                      },
                    ),
                  ],
                ).paddingSymmetric(horizontal: spacing_twinty),
              ),
            ),
            GestureDetector(
              onTap: () {
                const Login().launch(context);
              },
              child: RichText(
                  text: const TextSpan(
                      style: TextStyle(
                          color: blackColor,
                          fontSize: textSizeMedium,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                      text: AppStrings.SignUp_HaveAccount,
                      children: [
                    TextSpan(
                        text: AppStrings.SignUp_LoginNow,
                        style: TextStyle(
                            color: colorPrimary, fontFamily: 'Poppins'))
                  ])).paddingBottom(spacing_twinty).center(),
            )
          ],
        ),
      ),
    );
  }
}
