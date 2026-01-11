import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../env/env.dart';

class ApiService {
  static const storage = FlutterSecureStorage();
  static final String baseUrl = Env.BACKEND_URL;

  static Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }

  static Future<void> saveToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: 'auth_token');
  }

  static Map<String, String> getHeaders({String? token}) {
    final headers = {
      'accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  static String parseErrorMessage(String errorMessage) {
    if (errorMessage.contains('Failed host lookup')) {
      return "Connection is down currently";
    } else if (errorMessage.contains('DOCTYPE HTML') ||
               errorMessage.contains('oken') ||
               errorMessage.contains('Connection reset by peer')) {
      return "Something went wrong";
    }
    return errorMessage;
  }
}
