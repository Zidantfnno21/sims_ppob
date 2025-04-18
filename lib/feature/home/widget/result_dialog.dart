import 'package:flutter/material.dart';

class ResultDialog extends StatelessWidget {
  final int topUpAmount;
  final bool isSuccess;
  final String? serviceType;

  const ResultDialog({
    super.key,
    required this.topUpAmount,
    required this.isSuccess,
    this.serviceType,
  });

  String formatCurrency(int value) {
    return 'Rp${value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.cancel,
            color: isSuccess ? Colors.green : Colors.red,
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            serviceType != null ? 'Pembayaran $serviceType sebesar' : 'Top Up sebesar',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            formatCurrency(topUpAmount),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            isSuccess ? 'berhasil!' : 'gagal',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text(
              'Kembali ke Beranda',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
