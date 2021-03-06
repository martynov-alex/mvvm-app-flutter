import 'package:flutter/material.dart';
import 'package:mvvm_app_using_providers/users_list/components/custom_listtile_widget.dart';
import 'package:mvvm_app_using_providers/users_list/view_models/users_view_model.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedUser = context.read<UsersViewModel>().selectedUser;
    return Scaffold(
      appBar: AppBar(title: const Text('User details'), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomListTile(icon: Icons.person, title: selectedUser.name, subtitle: 'Name'),
              CustomListTile(icon: Icons.alternate_email, title: selectedUser.email, subtitle: 'Email'),
              CustomListTile(icon: Icons.phone, title: selectedUser.phone, subtitle: 'Phone'),
              CustomListTile(
                icon: Icons.home,
                title: '${selectedUser.address.zipcode} / ${selectedUser.address.city}',
                subtitle: 'Zip code / City',
              ),
              CustomListTile(icon: Icons.location_city, title: selectedUser.company.name, subtitle: 'Company'),
              CustomListTile(icon: Icons.web, title: selectedUser.website, subtitle: 'Website'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('Back', style: TextStyle(fontSize: 18, color: Colors.tealAccent)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
