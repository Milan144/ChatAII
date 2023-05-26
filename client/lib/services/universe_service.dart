import 'dart:convert';

import 'package:chatai/helper/helper_function.dart';
import 'package:http/http.dart' as http;

class UniverseService {
  final String baseUrl = "https://caen0001.mds-caen.yt";

  // Get
  // Get
  Future<List<dynamic>> getUniverses() async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();
      final int? id = await HelperFunctions.getUserIdFromSF();

      if (token!.isEmpty) {
        print("Erreur de token");
        return [];
      }

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$baseUrl/universes'),
        headers: headers,
      );

      final List<dynamic> responseData = json.decode(response.body);
      final List<dynamic> universes = responseData;

      final filteredUniverses =
          universes.where((universe) => universe['creator_id'] == id).toList();

      print(filteredUniverses);

      // Return the universes list
      return filteredUniverses;
    } catch (e) {
      print('Erreur lors de la récupération des univers : $e');
      return [];
    }
  }

  // Get
  Future<Map<String, dynamic>?> getUniverse(idUniverse) async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();

      if (token!.isEmpty) {
        print(token);
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
        Uri.parse('$baseUrl/universes/$idUniverse'),
        headers: headers,
      );

      final List<dynamic> responseData = json.decode(response.body);
      final universes = responseData;

      print(universes);

      return universes[0];
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Post
  Future<void> createUniverse(String name) async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final Map<String, String> body = {
        'name': name,
      };

      final String jsonBody = json.encode(body);

      final response = await http.post(
        Uri.parse('$baseUrl/universes'),
        headers: headers,
        body: jsonBody,
      );
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  // Put
  Future<void> renameUniverse(String name, int universeId) async {
    try {
      if (name.isEmpty) {
        return;
      }
      final String? token = await HelperFunctions.getUserTokenFromSF();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final Map<String, String> body = {
        'name': name,
      };

      final String jsonBody = json.encode(body);

      final response = await http.put(
        Uri.parse('$baseUrl/universes/$universeId'),
        headers: headers,
        body: jsonBody,
      );
      print(response.body);
    } catch (e) {
      print(e);
    }
  }
}
