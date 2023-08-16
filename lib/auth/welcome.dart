import 'package:chat/Utils/String.dart';
import 'package:chat/auth/signUp.dart';
import 'package:chat/utils/colors.dart';
import 'package:chat/utils/constant.dart';
import 'package:chat/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

import '../utils/images.dart';
import 'loginScreen.dart';

class Welcome extends StatefulWidget {
  // final WebSocketChannel channel;
  const Welcome({
    Key? key,
  }) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(spacing_twinty),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  splashIcon,
                  height: size.height * .12,
                  width: size.height * .08,
                  fit: BoxFit.cover,
                ),
                text(AppStrings.welcome_appTitle,
                    fontSize: textSizeXXLarge, fontWeight: FontWeight.w600)
              ],
            ),
            const SizedBox(height: spacingBig),
            elevatedButton(
              context,
              widget: text(AppStrings.welcome_Login, textColor: color_white),
              borderRadius: 20.0,
              onPress: () {
                const Login().launch(context);
              },
            ),
            const SizedBox(
              height: spacing_twinty,
            ),
            elevatedButton(
              context,
              widget: text(AppStrings.welcome_Register, textColor: color_white),
              borderRadius: 20.0,
              onPress: () {
                SignUp().launch(context);
              },
            ),
            const SizedBox(
              height: spacing_thirty,
            ),
          ],
        ),
      ),
    );
  }
}
