import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'workshop_screen.dart';
import 'orders_screen.dart';
import 'shop_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(Locale) onChangeLocale;
  final Function(String) onChangeCurrency;
  final String currency;
  const HomeScreen({super.key, required this.onChangeLocale, required this.onChangeCurrency, required this.currency});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      WorkshopScreen(currency: widget.currency),
      const OrdersScreen(),
      const ShopScreen(),
      SettingsScreen(onChangeLocale: widget.onChangeLocale, onChangeCurrency: widget.onChangeCurrency, currentCurrency: widget.currency),
    ];
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      body: tabs[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.factory), label: l.workshop),
          NavigationDestination(icon: const Icon(Icons.receipt_long), label: l.orders),
          NavigationDestination(icon: const Icon(Icons.store), label: l.shop),
          NavigationDestination(icon: const Icon(Icons.settings), label: l.settings),
        ],
      ),
    );
  }
}
