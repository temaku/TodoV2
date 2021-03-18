import 'package:equatable/equatable.dart';
import '../models/models.dart';


abstract class TodoEvent extends Equatable{
    const TodoEvent();
}
class TodoLoad extends TodoEvent{
  const TodoLoad();

  @override
  List<Object> get props => [];

}
class TodoCreate extends TodoEvent{
  final Todo todo;
  const TodoCreate(this.todo);

  @override
  List<Object> get props => [todo];
  @override
  String toString() => 'Todo Created {todo:$todo}';
}
class TodoUpdate extends TodoEvent{
    final Todo todo;
    TodoUpdate(this.todo);

  @override
  List<Object> get props => [todo];
  @override
  String toString() => 'Todo updated {todo:$todo}';

}
class TodoDelete extends TodoEvent{
   final Todo todo;
   TodoDelete(this.todo);
  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'Todo deleted {todo:$todo}';
}
