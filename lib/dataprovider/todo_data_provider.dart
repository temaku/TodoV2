import 'dart:convert';
import 'package:meta/meta.dart';
import '../models/models.dart';

import 'package:http/http.dart' as http;

class TodoDataProvider {
  final _baseURL = 'http://10.0.2.2:8181';

  //final _baseUrl = 'http://192.168.56.1:3000';
  final http.Client httpClient;

  TodoDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Todo> createTodo(Todo todo) async {
    print('creating ');
    try {
      final response = await httpClient.post(
        Uri.http('10.0.2.2:8181', '/todo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': todo.title,
          'description': todo.description,
        }),
      );
      print(response.statusCode);

      if (response.statusCode == 201) {
        print("Create worked");
        return Todo.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create course.');
      }
    } catch (e) {
      print(e.toString());

    }
  }

  Future<List<Todo>> getTodos() async {
    print('getting todo');
    try {
      final response = await httpClient.get('$_baseURL/todos');

      if (response.statusCode == 200) {
        final courses = jsonDecode(response.body) as List;
        return courses.map((course) => Todo.fromJson(course)).toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteTodo(int id) async {
    final http.Response response = await httpClient.delete(
      '$_baseURL/todo/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete course.');
    }
  }

  Future<void> updateTodo(Todo todo) async {
      final http.Response response = await httpClient.put(
        '$_baseURL/todo/${todo.id}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': todo.id,
          'title': todo.title,
          'description':todo.description,
        }),
      );

      if (response.statusCode != 200) {
        print(response.statusCode);
        throw Exception('Failed to update movies.');
      }
    }
  }
