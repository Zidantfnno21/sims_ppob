import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/session_provider.dart';
import '../utils/resources/assets.dart';
import 'auth/login/login_screen.dart';
import 'home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionProvider>(
      builder: (context, session, _) {
        if (!session.isInitialized) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.instance.logoIcon,
                      height: 160,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'SIMS POPB',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('MUHAMMAD ZIDAN TIFANNO NURFIDAUSYI'),
                    SizedBox(height: 8,),
                    CircularProgressIndicator(),
                  ],
                ),
              ));
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (session.isLoggedIn && context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else {
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            }
          });
        });

        return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.instance.logoIcon,
                    height: 160,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'SIMS POPB',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text('MUHAMMAD ZIDAN TIFANNO NURFIDAUSYI')
                ],
              ),
            ));
      },
    );
  }
}
