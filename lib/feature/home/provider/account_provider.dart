import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sims_popb/data/network/api_response.dart';
import 'package:sims_popb/data/network/model/profile/profile_response.dart';
import 'package:sims_popb/data/network/service/rest_client_extension.dart';
import 'package:sims_popb/main.dart';

class AccountProvider with ChangeNotifier {
  ApiResponse<ProfileResponse> profileResponse = ApiResponse.initial(null);

  Future<void> getProfile() async {
    profileResponse = ApiResponse.loading();
    notifyListeners();

    await apiService.getProfile().then((response){
      if(response.status == 0) {
        profileResponse = ApiResponse.completed(response);
      }else{
        profileResponse = ApiResponse.error(response.message);
      }
    });

    notifyListeners();
  }

  Future<void> updateProfile(
      String firstName,
      String lastName,
      ) async {
    profileResponse = ApiResponse.loading();
    notifyListeners();

    await apiService.updateProfile(firstName, lastName).then((response){
      if(response.status == 0) {
        profileResponse = ApiResponse.completed(response);
      }else{
        profileResponse = ApiResponse.error(response.message);
      }
    });

    notifyListeners();
  }

  Future<void> updateProfileImage(File file) async {
    profileResponse = ApiResponse.loading();
    notifyListeners();

    try {
      final response = await apiServiceUpload.uploadProfileImage(file);
      if (response.status == 0) {
        profileResponse = ApiResponse.completed(response);
      } else {
        profileResponse = ApiResponse.error(response.message);
      }
    } catch (e) {
      profileResponse = ApiResponse.error(e.toString());
    }

    notifyListeners();
  }
}