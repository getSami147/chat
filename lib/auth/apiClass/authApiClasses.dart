import 'dart:convert';
import 'package:chat/auth/loginScreen.dart';
import 'package:chat/screens/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/Widget.dart';
import '../../stateManagement/stateManegementClass.dart';

class AuthAPIsClass {
  //SignUp post API........................................................>>>
  userSignUpApi(
      name, email, password, confromP, age, role, gender, context) async {
    var provider = Provider.of<StateManagementClass>(context, listen: false);

    try {
      var headers = {
        'Authorization': 'Bearer null',
        'Content-Type': 'application/json'
      };
      var response = await http.post(Uri.parse(''),
          headers: headers,
          body: json.encode({
            "name": name,
            "email": email,
            "password": password,
            "passwordConfirm": confromP,
            "role": role,
            "age": age,
            "gender": gender
          }));
      var data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        provider.setLoading(true);

        utils().toastMethod(
            'Congrats! Your Account has been Created Succussfully');
        provider.setLoading(false);
        const Login().launch(context);
      } else {
        provider.setLoading(false);

        utils().toastMethod('Server: ${data["message"]}');
      }
    } catch (e) {
      provider.setLoading(false);

      utils().toastMethod("Error:  ${e.toString()}");
    }
  }

// Login Post API........................................................>>>
  getLoginAPI(email, password, context) async {
    var provider = Provider.of<StateManagementClass>(context, listen: false);
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0YThmNDhjZjE3ZGQ2NzBiMjZlNTIxNCIsImlhdCI6MTY4ODk3NDA4NCwiZXhwIjoxNjk2NzUwMDg0fQ.9_Z55aHoZXOfh_8pxErq049vSaqGj2gJQB8C925c4yw',
      'Content-Type': 'application/json'
    };

    try {
      var response = await http.post(
          Uri.parse("http://18.134.150.58:3007/api/v1/users/login"),
          headers: headers,
          body: json.encode({"email": email, "password": password}));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        provider.setLoading(true);

        prefs.setString('usertoken', data["token"]);
        prefs.setString("userid", data["data"]["_id"]);
        const Chat().launch(context);

        utils().toastMethod('Succuss: Congrats! You have Succussfully logined');
        provider.setLoading(false);
      } else {
        provider.setLoading(false);

        utils().toastMethod('Server: ${data["message"]}');
      }
    } catch (e) {
      utils().toastMethod("Error Catch:  ${e.toString()}");
      provider.setLoading(false);
    }
  }

  //Auth Get Me ...........................................................>>
  getMeAuth(context) async {
    var provider = Provider.of<StateManagementClass>(context, listen: false);

    var headers = {'authorization': 'Bearer ${provider.token}'};
    var response = await http.get(
        Uri.parse('http://18.134.150.58:3007/api/v1/users/getMe'),
        headers: headers);

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      utils().toastMethod('Server: ${data["message"]}');

      return data;
    }
  }

// // Update Reviews.........................................................>>>
//   updateMe(context, name, age) async {
//     var provider = Provider.of<StateManagementClass>(context, listen: false);
//     var headers = {
//       'Authorization': 'Bearer ${provider.token}',
//       'Content-Type': 'application/json'
//     };
//     var response = await http.patch(
//         Uri.parse('http://18.134.150.58:3007/api/v1/users/updateMe'),
//         headers: headers,
//         body: json.encode({
//           "name": name,
//           'age': age,
//           "photo": "😎",
//         }));
//     var data = jsonDecode(response.body);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       provider.setLoading(true);
//       utils().toastMethod('Sucucss: Your Profile has been Updated');
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Dashboard(),
//           ));
//       provider.setLoading(false);
//     } else {
//       provider.setLoading(false);

//       utils().toastMethod('Server: ${data["message"]}');

// //
//     }
//   }

