import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sims_popb/data/network/model/transaction/records.dart';
import 'package:sims_popb/utils/resources/strings.dart';

class TransactionItemCard extends StatelessWidget {
  final Records? records;

  const TransactionItemCard({
    super.key,
    this.records,
  });

  @override
  Widget build(BuildContext context) {
    final isTopUp = records!.transactionType == Strings.topUpTransactionType;
    final formattedAmount = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(records!.totalAmount);

    final amountText = isTopUp ? '+$formattedAmount' : '-$formattedAmount';
    final amountColor = isTopUp ? Colors.green : Colors.red;
    final wibTime = DateTime.parse(records!.createdAt)
        .toUtc()
        .add(const Duration(hours: 7));

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: Colors.grey, width: 0.5)),
      child: ListTile(
        title: Text(
          amountText,
          style: TextStyle(color: amountColor, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${DateFormat('dd MMM yyyy, HH:mm', 'id_ID').format(wibTime)} WIB',
        ),
        trailing: Text(
          records?.description ?? '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
