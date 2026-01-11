import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import '../backend/models/login_model.dart';

class AuthService {
  static Future<LoginModel?> login(String phoneNo, String password) async {
    try {
      String url = "${ApiService.baseUrl}/api/auth/login";

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(ApiService.getHeaders());
      request.fields['phone_number'] = phoneNo;
      request.fields['password'] = password;

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        final loginResponse = LoginModel.fromJson(jsonResponse);

        // Save token securely
        if (loginResponse.data?.token != null) {
          await ApiService.saveToken(loginResponse.data!.token!);
          await ApiService.storage.write(key: 'phone_number', value: phoneNo);
        }

        return loginResponse;
      } else if (response.statusCode == 400) {
        final jsonResponse = jsonDecode(response.body);
        String errorMessage = jsonResponse['message'] ?? 'Invalid credentials';
        throw errorMessage;
      } else {
        final jsonResponse = jsonDecode(response.body);
        throw jsonResponse['message'] ?? 'Something went wrong';
      }
    } catch (error) {
      throw ApiService.parseErrorMessage(error.toString());
    }
  }

  static Future<String?> getToken() async {
    return await ApiService.getToken();
  }

  static Future<void> logout() async {
    await ApiService.deleteToken();
    await ApiService.storage.delete(key: 'phone_number');
  }
}
