import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sims_popb/data/session_provider.dart';
import 'package:sims_popb/main.dart';

import '../../../../data/network/api_response.dart';
import '../../../../data/network/model/login/login_response.dart';

class LoginProvider with ChangeNotifier {
  LoginProvider({required SessionProvider sessionProvider})
      : _sessionProvider = sessionProvider;

  final SessionProvider _sessionProvider;

  ApiResponse<LoginResponse> loginResponse = ApiResponse.initial(null);

  Future<void> login(
    String email,
    String password,
  ) async {
    loginResponse = ApiResponse.loading();
    notifyListeners();

    try {
      final response = await apiService.login(email, password);

      if (response.status == 0) {
        final token = response.data?.token;
        if (token != null) {
          await _sessionProvider.login(token);
        }

        loginResponse = ApiResponse.completed(response);
      } else {
        loginResponse = ApiResponse.error(response.message);
      }
    } catch (e) {
      debugPrint("Register error: $e");
      if (e is DioException) {
        try {
          final msg = e.response?.data['message'];
          loginResponse = ApiResponse.error(msg);
        } catch (_) {
          loginResponse = ApiResponse.error("Terjadi kesalahan!");
        }
      }
    } finally {
      notifyListeners();
    }
  }
}
