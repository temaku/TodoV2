
import '../pages/screens.dart';
import '../models/models.dart';
import '../login.dart';
import '../sign_up.dart';
import 'package:flutter/material.dart';

class TodoAppRoute{
  static Route generateRoute(RouteSettings settings){
    if(settings.name == '/'){
      return MaterialPageRoute(builder: (context)=>UserPage());

    }
    if(settings.name == AddUpdateTodo.routeName){
      TodoArguments args = settings.arguments;
      return MaterialPageRoute(
          builder: (context)=>AddUpdateTodo(args:args));

    }
    if(settings.name == TodoDetail.routeName){
      Todo todo = settings.arguments;
      return MaterialPageRoute(builder:
      (context)=> TodoDetail(todo: todo));
    }
     if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => SignInPage());
    }

    if (settings.name == UserPage.routeName) {
      return MaterialPageRoute(builder: (context) => UserPage());
    }

    if (settings.name == AdminPage.routeName) {
      return MaterialPageRoute(builder: (context) => AdminPage());
    }

    if (settings.name == SignUpPage.routeName) {
      return MaterialPageRoute(builder: (context) => SignUpPage());
    }
  
    return MaterialPageRoute(builder: (context)=>UserPage());
  }

}
class TodoArguments {
  final Todo todo;
  final bool edit;
  TodoArguments({this.todo, this.edit});
}