//   // Update Reviews.........................................................>>>
//   updatePassword(context, passwordCurrent, password, passwordConfirm) async {
//     var provider = Provider.of<StateManagementClass>(context, listen: false);
//     var headers = {
//       'Authorization': 'Bearer ${provider.token}',
//       'Content-Type': 'application/json'
//     };
//     var response = await http.patch(
//         Uri.parse('http://18.134.150.58:3007/api/v1/users/updatePassword'),
//         headers: headers,
//         body: json.encode({
//           "passwordCurrent": passwordCurrent,
//           "password": password,
//           "passwordConfirm": passwordConfirm
//         }));
//     var data = jsonDecode(response.body);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       provider.setLoading(true);
//       utils()
//           .toastMethod('Succuss: Your Passwoed has been Updated Succusfully');
//       provider.setLoading(false);

//       Navigator.pop(context);
//     } else {
//       provider.setLoading(false);
//       utils().toastMethod('Server: ${data["message"]}');

// //
//     }
//   }

//   //Auth LogOut ...........................................................>>
//   void logOut(context) async {
//     var provider = Provider.of<StateManagementClass>(context, listen: false);

//     var headers = {'Authorization': 'Bearer ${provider.token}'};
//     var response = await http.get(
//         Uri.parse('http://18.134.150.58:3007/api/v1/users/logout'),
//         headers: headers);

//     var logout = jsonDecode(response.body);
//     var data = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => WelcomePage(),
//           ));
//       utils().toastMethod('You have Succusfuly ${data["message"]}');

//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.clear();
//       return logout;
//     } else {
//       utils().toastMethod('Server: ${data["message"]}');

//       return logout;
//     }
//   }
// // Delete Account.......................................................>>>

//   deleteAccount(context) async {
//     var provider = Provider.of<StateManagementClass>(context, listen: false);
//     var headers = {'Authorization': 'Bearer ${provider.token}'};
//     var response = await http.delete(
//         Uri.parse('http://18.134.150.58:3007/api/v1/users/deleteMe'),
//         headers: headers);
//     var data = jsonDecode(response.body);

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.clear();
//       AuthAPIsClass().logOut(context);
//       utils().toastMethod('Succuss: ${data["message"]}');
//     } else {
//       utils().toastMethod('Server: ${data["message"]}');
//     }
//   }

// //
// //
// //
// //
// //
// //
// //Example........................................................................
//   // get Api
//   getApi() async {
//     var response = await http
//         .get(Uri.parse('http://18.134.150.58:3007/api/v1/users/signup'));

//     var data = jsonDecode(response.body);

//     if (response.statusCode == 200) {
//       return data;
//     } else {
//       return data;
//     }
//   }

//   // update
//   updateApi(name, id) async {
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization':
//           'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NDIyYmQxYjQ0MGY2Yjg0M2U3NTYyMmEiLCJpYXQiOjE2ODcyNTkwMDEsImV4cCI6MTY5NTAzNTAwMX0.cURE_EygJ8-O6uOvFD4nNeI5X1cLzAyRnYGXpKLwcAk'
//     };
//     var response = await http.patch(
//         Uri.parse('http://18.134.150.58:3005/api/v1/language/$id'),
//         headers: headers,
//         body: json.encode({"name": name.toString()}));

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("Update successfully");
//     } else {
//       print(response.statusCode);
//       print(response.body);
//       print("something went wrong");
//     }
//   }

// // Delete
//   deleteApi(id) async {
//     var headers = {
//       'Authorization':
//           'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NDIyYmQxYjQ0MGY2Yjg0M2U3NTYyMmEiLCJpYXQiOjE2ODcyNTkwMDEsImV4cCI6MTY5NTAzNTAwMX0.cURE_EygJ8-O6uOvFD4nNeI5X1cLzAyRnYGXpKLwcAk'
//     };
//     var response = await http.delete(
//         Uri.parse('http://18.134.150.58:3005/api/v1/language/$id'),
//         headers: headers);

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("Delete Successfully");
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
}
