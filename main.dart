import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'l10n/app_localizations.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase initialize here after adding firebase_core:
  // await Firebase.initializeApp();
  runApp(const BoFApp());
}

class BoFApp extends StatefulWidget {
  const BoFApp({super.key});

  @override
  State<BoFApp> createState() => _BoFAppState();
}

class _BoFAppState extends State<BoFApp> {
  Locale _locale = const Locale('tr');
  String _currency = 'USD'; // or 'EUR'

  void _setLocale(Locale l) => setState(() => _locale = l);
  void _setCurrency(String c) => setState(() => _currency = c);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boss of Factory',
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('tr')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: HomeScreen(
        onChangeLocale: _setLocale,
        onChangeCurrency: _setCurrency,
        currency: _currency,
      ),
    );
  }
}

// Simple currency formatter helper
String formatMoney(num value, String currency) {
  final symbol = currency == 'EUR' ? '€' : '\$';
  final fmt = NumberFormat.currency(symbol: symbol, decimalDigits: 0);
  return fmt.format(value);
}
