import 'package:chatai/services/character_service.dart';
import 'package:chatai/widgets/characterTile.dart';
import 'package:flutter/material.dart';
import 'package:chatai/helper/helper_function.dart';
import 'package:chatai/widgets/sideBar.dart';

class CharactersPage extends StatefulWidget {
  final int? idUniverse;

  const CharactersPage({Key? key, required this.idUniverse}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final CharacterService _characterService = CharacterService();

  List<dynamic> characters = [];

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  void id() async {
    final int? id = await HelperFunctions.getUserIdFromSF();
    print(id);
  }

  void fetchCharacters() async {
    try {
      List<dynamic>? fetchedCharacters =
          await _characterService.getCharactersFromUniverse(widget.idUniverse);
      setState(() {
        characters = fetchedCharacters!;
      });

      print(characters);
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
        itemCount: characters.length,
        itemBuilder: (BuildContext context, int index) {
          final character = characters[index];
          return CharacterTile(
            name: character['name'],
          );
        },
      ),
    );
  }
}
