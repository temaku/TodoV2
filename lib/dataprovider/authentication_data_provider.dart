import 'dart:convert';
import 'package:flutter/material.dart';
import '../shared_preference.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../models/models.dart';

class AuthenticationDataProvider{
  final http.Client httpClient;
  AuthenticationDataProvider({@required this.httpClient}):assert(httpClient!= null);
  
  Future<User>signInWithEmailAndPassword(User user) async{
    print('-----email');
    print(user.email);
    final response = await httpClient.post(
      Uri.http('10.0.2.2:8181', '/login'),
      headers: <String,String>{
        'Content-Type':'application/json;charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{'email':user.email,'password':user.password,})
    );
      print(user.password);
      print(user.email);
      final jwt = jsonDecode(response.body);
      final token = jwt['token'];
      print("token: $token");
    SharedPreUtils.addStringToSF(token);
      Map<String,dynamic> payload = Jwt.parseJwt(token);
      print(payload);
      if(response.statusCode == 200){
          return User(
            email:payload['User']['email'].toString(),
            password:payload['User']['password'].toString(),
            roleID:payload['User']['role_id'],
            fullname:payload['User']['full_name'].toString());


      }else{
        throw Exception('Failed to retrieve user');
    }
  }
  Future<bool> logOut() async{
    SharedPreUtils.destroyStringValuesSF();
    return true;


  }
}
