import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../app_helper.dart';
import '../models/todo_model.dart';
import '../screens/login_page.dart';

class ApiService {
  final String _baseUrl = AppHelper.baseUrl;

  Future<List<Todo>> getTodos() async {
    final token = await AppHelper.getToken();
    Uri url = Uri.parse("$_baseUrl");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    print(token);

    if (response.statusCode == 200) {
      final List<dynamic> todoJson = jsonDecode(response.body)['todos'];
      return todoJson.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch todos');
    }
  }
  Future<void> logout(BuildContext context) async {
    // Send a logout request to the server
    final token = await AppHelper.getToken();
    final response = await http.post(
      Uri.parse('${AppHelper.baseUrl}/logout'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Clear the stored token and navigate to login
      await AppHelper.storeToken('');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LogIn()),
      );
    } else {
      // Handle error
      //print('Logout failed: ${response.body}');
    }
  }
  Future<List<Todo>> getMyTodos() async {
    final token = await AppHelper.getToken();
    Uri url = Uri.parse("${_baseUrl}mytodos"); // Ensure this matches your API endpoint

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> todoJson = jsonDecode(response.body)['todos'];
      return todoJson.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch user todos: ${response.body}');
    }
  }

  Future<void> addTodo(String title) async {
    final token = await AppHelper.getToken();
    //print(token);
    Uri url = Uri.parse("${_baseUrl}add");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"title": title}),
    );

    if (response.statusCode != 201) {
      //print(response.statusCode);
      throw Exception('Failed to add todo');
    }
  }

  Future<void> deleteTodo(int id) async {
    final token = await AppHelper.getToken();
    Uri url = Uri.parse("${_baseUrl}delete/$id"); // Ensure id is appended correctly

    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error deleting todo: ${response.body}'); // Log response body for debugging
    }
  }

  Future<void> toggleCompletion(int id, bool completed) async {
    final token = await AppHelper.getToken();
    Uri url = Uri.parse("${_baseUrl}edit");

    final response = await http.patch(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"completed": completed}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error toggling completion');
    }
  }
}