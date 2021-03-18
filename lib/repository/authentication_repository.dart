import '../dataprovider/data_provider.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';

class AuthenticationRepository {
  final AuthenticationDataProvider dataProvider;
  AuthenticationRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<User> getCurrentUser() async {
  }

  Future<void> signOut() async {
    await dataProvider.logOut();
  }

  Future<User> signInWithEmailAndPassword(User user) async {
    return await dataProvider.signInWithEmailAndPassword(user);
  }
}
