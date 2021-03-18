import '../pages/screens.dart';
import '../bloc/bloc.dart';
import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateTodo extends StatefulWidget {
  static const routeName = 'AddUpdateTodo';
  final TodoArguments args;

  AddUpdateTodo({this.args});
  @override
  _AddUpdateTodoState createState() => _AddUpdateTodoState();
}

class _AddUpdateTodoState extends State<AddUpdateTodo> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _todo = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text('${widget.args.edit ? "Edit Todo" : "Add New Todo"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(30),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                    initialValue: widget.args.edit ? widget.args.todo.title : '',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter todo title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white
                          ),
                          borderRadius: BorderRadius.circular(3)
                        ),
                        labelText: 'Todo title',
                      labelStyle: TextStyle(
                        color: Colors.white
                      )),

                    onSaved: (value) {
                      setState(() {
                        this._todo["title"] = value;
                      });
                    }),
              ),
              Container(
                margin: EdgeInsets.all(30),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),

                    initialValue:
                    widget.args.edit ? widget.args.todo.description : '',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter todo  description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Todo Description",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3)
                        ),

                        ),
                    onSaved: (value) {
                      this._todo["description"] = value;
                    }),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      final TodoEvent event = widget.args.edit
                          ? TodoUpdate(
                        Todo(
                          id: widget.args.todo.id,
                          title: this._todo["title"],
                          description: this._todo["description"],
                        ),
                      )
                          :TodoCreate(
                        Todo(
                          title: this._todo["title"],
                          description: this._todo["description"],
                        ),
                      );
                      BlocProvider.of<TodoBloc>(context).add(event);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AdminPage.routeName, (route) => false);
                    }
                  },
                  label: Text('SAVE',style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.save,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}