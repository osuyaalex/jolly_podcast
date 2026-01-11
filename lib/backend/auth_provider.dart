import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import 'models/login_model.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<LoginModel?> login(String phoneNo, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final loginResponse = await AuthService.login(phoneNo, password);
      _isLoading = false;
      notifyListeners();
      return loginResponse;
    } catch (error) {
      _isLoading = false;
      _error = error.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<String?> getToken() async {
    return await AuthService.getToken();
  }

  Future<void> logout() async {
    await AuthService.logout();
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
