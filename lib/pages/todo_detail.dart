import '../models/models.dart';
import '../pages/screens.dart';
import '../bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TodoDetail extends StatelessWidget {
  static const routeName = 'TodoDetail';
  final Todo todo;

  TodoDetail({@required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text('${this.todo.title}'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              AddUpdateTodo.routeName,
              arguments: TodoArguments(todo: this.todo, edit: true),
            ),
          ),
          SizedBox(
            width: 32,
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<TodoBloc>().add(TodoDelete(this.todo));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AdminPage.routeName, (route) => false);
              }),
        ],
      ),
      body: Card(
         color: Colors.black12,
        elevation: 2,
        child: ListTile(
                title: Text('Title: ${this.todo.title}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17)),
                subtitle: Text('Description: ${this.todo.description}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17)),
              ),
      ),




    );
  }
}