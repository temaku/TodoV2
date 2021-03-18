import 'package:equatable/equatable.dart';
import '../models/models.dart';

class TodoState extends Equatable{
  const TodoState();

  @override
  List<Object> get props => [];

}
class TodoLoading extends TodoState{

}
class TodoLoadSuccess extends TodoState{
  final List<Todo> todos;
  TodoLoadSuccess([this.todos = const []]);
  @override
  List<Object> get props => [todos];

}
class TodoOperationFailure extends TodoState{}
class TodoDeleteFailure extends TodoState{}