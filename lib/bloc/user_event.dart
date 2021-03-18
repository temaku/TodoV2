import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserCreate extends UserEvent {
  final User user;

  UserCreate(@required this.user);

  @override
  List<Object> get props => [user];
}

class UserUpdate extends UserEvent {
  final User user;
  const UserUpdate(this.user);
  @override
  List<Object> get props => [user];
}

class UserDelete extends UserEvent {
  final User user;
  const UserDelete(this.user);

  @override
  List<Object> get props => [user];
}
