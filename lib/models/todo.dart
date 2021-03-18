import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class  Todo extends Equatable {
  Todo(
      {this.id,@required this.title, @required this.description,
        });

  final int id;
  final String title;
  final String description;


  @override
  List<Object> get props => [id, title, description];

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],

    );
  }

  @override
  String toString() => 'Todo { id: $id, title: $title, description: $description}';
}