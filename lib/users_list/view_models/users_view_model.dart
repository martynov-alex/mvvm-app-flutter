import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:mvvm_app_using_providers/users_list/models/user_error.dart';
import 'package:mvvm_app_using_providers/users_list/models/users_list_model.dart';
import 'package:mvvm_app_using_providers/users_list/repository/api_status.dart';
import 'package:mvvm_app_using_providers/users_list/repository/user_services.dart';

class UsersViewModel extends ChangeNotifier {
  bool get loading => _loading;
  UnmodifiableListView<UserModel> get usersList => UnmodifiableListView(_usersList);
  UserModel get selectedUser => _selectedUser;
  UserError? get userError => _userError;

  bool _loading = false;
  Iterable<UserModel> _usersList = [];
  late UserModel _selectedUser;
  UserError? _userError;

  void setSelectedUser(UserModel selectedUser) {
    _selectedUser = selectedUser;
    notifyListeners();
  }

  void toggleLoading() {
    _loading = !_loading;
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    _userError = null;
    _usersList = [];

    toggleLoading();
    final response = await UserServices.getUsers();
    await Future<void>.delayed(const Duration(seconds: 1));

    if (response is Success) {
      _usersList = response.usersList as List<UserModel>;
    }
    if (response is Failure) {
      _userError = UserError(code: response.code, message: response.errorMessage);
    }
    toggleLoading();
  }
}
