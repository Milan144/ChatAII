import 'package:chatai/services/auth_service.dart';
import 'package:chatai/services/user_service.dart';
import 'package:chatai/widgets/sideBar.dart';
import 'package:chatai/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  String username = "";
  String useremail = "";
  String lastname = "";
  String firstname = "";

  @override
  void initState() {
    super.initState();
    gettingUserInfos();
  }

  void gettingUserInfos() async {
    Map<String, dynamic>? userData = await _userService.getCurrentUser();
    if (userData != null) {
      setState(() {
        username = userData['username'];
        useremail = userData['email'];
        firstname = userData['firstName'];
        lastname = userData['lastName'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    gettingUserInfos();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Account",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Sidebar(
        selectedPage: "account",
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF6200EE),
                Colors.white,
              ],
              stops: [
                0.0,
                0.9
              ]),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "You can make changes to your account here!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset("assets/icon_ninja.png"),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: "User Name",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    initialValue: username,
                    onChanged: (val) {
                      setState(() {
                        username = val;
                      });
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your username";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: "Email",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    initialValue: useremail,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your email address";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        useremail = val;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: "First Name",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    initialValue: firstname,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your first name";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        firstname = val;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: "Last Name",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    initialValue: lastname,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your last name";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        lastname = val;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print("User Name: $username");
                          print("User Email: $useremail");
                          print("User First Name: $firstname");
                          print("User Last Name: $lastname");
                          _userService.updateUser(
                            username,
                            useremail,
                            lastname,
                            firstname,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
