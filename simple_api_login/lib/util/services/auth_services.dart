import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_api_login/util/services/services.dart';

class AuthServices extends Services{
  Future<String> loginUser(String email, String password) async{
    var res = await http.post(
      loginURL,
      body: {
        "email": email,
        "password": password,
      },
    ).catchError((e){
      throw(e);
    });
    print(res.body);
    print(res.statusCode);
    if(res.statusCode == 200){
      print("ghdhg");
      Map json = jsonDecode(res.body);
      return "${json['message']}";
    }else{
      String msg = "";
      if(res.body.contains("html")){
        msg = "Server Error";
      }else{
        msg = jsonDecode(res.body)['message'];
      }
      return msg;
    }
  }

  Future<String> registerUser(String email, String fName,
      String lName, String password) async{
    var res = await http.post(
      registerURL,
      body: {
        "firstname": fName,
        "lastname": lName,
        "email": email,
        "password": password,
      },
    ).catchError((e){
      throw(e);
    });

    print("${res.body}");
    if(res.statusCode == 200){
      Map json = jsonDecode(res.body);
      return "Register succefully";
    }else{
      String msg = "";
      if(res.body.contains("html")){
        msg = "Server Error";
      }else{
        msg = jsonDecode(res.body)['message'];
      }
      return msg;
    }
  }
}