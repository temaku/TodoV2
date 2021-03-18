import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../login.dart';

class UserPage extends StatefulWidget {
  static const routeName = '/user';

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
          title: Text('List of Courses'),
          backgroundColor: Colors.white10,
          actions: <Widget>[
            PopupMenuButton(
                itemBuilder: (_) => [
                      PopupMenuItem(
                        child: ListTile(
                          tileColor: Colors.white,
                          leading: Icon(Icons.logout),
                          title: Text("Log Out"),
                          onTap: () {
                            showAlert(context);
                          },
                        ),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          tileColor: Colors.white,
                          leading: Icon(Icons.adb_outlined),
                          title: Text("About us"),
                          onTap: () {
                            print("About us");
                          },
                        ),
                        value: 2,
                      )
                    ])
          ]),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (_, state) {
          if (state is TodoDeleteFailure) {
            _scafoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Delete failed'),
            ));
          }
        },
        builder: (_, state) {
          if (state is TodoOperationFailure) {
            return Text('Could not do course operation');
          }

          if (state is TodoLoadSuccess) {
            final courses = state.todos;

            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (_, idx) => Card(
                color: Colors.black12,
                elevation: 1.0,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    // padding: EdgeInsets.only(right: 12.0),
                    decoration: BoxDecoration(
                        border: Border(
                            right:
                                BorderSide(width: 1.0, color: Colors.white24))),
                    child: Icon(
                      Icons.today_outlined,
                      color: Colors.white,
                    ),
                  ),

                  title: Text(
                    '${courses[idx].title}',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${courses[idx].description}',
                    style: TextStyle(color: Colors.white),
                  ),
                  //  trailing: IconButton(icon: Icon(Icons.remove_circle,color: Colors.red,), onPressed: () {
                  // context.read<TodoBloc>().add(TodoDelete(courses[idx],));
                  // }),
                  //   onTap: () => Navigator.of(context)
                  //       .pushNamed(TodoDetail.routeName, arguments: courses[idx]),
                ),
              ),
            );
          }

          return CircularProgressIndicator();
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black,
      //   onPressed: () => Navigator.of(context).pushNamed(
      //     AddUpdateTodo.routeName,
      //     arguments: TodoArguments(edit: false),
      //   ),
      //   child: Icon(Icons.add),
      // ),
    );
  }

  showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure to Log out?"),
            actions: [
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  context.read<AuthenticationBloc>().add(UserLoggedOut());
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName(SignInPage.routeName));
                },
              ),
              FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
}
