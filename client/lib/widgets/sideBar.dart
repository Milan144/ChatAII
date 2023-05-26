import 'package:chatai/helper/helper_function.dart';
import 'package:chatai/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:chatai/pages/account_page.dart';
import 'package:chatai/pages/conversations_page.dart';
import 'package:chatai/pages/login_page.dart';
import 'package:chatai/pages/universes_page.dart';
import 'package:chatai/services/auth_service.dart';
import 'package:chatai/widgets/widgets.dart';

class Sidebar extends StatelessWidget {
  final String selectedPage;

  final AuthService _authService = AuthService();

  Sidebar({
    super.key,
    required this.selectedPage,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: <Widget>[
          Icon(
            Icons.account_circle,
            size: 150,
            color: Colors.grey[700],
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "username",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Divider(
            height: 2,
          ),
          ListTile(
            onTap: () {
              nextScreen(context, const HomePage());
            },
            selectedColor: Theme.of(context).primaryColor,
            selected: selectedPage == "home",
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(
              Icons.group,
            ),
            title: const Text(
              "Home",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              nextScreen(context, const HomePage());
            },
            selectedColor: Theme.of(context).primaryColor,
            selected: selectedPage == "account",
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(
              Icons.group,
            ),
            title: const Text(
              "My Account",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              nextScreen(context, const UniversesPage());
            },
            selectedColor: Theme.of(context).primaryColor,
            selected: selectedPage == "universes",
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.unfold_more_double),
            title: const Text(
              "My Universes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              nextScreen(context, const ConversationPage());
            },
            selectedColor: Theme.of(context).primaryColor,
            selected: selectedPage == "conversations",
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(
              Icons.chat_bubble,
            ),
            title: const Text(
              "My Conversations",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (builder) {
                    return AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.cancel, color: Colors.red)),
                        IconButton(
                            onPressed: () async {
                              await _authService.logoutUser();
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            },
                            icon: const Icon(Icons.done, color: Colors.green)),
                      ],
                    );
                  });
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
