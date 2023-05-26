import 'package:chatai/pages/account_page.dart';
import 'package:chatai/pages/home_page.dart';
import 'package:chatai/pages/universes_page.dart';
import 'package:chatai/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../pages/conversations_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigation vers la page correspondante
    switch (index) {
      case 0:
        nextScreen(context, const UniversesPage());
        break;
      case 1:
        nextScreen(context, const HomePage());
        break;
      case 2:
        nextScreen(context, const ConversationPage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(144, 168, 64, 168),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.unfold_more),
            label: 'Universes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(144, 168, 64, 168),
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
    );
  }
}
