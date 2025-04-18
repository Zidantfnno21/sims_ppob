import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sims_popb/data/network/api_response.dart';
import 'package:sims_popb/data/network/model/transaction/transaction_response.dart';
import 'package:sims_popb/main.dart';


class PaymentProvider with ChangeNotifier {
  ApiResponse<TransactionResponse> transactionResponse =
      ApiResponse.initial(null);
  bool hasHandledTransactionResponse = false;

  Future<void> transaction(String serviceCode, int topUpAmount) async {
    hasHandledTransactionResponse = false;
    transactionResponse = ApiResponse.loading();
    notifyListeners();

    try {
      final response = await apiService.transaction(serviceCode, topUpAmount);
      if (response.status == 0) {
        transactionResponse = ApiResponse.completed(response);
      } else {
        transactionResponse = ApiResponse.error(response.message);
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Terjadi kesalahan';
      transactionResponse = ApiResponse.error(errorMessage);
    } catch (e) {
      transactionResponse = ApiResponse.error('Gagal melakukan transaksi');
    }

    notifyListeners();
  }

  void markTopUpResponseHandled() {
    hasHandledTransactionResponse = true;
    notifyListeners();
  }
}
