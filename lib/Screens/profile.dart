import 'package:flutter/material.dart';

import '../resources/auth_material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 300,
          ),
          ElevatedButton(
              onPressed: () {
                AuthMethods().signout();
              },
              child: const Text("Sign out"))
        ],
      ),
    );
  }
}
