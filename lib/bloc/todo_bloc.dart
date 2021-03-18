
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../repository/repository.dart';

class TodoBloc extends Bloc<TodoEvent,TodoState>{
   final TodoRepository todoRepository;
   TodoBloc({@required this.todoRepository}):super(TodoLoading());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async*{
    if(event is TodoLoad){
      yield TodoLoading();
      try{
        final todos = await todoRepository.getTodos();
        yield TodoLoadSuccess(todos);
      }catch(e){
        yield TodoOperationFailure();
      }
    }
    if(event is TodoUpdate){
      print('...........update t');
      try{
        await todoRepository.updateTodo(event.todo);
        final todos = await todoRepository.getTodos();
        yield TodoLoadSuccess(todos);
      }catch(e){
        print('----------bloc 30');
        print(e.toString());
        yield TodoOperationFailure();

      }
    }

    if(event is TodoCreate){
      print('-----------------create t');
      try{
        await todoRepository.createTodo(event.todo);
        final todos = await todoRepository.getTodos();
        yield TodoLoadSuccess(todos);
      }catch(e){
        print('----------bloc 39');
        print(e.toString());
        yield TodoOperationFailure();

      }
    }
    if(event is TodoDelete){
      try{
        await todoRepository.deleteTodo(event.todo.id);
        final todos = await todoRepository.getTodos();
        yield TodoLoadSuccess(todos);
      }catch(e){
        print(e.toString());
        yield TodoDeleteFailure();
      }
    }

  }

}