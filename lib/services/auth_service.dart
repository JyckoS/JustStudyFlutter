import 'dart:convert';

import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../util.dart';

class AuthService {
  final String baseUrl = "https://juststudy-production.up.railway.app";

  Future< Map<String, dynamic> > login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"), 
    headers: {'Content-Type': 'application/json'}, 
    body: jsonEncode({'email': email, 'password': password}));
    return jsonDecode(response.body);
  }

  Future< Map<String, dynamic> > register(String display, String email, String password) async {
    final response;
    try {
    response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password, 'display': display}));
    } catch (e) {
      e.printError();
      return Map();
    }
    return jsonDecode(response.body);

  }

  Future< bool > checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    // if no token exists
    if (token == null || token.isEmpty) return false;

    // if token is valid
    final response = await http.get(
      Uri.parse("$baseUrl/auth/validate-token"), 
      headers: {'Authorization' : 'Bearer $token'});
    if (response.statusCode == 200) {
      return true;
    }
    // if invalid
    await prefs.remove('token');
    return false;
  }
}