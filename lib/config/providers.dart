import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sims_popb/feature/home/provider/account_provider.dart';
import 'package:sims_popb/feature/home/provider/home_provider.dart';
import 'package:sims_popb/feature/home/provider/top_up_provider.dart';
import 'package:sims_popb/feature/home/provider/transaction_provicer.dart';
import 'package:sims_popb/feature/payment/provider/payment_provider.dart';

import '../data/session_provider.dart';
import '../feature/auth/login/provider/login_provider.dart';
import '../feature/auth/register/provider/register_provider.dart';

List<SingleChildWidget> get appProviders {
  return [
    ChangeNotifierProvider(create: (_) => SessionProvider()),
    ChangeNotifierProvider(create: (_) => RegisterProvider()),
    ChangeNotifierProvider(
      create: (context) =>
          LoginProvider(sessionProvider: context.read<SessionProvider>()),
    ),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => AccountProvider()),
    ChangeNotifierProvider(create: (_) => TopUpProvider()),
    ChangeNotifierProvider(create: (_) => TransactionProvider()),
    ChangeNotifierProvider(create: (_) => PaymentProvider()),
  ];
}
