import 'dart:convert';

import 'package:chatai/helper/helper_function.dart';
import 'package:http/http.dart' as http;

class ConversationService {
  final String baseUrl = "https://caen0001.mds-caen.yt";

  // Get
  Future<List> getConversations() async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();
      final int? id = await HelperFunctions.getUserIdFromSF();

      if (token!.isEmpty) {
        print("erreur token");
        return ["isEmpty"];
      }

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$baseUrl/conversations'),
        headers: headers,
      );

      final List<dynamic> responseData = json.decode(response.body);
      final conversations = responseData;

      final filteredConversations =
          conversations.where((conversations) => conversations['user_id'] == id).toList();

      print(filteredConversations);

      // Return the universes list
      return filteredConversations;
    } catch (e) {
      return [e];
    }
  }

  // Get
  Future<Map<String, dynamic>?> getConversation(idConversation) async {
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
        Uri.parse('$baseUrl/conversations/$idConversation'),
        headers: headers,
      );

      final List<dynamic> responseData = json.decode(response.body);
      final conversation = responseData;

      print(conversation);

      return conversation[0];
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Post
  Future<void> createConversation(int characterId) async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();
      final int? idUser = await HelperFunctions.getUserIdFromSF();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final Map<String, String> body = {
        'character_id': characterId.toString(),
        'user_id': idUser.toString(),
      };

      final String jsonBody = json.encode(body);

      final response = await http.post(
        Uri.parse('$baseUrl/conversations'),
        headers: headers,
        body: jsonBody,
      );
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  // Del
  Future<void> DeleteConversation(int conversationId) async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.delete(
        Uri.parse('$baseUrl/conversations/$conversationId'),
        headers: headers,
      );
      print(response.body);
    } catch (e) {
      print(e);
    }
  }


}
