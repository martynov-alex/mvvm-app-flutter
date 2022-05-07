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
  UserError? get userError => _userError;

  bool _loading = false;
  Iterable<UserModel> _usersList = [];
  UserError? _userError;

  /// Setters
  ///
  /// We call [notifyListeners] only in [startLoading] method for optimization.
  void startLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void setUsersList(Iterable<UserModel> usersList) {
    _usersList = usersList;
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  void setUserErrorToNull() {
    _userError = null;
  }

  /// The [getUsers] method
  Future<void> getUsers() async {
    setUserErrorToNull();

    startLoading(true);
    final response = await UserServices.getUsers();
    await Future<void>.delayed(const Duration(seconds: 1));

    if (response is Success) {
      setUsersList(response.data as List<UserModel>);
    }
    if (response is Failure) {
      final userError = UserError(code: response.code, message: response.errorMessage);
      setUserError(userError);
    }
    startLoading(false);
  }
}
