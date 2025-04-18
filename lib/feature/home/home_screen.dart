import 'package:flutter/material.dart';
import 'package:sims_popb/feature/home/page/account_page.dart';
import 'package:sims_popb/feature/home/page/home_page.dart';
import 'package:sims_popb/feature/home/page/top_up_page.dart';
import 'package:sims_popb/feature/home/page/transaction_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    TopUpPage(),
    TransactionPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        elevation: 0,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon:
            Icon(
                _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
              color: _selectedIndex == 0 ? Colors.black : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 1 ? Icons.money : Icons.money_outlined,
              color: _selectedIndex == 1 ? Colors.black : Colors.grey,
            ),
            label: 'Top Up',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2 ? Icons.credit_card : Icons.credit_card_outlined,
              color: _selectedIndex == 2 ? Colors.black : Colors.grey,
            ),
            label: 'Transaction',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 3 ? Icons.person : Icons.person_outline,
              color: _selectedIndex == 3 ? Colors.black : Colors.grey,
            ),
            label: 'Akun',
          ),
        ],
        selectedItemColor: Colors.black,
      ),
    );
  }
}
