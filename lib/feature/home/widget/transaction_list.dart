import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_popb/feature/home/provider/transaction_provicer.dart';
import 'package:sims_popb/feature/home/widget/transaction_item_card.dart';
import 'package:sims_popb/feature/home/widget/transaction_item_shimmer.dart';

import '../../../data/network/status.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  void initState() {
    super.initState();
    fetchTransactionHistory();
  }

  void fetchTransactionHistory() {
    context.read<TransactionProvider>().getTransactionHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, value, _) {
        final status = value.transactionHistoryResponse.status;
        final transactionHistory = value.allTransactions;

        switch (status) {
          case Status.loading:
            return ListView.separated(
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.all(0),
              itemCount: 2,
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                return TransactionItemShimmer();
              },
            );
          case Status.completed:
            if (transactionHistory.isEmpty) {
              return SizedBox(
                height: double.infinity,
                child: Center(
                    child: Text(
                  "Maaf tidak ada histori transaksi saat ini",
                  style: TextStyle(color: Colors.grey.shade500),
                )),
              );
            }

            return ListView.separated(
              physics: ClampingScrollPhysics(),
              itemCount: transactionHistory.length + 1,
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                if (index < transactionHistory.length) {
                  return TransactionItemCard(
                    records: transactionHistory[index],
                  );
                } else {
                  if (!value.hasMore) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xFFFFF5F3),
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 4,),
                          Center(
                              child: Text(
                                  'Tidak ada data lagi untuk ditampilkan.',
                                  style:
                                      const TextStyle(color: Colors.black54))),
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          value.getMoreTransactionHistory();
                        },
                        child: Text("View More",
                            style: const TextStyle(color: Color(0xFFFF4D4F))),
                      ),
                    ),
                  );
                }
              },
            );

          case Status.error:
            return const Center(child: Text("Failed to load transactions."));

          default:
            return const SizedBox();
        }
      },
    );
  }
}
