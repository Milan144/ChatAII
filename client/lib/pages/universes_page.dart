import 'package:flutter/material.dart';
import 'package:chatai/helper/helper_function.dart';
import 'package:chatai/widgets/sideBar.dart';
import 'package:chatai/services/universe_service.dart';
import 'package:chatai/widgets/universeTile.dart';

class UniversesPage extends StatefulWidget {
  const UniversesPage({Key? key}) : super(key: key);

  @override
  State<UniversesPage> createState() => _UniversesPageState();
}

class _UniversesPageState extends State<UniversesPage> {
  final UniverseService _universeService = UniverseService();

  List<dynamic> universes = [];

  @override
  void initState() {
    super.initState();
    id();
    fetchUniverses();
  }

  void id() async {
    final int? id = await HelperFunctions.getUserIdFromSF();
    print(id);
  }

  void fetchUniverses() async {
    try {
      List<dynamic> fetchedUniverses = await _universeService.getUniverses();

      setState(() {
        universes = fetchedUniverses;
      });

      print(universes);
    } catch (e) {
      print('Erreur lors de la récupération des univers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Universes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Sidebar(selectedPage: "universes"),
      body: ListView.builder(
        itemCount: universes.length,
        itemBuilder: (BuildContext context, int index) {
          final universe = universes[index];
          return UniverseTile(
            name: universe['name'],
            id: universe['id'],
          );
        },
      ),
    );
  }
}
