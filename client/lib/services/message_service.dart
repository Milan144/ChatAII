import 'dart:convert';

import 'package:chatai/helper/helper_function.dart';
import 'package:http/http.dart' as http;

class MessageService {
  final String baseUrl = "https://caen0001.mds-caen.yt";

  // Get
  Future<List> getMessagesOfConversation(int idConversation) async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();

      if (token!.isEmpty) {
        print("erreur token");
        return ["isEmpty"];
      }

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$baseUrl/conversations/$idConversation/messages'),
        headers: headers,
      );

      final List<dynamic> responseData = json.decode(response.body);
      final messages = responseData;

      print(messages);

      // Return the universes list
      return messages;
    } catch (e) {
      return [e];
    }
  }

  // Get
  Future<Map<String, dynamic>?> getMessageOfConversation(int idConversation, int idMessage) async {
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
        Uri.parse('$baseUrl/conversations/$idConversation/messages/$idMessage'),
        headers: headers,
      );

      final List<dynamic> responseData = json.decode(response.body);
      final message = responseData;

      print(message);

      return message[0];
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Post
  Future<void> sendNewMessage(int idConversation, String content ) async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();

      if (token!.isEmpty) {
        print("erreur token");
        return;
      }
      if (content.isEmpty) {
        print("erreur content");
        return;
      }

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final Map<String, String> body = {
        'content': content,
      };

      final String jsonBody = json.encode(body);

      final response = await http.post(
        Uri.parse('$baseUrl/conversations/$idConversation/messages'),
        headers: headers,
        body: jsonBody,
      );
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  // Put
  Future<void> regenerateLastMessage(int conversationId) async {
    try {
      final String? token = await HelperFunctions.getUserTokenFromSF();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.put(
        Uri.parse('$baseUrl/conversations/$conversationId'),
        headers: headers,
      );
      print(response.body);
    } catch (e) {
      print(e);
    }
  }
}
