import 'dart:convert';

import 'package:chatai/helper/helper_function.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = "https://caen0001.mds-caen.yt";

  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();
      final int? id = await HelperFunctions.getUserIdFromSF();

      if (token!.isEmpty) {
        print(token);
        return null;
      }

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$baseUrl/users/$id'),
        headers: headers,
      );

      final List<dynamic> responseData = json.decode(response.body);
      final user = responseData[0];

      print(user);

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> updateUser(
    String username,
    String email,
    String lastname,
    String firstname,
  ) async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();
      final int? id = await HelperFunctions.getUserIdFromSF();

      if (token!.isEmpty) {
        // Gérer le cas où le token est vide
        print("Token is empty");
        return;
      }

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final Map<String?, dynamic> userData = {
        'username': username,
        'email': email,
        'lastname': lastname,
        'firstname': firstname,
      };

      final response = await http.put(
        Uri.parse('$baseUrl/users/$id'),
        headers: headers,
        body: json.encode(userData),
      );

      print(userData);
      print(response.body);

      if (response.statusCode == 200) {
        // Les informations utilisateur ont été mises à jour avec succès
        print('User information updated successfully');
      } else {
        // Gérer les erreurs de mise à jour des informations utilisateur
        print('Failed to update user information');
      }
    } catch (e) {
      // Gérer les exceptions
      print('An error occurred: $e');
    }
  }
}
