import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  final Function(Locale) onChangeLocale;
  final Function(String) onChangeCurrency;
  final String currentCurrency;

  const SettingsScreen({super.key, required this.onChangeLocale, required this.onChangeCurrency, required this.currentCurrency});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.settings)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.language, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: [
              ElevatedButton(onPressed: () => onChangeLocale(const Locale('tr')), child: Text(l.turkish)),
              ElevatedButton(onPressed: () => onChangeLocale(const Locale('en')), child: Text(l.english)),
            ]),
            const SizedBox(height: 16),
            Text(l.currency, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: [
              ElevatedButton(onPressed: () => onChangeCurrency('USD'), child: Text(l.usd)),
              ElevatedButton(onPressed: () => onChangeCurrency('EUR'), child: Text(l.eur)),
            ]),
            const SizedBox(height: 16),
            Text('Current: $currentCurrency'),
          ],
        ),
      ),
    );
  }
}
