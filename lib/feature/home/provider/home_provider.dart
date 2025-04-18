import 'package:flutter/material.dart';
import 'package:sims_popb/data/network/api_response.dart';
import 'package:sims_popb/data/network/model/balance/balance_response.dart';
import 'package:sims_popb/data/network/model/banner/banner_response.dart';
import 'package:sims_popb/data/network/model/services/service_response.dart';
import 'package:sims_popb/main.dart';

class HomeProvider with ChangeNotifier {
  ApiResponse<ServiceResponse> serviceResponse = ApiResponse.initial(null);
  ApiResponse<BannerResponse> bannerResponse = ApiResponse.initial(null);
  ApiResponse<BalanceResponse> balanceResponse = ApiResponse.initial(null);

  Future<void> getBanner() async {
    bannerResponse = ApiResponse.loading();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    await apiService.getBanner().then((response) {
      if(response.status == 0) {
        bannerResponse = ApiResponse.completed(response);
      }else{
        bannerResponse = ApiResponse.error(response.message);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });  }

  Future<void> getService() async {
    serviceResponse = ApiResponse.loading();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    await apiService.getServices().then((response) {
      if(response.status == 0) {
        serviceResponse = ApiResponse.completed(response);
      }else{
        serviceResponse = ApiResponse.error(response.message);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> getBalance() async{
    balanceResponse = ApiResponse.loading();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    await  apiService.getBalance().then((response) {
      if(response.status == 0) {
        balanceResponse = ApiResponse.completed(response);
      }else{
        balanceResponse = ApiResponse.error(response.message);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

}