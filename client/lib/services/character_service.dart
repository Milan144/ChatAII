import 'dart:convert';

import 'package:chatai/helper/helper_function.dart';
import 'package:http/http.dart' as http;

class CharacterService {
  final String baseUrl = "https://caen0001.mds-caen.yt";

  // Get
  Future<List?> getCharactersFromUniverse(idUniverse) async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();

      if (token!.isEmpty) {
        print(token);
        return null;
      }

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$baseUrl/universes/$idUniverse/characters'),
        headers: headers,
      );

      final List<dynamic> responseData = json.decode(response.body);
      final characters = responseData;

      print(characters);

      // Return the universes list
      return characters;
    } catch (e) {
      return null;
    }
  }

  // Get
  Future<Map<String, dynamic>?> getCharacter(idUniverse, idCharacter) async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();

      if (token!.isEmpty) {
        print(token);
        return null;
      }

      if (idCharacter.isEmpty) {
        print(idCharacter);
        return null;
      }

      if (idUniverse.isEmpty) {
        print(idUniverse);
        return null;
      }

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$baseUrl/universes/$idUniverse/characters/$idCharacter'),
        headers: headers,
      );

      final List<dynamic> responseData = json.decode(response.body);
      final character = responseData;

      print(character);

      return character[0];
    } catch (e) {
      return null;
    }
  }

  // Post
  Future<void> createCharacter(String name, int universeId) async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();
      if (name.isEmpty) {
        return;
      }
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final Map<String, String> body = {
        'name': name,
      };

      final String jsonBody = json.encode(body);

      final response = await http.post(
        Uri.parse('$baseUrl/universes/$universeId/characters'),
        headers: headers,
        body: jsonBody,
      );
      print(response);
    } catch (e) {
      return;
    }
  }

  // Put
  Future<void> generateNewDescForCharacter(int universeId, int characterId) async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await http.post(
        Uri.parse('$baseUrl/universes/$universeId/characters/$characterId'),
        headers: headers,
      );
      print(response);
    } catch (e) {
      return;
    }
  }
}
