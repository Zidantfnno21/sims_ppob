import 'package:flutter/material.dart';

import '../../../utils/resources/assets.dart';

class Confirmation extends StatelessWidget {
  final int topUpAmount;
  final String? serviceType;

  const Confirmation({super.key, required this.topUpAmount, this.serviceType});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Assets.instance.logoIcon,
            height: 42,
          ),
          const SizedBox(height: 12),
          Text(
            serviceType != null
                ? 'Beli $serviceType senilai'
                : 'Anda yakin untuk Top Up sebesar',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            'Rp${topUpAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} ?',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text(
              'Ya, lanjutkan Top Up',
              style: TextStyle(
                  height: 1,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text(
              'Batalkan',
              style: TextStyle(height: 1, color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
