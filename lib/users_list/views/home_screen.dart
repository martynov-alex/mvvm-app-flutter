import 'package:flutter/material.dart';
import 'package:mvvm_app_using_providers/users_list/view_models/users_view_model.dart';
import 'package:mvvm_app_using_providers/utils/navigation_utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of users (MVVM Example)'),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<UsersViewModel>().fetchUsers(),
        child: const Icon(Icons.supervised_user_circle_sharp, size: 40),
      ),
      body: Center(
        child: Consumer<UsersViewModel>(
          builder: (context, data, child) {
            if (data.loading) {
              return const CircularProgressIndicator();
            }
            if (data.usersList.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: data.usersList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      data.setSelectedUser(data.usersList.elementAt(index));
                      openUserDetails(context);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${data.usersList.elementAt(index).id}'),
                        backgroundColor: Colors.tealAccent,
                      ),
                      title: Text(data.usersList.elementAt(index).name),
                      subtitle: Text(data.usersList.elementAt(index).email),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(thickness: 1),
              );
            }
            if (data.userError != null) {
              return Text(
                'Error\n${data.userError!.message}',
                style: const TextStyle(fontSize: 20, color: Colors.red),
                textAlign: TextAlign.center,
              );
            }
            return const Text(
              'For loading the list of users\nplease press the button',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }
}
