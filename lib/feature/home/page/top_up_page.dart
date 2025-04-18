import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sims_popb/data/network/status.dart';
import 'package:sims_popb/feature/home/provider/top_up_provider.dart';
import 'package:sims_popb/feature/home/widget/result_dialog.dart';
import 'package:sims_popb/utils/widgets/idr_text_formatter.dart';

import '../provider/home_provider.dart';
import '../widget/confirmation_dialog.dart';
import '../widget/saldo_card.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  final TextEditingController _nominalController = TextEditingController();
  String? _errorText;
  bool isDisabled = true;

  static const int _minTopUp = 10000;
  static const int _maxTopUp = 1000000;

  @override
  void initState() {
    super.initState();
    _nominalController.addListener(_validateInput);
  }

  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }

  void _validateInput() {
    String numericString =
        _nominalController.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericString.isEmpty) {
      setState(() {
        _errorText = null;
        isDisabled = true;
      });
      return;
    }

    int value = int.tryParse(numericString) ?? 0;

    if (value < _minTopUp) {
      setState(() {
        _errorText = 'Minimal Top Up Rp10.000';
        isDisabled = true;
      });
    } else if (value > _maxTopUp) {
      setState(() {
        _errorText = 'Maksimal Top Up Rp1.000.000';
        isDisabled = true;
      });
    } else {
      setState(() {
        _errorText = null;
        isDisabled = false;
      });
    }
  }

  void _showConfirmationDialog(BuildContext context, int topUpAmount) async {
    final result = await showDialog(
      context: context,
      builder: (_) => Confirmation(topUpAmount: topUpAmount),
    );

    if (result == true) {
      _topUp(topUpAmount);
    }
  }

  void _showResultDialog(
      BuildContext context, int topUpAmount, bool isSuccess) async {
    final result = await showDialog(
      context: context,
      builder: (_) => ResultDialog(
        topUpAmount: topUpAmount,
        isSuccess: isSuccess,
      ),
    );

    if (result == true && context.mounted) {
      context.read<HomeProvider>().getBalance();
    }
  }

  void _setNominalToTextInput(String topUpAmount) {
    setState(() {
      _nominalController.text = topUpAmount;
    });
  }

  Future<void> _topUp(int topUpAmount) async {
    context.read<TopUpProvider>().topUpBalance(topUpAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Consumer<TopUpProvider>(builder: (context, value, _) {
          final status = value.balanceResponse.status;

          if ((status == Status.completed || status == Status.error) &&
              !value.hasHandledTopUpResponse) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final isSuccess = status == Status.completed;
              final cleanedText =
                  _nominalController.text.replaceAll(RegExp(r'[^0-9]'), '');

              final intValue = int.tryParse(cleanedText) ?? 0;
              _showResultDialog(context, intValue, isSuccess);
              value.markTopUpResponseHandled();
            });
          }

          return Column(
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
                      'Top Up',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Silahkan masukan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    const Text(
                      'nominal Top up',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  controller: _nominalController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    RupiahInputFormatter()
                  ],
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      prefixIcon: Icon(
                        Icons.money_sharp,
                        color: Colors.grey,
                      ),
                      hintText: 'masukkan nominal Top Up',
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusColor: Colors.black,
                      errorText: _errorText),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 12,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.5,
                  children: [
                    for (final amount in [
                      'Rp 10.000',
                      'Rp 20.000',
                      'Rp 50.000',
                      'Rp 100.000',
                      'Rp 250.000',
                      'Rp 500.000'
                    ])
                      OutlinedButton(
                        onPressed: () {
                          _setNominalToTextInput(amount);
                        },
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: BorderSide(color: Colors.grey)),
                        child: Center(
                          child: Text(
                            amount,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                  height: 48,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ElevatedButton(
                    onPressed: isDisabled
                        ? null
                        : () {
                            final cleanedText = _nominalController.text
                                .replaceAll(RegExp(r'[^0-9]'), '');

                            final intValue = int.tryParse(cleanedText) ?? 0;
                            _showConfirmationDialog(context, intValue);
                          },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: isDisabled ? Colors.grey : Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Top Up',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              const SizedBox(height: 24),
            ],
          );
        }),
      )),
    );
  }
}
