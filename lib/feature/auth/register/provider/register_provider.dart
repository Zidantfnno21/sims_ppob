import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sims_popb/main.dart';
import '../../../../data/network/api_response.dart';
import '../../../../data/network/model/register/registration_response.dart';

class RegisterProvider with ChangeNotifier{
  ApiResponse<RegistrationResponse> registrationResponse = ApiResponse.initial(null);

  Future<void> register(
    String email,
    String firstName,
    String lastName,
    String password,
  ) async {
    registrationResponse = ApiResponse.loading();
    notifyListeners();
    try {
      RegistrationResponse response = await apiService.registration(
        email,
        firstName,
        lastName,
        password,
      );

      registrationResponse = ApiResponse.completed(response);
    } catch (e) {
      debugPrint("Register error: $e");
      if (e is DioException) {
        try {
          final msg = e.response?.data['message'];
          registrationResponse = ApiResponse.error(msg);
        } catch (_) {
          registrationResponse = ApiResponse.error("Terjadi kesalahan!");
        }
      }
    }
    notifyListeners();
  }
}