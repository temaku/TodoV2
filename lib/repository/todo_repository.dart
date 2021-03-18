import '../dataprovider/data_provider.dart';
import 'package:meta/meta.dart';
import '../models/models.dart';

class TodoRepository {
  final TodoDataProvider dataProvider;

  TodoRepository({@required this.dataProvider}) :assert(dataProvider != null);

  Future<Todo> createTodo(Todo todo) async {
    return await dataProvider.createTodo(todo);
  }

  Future<List<Todo>> getTodos() async {
    return await dataProvider.getTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    return await dataProvider.updateTodo(todo);
  }

  Future<void> deleteTodo(int id) async {
    return await dataProvider.deleteTodo(id);
  }

}
