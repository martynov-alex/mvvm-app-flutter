import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:mvvm_app_using_providers/users_list/models/user_error.dart';
import 'package:mvvm_app_using_providers/users_list/models/users_list_model.dart';
import 'package:mvvm_app_using_providers/users_list/repo/api_status.dart';
import 'package:mvvm_app_using_providers/users_list/repo/user_services.dart';

class UsersViewModel extends ChangeNotifier {
  /// Getters
  bool get loading => _loading;
  UnmodifiableListView<UserModel> get usersList => UnmodifiableListView(_usersList);
  UserModel get selectedUser => _selectedUser;
  UserError? get userError => _userError;

  bool _loading = false;
  Iterable<UserModel> _usersList = [];
  late UserModel _selectedUser;
  UserError? _userError;

  /// Setters
  void setSelectedUser(UserModel selectedUser) {
    _selectedUser = selectedUser;
    notifyListeners();
  }

  void startStopLoading() {
    _loading = !_loading;
    notifyListeners();
  }

  // TODO(martynov): Или лучше сделать отдельные методы: startLoading и stopLoading?
  // void startLoading() {
  //   _loading = true;
  //   notifyListeners();
  // }
  //
  // void stopLoading() {
  //   _loading = false;
  //   notifyListeners();
  // }

  /// The [getUsers] method
  Future<void> getUsers() async {
    _userError = null;
    _usersList = [];

    startStopLoading();
    final response = await UserServices.getUsers();
    await Future<void>.delayed(const Duration(seconds: 1));

    if (response is Success) {
      _usersList = response.usersList as List<UserModel>;
    }
    if (response is Failure) {
      _userError = UserError(code: response.code, message: response.errorMessage);
    }
    startStopLoading();
  }
}
