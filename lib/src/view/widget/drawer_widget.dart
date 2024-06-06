import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Sina",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 12),
              Text(
                "${FirebaseAuth.instance.currentUser?.email}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Divider(),
              const ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home_outlined),
              ),
              const ListTile(
                title: Text('My Cart'),
                leading: Icon(Icons.shopping_bag_outlined),
              ),
              ListTile(
                onTap: (){
                  FirebaseAuth.instance.signOut();
                },
                title: const Text('Logout'),
                leading: const Icon(Icons.logout_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }
}
