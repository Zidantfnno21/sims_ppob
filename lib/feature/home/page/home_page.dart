import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_popb/feature/home/provider/home_provider.dart';
import 'package:sims_popb/feature/home/widget/greetings_text.dart';

import '../../../utils/resources/assets.dart';
import '../widget/home_menu.dart';
import '../widget/promo_horizontal_section.dart';
import '../widget/saldo_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Consumer<HomeProvider>(
              builder: (context, value, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                Assets.instance.logoIcon,
                                height: 24,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'SIMS PPOB',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset(
                                Assets.instance.profilePhoto1,
                             height: 30,
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                    ),
                    Greetings(),
                    SaldoCard(),
                    HomeMenu(),
                    PromoHorizontalSection(),
                  ],
                );
              }
            ),
          )
      ),
    );
  }
}
