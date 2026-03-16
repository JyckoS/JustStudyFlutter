import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StudyService {
    final String baseUrl = "https://juststudy-production.up.railway.app";
    Future<Map<String, dynamic> > getUserData() async {
      String token = await getToken();
      final response = await http.get(Uri.parse("$baseUrl/study/user"),
       headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'});
       if (response.statusCode == 200) {
      return jsonDecode(response.body);

       }
       throw Exception("Failed to get user data");
    }
    Future< Map<String, dynamic> > getTotalStudyMinutes() async {
      String token = await getToken();
      final response = await http.get(Uri.parse("$baseUrl/study/total"),
      headers: {'Content-Type':'application/json', 'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw Exception("Failed to get total minutes");
    }
    Future< Map<String, dynamic> > getTopToday() async {
      String token = await getToken();
      final response = await http.get(Uri.parse("$baseUrl/study/top-today"),
      headers: {'Content-Type':'application/json', 'Authorization':'Bearer $token'});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw Exception("Failed to get top today");
    }
    Future<bool> addStudySession(int minutes) async {
      String token = await getToken();
      final response = await http.post(Uri.parse("$baseUrl/study/add"),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: jsonEncode({
        'minutes': minutes
      }));
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return true;
      } else {
        return false;
      }
    }

    Future<String> getToken() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString("token")!;
    }
}