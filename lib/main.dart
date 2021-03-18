import 'login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import './bloc/bloc.dart';
import './repository/repository.dart';
import './dataprovider/data_provider.dart';
import './pages/screens.dart';

void main() {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository(
    dataProvider: AuthenticationDataProvider(
      httpClient: http.Client(),
    ),
  );

  final UserRepository userRepository = UserRepository(
    dataProvider: UserDataProvider(
      httpClient: http.Client(),
    ),
  );
  final TodoRepository todoRepository = TodoRepository(
    dataProvider: TodoDataProvider(
      httpClient: http.Client(),
    ),
  );
  runApp(
    EthioCinemaApp(
      userRepository: userRepository,
      authenticationRepository: authenticationRepository,
      todoRepository: todoRepository,
      //userRecipeRepository: userRecipeRepository,
    ),
  );
}

class EthioCinemaApp extends StatelessWidget {
  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;
  final TodoRepository todoRepository;

  EthioCinemaApp(
      {@required this.userRepository,
      @required this.authenticationRepository,
      @required this.todoRepository})
      : assert(userRepository != null || authenticationRepository != null ||todoRepository != null);
//

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => this.userRepository),
        RepositoryProvider(create: (context) => this.authenticationRepository),
        RepositoryProvider(create: (context) => this.todoRepository),
        //  RepositoryProvider(create: (context) => this.userRecipeRepository),
      ],
      //value: this.recipeRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthenticationBloc(
                  authenticationRepository: this.authenticationRepository)),
          BlocProvider(
              create: (context) => UserBloc(
                  authenticationBloc: AuthenticationBloc(
                      authenticationRepository: authenticationRepository),
                  authenticationRepository: authenticationRepository,
                  userRepository: this.userRepository)),
          BlocProvider(
            lazy: false,
            create: (context) => TodoBloc(todoRepository: todoRepository)..add(TodoLoad()),
          )
        ],
        // create: (context) => RecipeBloc(recipeRepository: this.recipeRepository)..add(RecipeRetrieve()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: ThemeData.light().textTheme.copyWith(),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (_, state) {
            if (state is AuthenticationAuthenticated) {
              final user = state.user;
              print(user.id);
              if (user.roleID == 2) {
                return AdminPage();
              }
              return UserPage();
            } else {
              print(state);
              return AuthForm();
            }
          }),
          onGenerateRoute: TodoAppRoute.generateRoute,
        ),
      ),
    );
  }
}
