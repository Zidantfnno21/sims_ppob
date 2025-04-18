import 'package:flutter/material.dart';
import 'package:sims_popb/data/network/api_response.dart';
import 'package:sims_popb/data/network/model/balance/balance_response.dart';
import 'package:sims_popb/main.dart';

class TopUpProvider with ChangeNotifier {
  ApiResponse<BalanceResponse> balanceResponse = ApiResponse.initial(null);
  bool hasHandledTopUpResponse = false;

  Future<void> topUpBalance(int topUpAmount) async {
    hasHandledTopUpResponse = false;
    balanceResponse = ApiResponse.loading();
    notifyListeners();

    await apiService.topUp(topUpAmount).then((response) {
      if (response.status == 0) {
        balanceResponse = ApiResponse.completed(response);
      } else {
        balanceResponse = ApiResponse.error(response.message);
      }
    });

    notifyListeners();
  }

  void markTopUpResponseHandled() {
    hasHandledTopUpResponse = true;
    notifyListeners();
  }

}
