import 'dart:async';

import 'package:chat/auth/welcome.dart';
import 'package:chat/screens/chatScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

class StateManagementClass with ChangeNotifier {
  bool _passwordObsecure = true;
  bool _passwordObsecure2 = true;
  var token;
  var userid;

  bool get passwordObsecure => _passwordObsecure;
  bool get passwordObsecure2 => _passwordObsecure2;

  // ObSecure Text 1..........................................................>>>
  void setIconChange() {
    _passwordObsecure = !_passwordObsecure;
    notifyListeners();
  }

  // ObSecure Text 2..........................................................>>>
  void setIconChange2() {
    _passwordObsecure2 = !_passwordObsecure2;
    notifyListeners();
  }

  // //isLoading..........................................................>>>
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  // isCheack Login ..........................................................>>>
  // void isCheackLogin(context) async {
  //   String? logintoken;
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   logintoken = prefs.getString("usertoken");
  //   if (logintoken == null) {
  //     const Welcome().launch(context);
  //   } else {
  //     const Chat().launch(context);
  //   }s
  //   notifyListeners();
  // }

  // Get Token..........................................................>>>
  void getToken(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("usertoken");
    userid = prefs.getString('userid');

    notifyListeners();
  }
}
