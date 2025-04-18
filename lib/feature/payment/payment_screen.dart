import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sims_popb/data/network/model/services/service.dart';
import 'package:sims_popb/feature/home/widget/saldo_card.dart';
import 'package:sims_popb/feature/payment/provider/payment_provider.dart';

import '../../data/network/status.dart';
import '../../utils/widgets/idr_text_formatter.dart';
import '../home/provider/home_provider.dart';
import '../home/widget/async_action_button.dart';
import '../home/widget/confirmation_dialog.dart';
import '../home/widget/result_dialog.dart';

class PaymentScreen extends StatefulWidget {
  final Service service;
  const PaymentScreen({super.key, required this.service});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _nominalController = TextEditingController();

  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }

  final Map<String, int> serviceAmountMap = {
    'Pajak PBB': 40000,
    'Listrik': 10000,
    'PDAM Berlangganan': 40000,
    'Pulsa': 40000,
    'PGN Berlangganan': 50000,
    'Musik Berlangganan': 50000,
    'TV Berlangganan': 50000,
    'Paket Data': 50000,
    'Voucher Game': 100000,
    'Voucher Makanan': 100000,
    'Qurban': 200000,
    'Zakat': 300000,
  };

  void _showConfirmationDialog(BuildContext context, int topUpAmount,
      [String? serviceCode]) async {
    final result = await showDialog(
      context: context,
      builder: (_) => Confirmation(
        topUpAmount: topUpAmount,
        serviceType: serviceCode,
      ),
    );

    if (result == true) {
      _transaction(widget.service.serviceCode, topUpAmount);
    }
  }

  void _showResultDialog(
      BuildContext context, int topUpAmount, bool isSuccess) async {
    final result = await showDialog(
      context: context,
      builder: (_) => ResultDialog(
        topUpAmount: topUpAmount,
        isSuccess: isSuccess,
        serviceType: widget.service.serviceName,
      ),
    );

    if (result == true && context.mounted) {
      context.read<HomeProvider>().getBalance();
      Navigator.of(context).pop();
    }
  }

  Future<void> _transaction(String serviceCode, int topUpAmount) async {
    context.read<PaymentProvider>().transaction(serviceCode, topUpAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 48,
          ),
          child: IntrinsicHeight(
            child: Consumer<PaymentProvider>(builder: (context, value, _) {
              final int? nominal = serviceAmountMap[widget.service.serviceName];
              if (nominal != null) {
                _nominalController.text = RupiahInputFormatter.format(nominal);
              }

              final status = value.transactionResponse.status;
              if ((status == Status.completed || status == Status.error) &&
                  !value.hasHandledTransactionResponse) {
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
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.arrow_back_rounded, size: 16),
                              SizedBox(width: 4),
                              Text(
                                'Kembali',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Center(
                          child: Text(
                            'PemBayaran',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
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
                      'PemBayaran',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Row(
                      children: [
                        Image.network(
                          widget.service.serviceIcon,
                          height: 24,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.service.serviceName,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 24),
                    child: TextFormField(
                      readOnly: true,
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
                          hintText: 'masukkan nominal PemBayaran',
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
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          focusColor: Colors.black),
                    ),
                  ),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: AsyncActionButton(
                          status: value.transactionResponse.status,
                          text: 'Bayar',
                          onPressed: () {
                            final cleanedText = _nominalController.text
                                .replaceAll(RegExp(r'[^0-9]'), '');

                            final intValue = int.tryParse(cleanedText) ?? 0;
                            _showConfirmationDialog(
                                context, intValue, widget.service.serviceName);
                          })),
                ],
              );
            }),
          ),
        ),
      )),
    );
  }
}
