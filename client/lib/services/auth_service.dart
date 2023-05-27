import 'dart:convert';
import 'package:chatai/helper/helper_function.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://caen0001.mds-caen.yt";

  Future<void> registerUser(String email, String password, String lastname,
      String firstname, String username) async {
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final Map<String, String> body = {
        'lastname': lastname,
        'firstname': firstname,
        'username': username,
        'email': email,
        'password': password,
      };

      final String jsonBody = json.encode(body);

      final response = await http.post(
        Uri.parse('$baseUrl/users'),
        headers: headers,
        body: jsonBody,
      );
      print(response.body);
    } catch (e) {
      // Gestion des erreurs
    }
  }

  Future<void> loginUser(String username, String password) async {
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final Map<String, String> body = {
        'username': username,
        'password': password,
      };

      final String jsonBody = json.encode(body);

      final response = await http.post(
        Uri.parse('$baseUrl/auth'),
        headers: headers,
        body: jsonBody,
      );

      //recuperer le token dans le json de la response.body
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String token = responseData['token'] ?? '';
      final int id = responseData['id'] ?? 0;
      await HelperFunctions.saveUserTokenSF(token);
      await HelperFunctions.saveUserIdSF(id);
      await HelperFunctions.saveUserLoggedInStatus(true);
    } catch (e) {
      // Gestion des erreurs
    }
  }

  //logout just use helper functions
  Future<void> logoutUser() async {
    await HelperFunctions.saveUserLoggedInStatus(false);
    await HelperFunctions.saveUserTokenSF('');
  }
}
