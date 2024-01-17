import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RemoteLogin {
  Future login(email, password) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request =
        http.Request('POST', Uri.parse('http://192.168.236.25:8080/api/login'));
    request.bodyFields = {'email': '$email', 'password': '$password'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var token = await response.stream.bytesToString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);

    if (response.statusCode == 200) {
      // print(prefs.getString('token'));
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}


// class RemoteLogin {
//   Future login(LoginModel user) async {
//     print(jsonEncode(user));
//     final response = await http.post(
//         Uri.parse('http://10.252.101.244:8000/api/login'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8'
//         },
//         body: jsonEncode(user));

//     var data = jsonDecode(response.body);
//     LoginModel? user1;

//     if (response.statusCode == 200) {
//       // print('yes');
//       user1 = LoginModel.fromJson(data);
//       return user1;
//     } else {
//       // print('no');
//       user1 = LoginModel.fromJsonFail(data);
//       //return user1;
//     }

//     if (user1.success == true) {
//       return user1;
//     } else {
//       user1.success == false;
//       return user1;
//     }
//   }
// }
