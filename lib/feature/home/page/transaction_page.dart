import 'package:flutter/material.dart';
import 'package:sims_popb/feature/home/widget/transaction_list.dart';

import '../widget/saldo_card.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Transaksi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SaldoCard(),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 24.0, vertical: 12.0),
              child: const Text(
                'Transaksi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0),
                  child: TransactionList()),
            ),
          ],
        ),
      ),
    );
  }
}
