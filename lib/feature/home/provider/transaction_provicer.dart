import 'package:flutter/material.dart';
import 'package:sims_popb/data/network/api_response.dart';
import 'package:sims_popb/data/network/model/transaction/records.dart';
import 'package:sims_popb/data/network/model/transaction/transaction_history_response.dart';
import 'package:sims_popb/main.dart';

class TransactionProvider with ChangeNotifier {
  ApiResponse<TransactionHistoryResponse> transactionHistoryResponse =
  ApiResponse.initial(null);

  List<Records> _allTransactions = [];
  int _currentOffset = 0;
  int _limit = 5;
  bool _hasMore = true;

  List<Records> get allTransactions => _allTransactions;
  bool get hasMore => _hasMore;

  Future<void> getTransactionHistory({int offset = 0, int limit = 5}) async {
    transactionHistoryResponse = ApiResponse.loading();
    notifyListeners();

    await apiService.getTransactionHistory(
        offset,
        limit
    ).then((response){
      if(response.status == 0){
        _allTransactions = response.data!.records;
        _currentOffset = (int.parse(response.data!.offset) + (response.data?.records.length ?? 0));
        _limit = int.parse(response.data?.limit ?? '');
        _hasMore = response.data!.records.length == _limit;

        transactionHistoryResponse = ApiResponse.completed(response);
      }else{
        transactionHistoryResponse = ApiResponse.error(response.message);
      }
    });

    notifyListeners();
  }

  Future<void> getMoreTransactionHistory() async {
    if (!_hasMore) return;
    notifyListeners();

    await apiService.getTransactionHistory(
        _currentOffset,
        _limit
    ).then((response){
      if(response.status == 0){
        _allTransactions.addAll(response.data!.records);
        _currentOffset = (int.parse(response.data!.offset) + (response.data?.records.length ?? 0));
        _limit = int.parse(response.data?.limit ?? '');
        _hasMore = response.data!.records.length == _limit;

        transactionHistoryResponse = ApiResponse.completed(response);
      }else{
        transactionHistoryResponse = ApiResponse.error(response.message);
      }
    });

    notifyListeners();
  }
}
