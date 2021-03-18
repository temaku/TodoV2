import 'dart:convert';
import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../shared_preference.dart';

class UserDataProvider {
  final http.Client httpClient;
  final _baseURL = 'http://10.0.2.2:8181';

  UserDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<void> createUser(User user) async {
    final response = await httpClient.post(
      Uri.http('10.0.2.2:8181', '/signup'),
      headers: (<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }),
      body: jsonEncode(<String, dynamic>{
        'full_name': user.fullname,
        'password': user.password,
        'email': user.email,
        'phone':user.phone,
        
      }),
    );

    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Failed to sign up');
    }
  }

  Future<void> deleteUser(int id) async {
    final response = await httpClient.delete(
      '$_baseURL/user/$id',
      headers: await SharedPreUtils.getStringValuesSF().then((token) {
        print(token);
        return (<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete user.');
    }
  }

  Future<void> updateUser(User user) async {
    final response = await httpClient.put(
      '$_baseURL/user/${user.id}',
      headers: await SharedPreUtils.getStringValuesSF().then((token) {
        print(token);
        return (<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
      }),
      body: jsonEncode(<String, dynamic>{
        'id': user.id,
        'name': user.fullname,
        'pass': user.password,
        'email': user.email,
      }),
    );
    print('status code.${response.statusCode}');
    if (response.statusCode != 200) {
      throw Exception('Failed to update user.');
    }
  }
}
