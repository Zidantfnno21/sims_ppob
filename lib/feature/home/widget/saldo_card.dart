import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sims_popb/feature/home/provider/home_provider.dart';

import '../../../data/network/status.dart';
import '../../../utils/resources/assets.dart';

class SaldoCard extends StatefulWidget {
  const SaldoCard({super.key});

  @override
  State<SaldoCard> createState() => _SaldoCardState();
}

class _SaldoCardState extends State<SaldoCard> {
  bool _showBalance = false;

  @override
  void initState() {
    super.initState();
    fetchSaldo();
    _loadShowBalance();
  }

  Future<void> _loadShowBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final savedValue = prefs.getBool('show_balance') ?? false;

    setState(() {
      _showBalance = savedValue;
    });
  }

  void fetchSaldo() {
    context.read<HomeProvider>().getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          final status = provider.balanceResponse.status;

          switch (status) {
            case Status.loading:
              return Container(
                width: double.infinity,
                height: 112,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 140,
                        height: 20,
                        color: Colors.white,
                      ),

                      const SizedBox(height: 12),
                      Container(
                        width: 80,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              );

            case Status.completed:
              final balance = provider.balanceResponse.data?.data?.balance ?? 0;

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.instance.backgroundSaldo),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Saldo anda',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Rp',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _showBalance
                              ? formatCurrency(balance)
                              : '●●●●●●●●',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        setState(() {
                          _showBalance = !_showBalance;
                        });
                        prefs.setBool('show_balance', _showBalance);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _showBalance ? 'Sembunyikan Saldo' : 'Lihat Saldo',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            _showBalance
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                            size: 12,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );

            case Status.error:
              return Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Gagal memuat saldo',
                  style: TextStyle(color: Colors.white),
                ),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
    );
  }
}
