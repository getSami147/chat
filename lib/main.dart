import 'package:chat/screens/chatScreen.dart';
import 'package:chat/stateManagement/stateManegementClass.dart';
import 'package:chat/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StateManagementClass(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
                backgroundColor: colorPrimary,
                iconTheme: IconThemeData(color: whiteColor),
                scrolledUnderElevation: 10,
                titleTextStyle: TextStyle(
                  fontSize: 18,
                )),
            colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary),
            useMaterial3: true),
        home: const Chat(),
      ),
    );
  }
}
