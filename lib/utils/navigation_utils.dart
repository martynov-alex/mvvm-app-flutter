import 'package:flutter/material.dart';
import 'package:mvvm_app_using_providers/users_list/views/user_details_screen.dart';

Future<void> openUserDetails(BuildContext context) async {
  await Navigator.push<void>(
    context,
    MaterialPageRoute<void>(builder: (context) => const UserDetailsScreen()),
  );
}
