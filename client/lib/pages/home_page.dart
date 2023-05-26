import 'package:chatai/helper/helper_function.dart';
import 'package:chatai/pages/account_page.dart';
import 'package:chatai/pages/conversations_page.dart';
import 'package:chatai/pages/login_page.dart';
import 'package:chatai/pages/universes_page.dart';
import 'package:chatai/services/auth_service.dart';
import 'package:chatai/widgets/sideBar.dart';
import 'package:chatai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        drawer: Sidebar(
          selectedPage: "home",
        ));
  }
}
