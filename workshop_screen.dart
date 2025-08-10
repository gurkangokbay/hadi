import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/leaderboard_service.dart';
import '../main.dart';

class WorkshopScreen extends StatefulWidget {
  final String currency;
  const WorkshopScreen({super.key, required this.currency});

  @override
  State<WorkshopScreen> createState() => _WorkshopScreenState();
}

class _WorkshopScreenState extends State<WorkshopScreen> {
  int balance = 150000; // in base unit (for USD/EUR display only)
  int steel = 20;
  int aluminium = 15;
  int parts = 0;
  bool producing = false;

  Future<void> _startProduction() async {
    if (producing) return;
    if (steel < 2 || aluminium < 1) {
      _msg(AppLocalizations.of(context)!.notEnoughMaterials);
      return;
    }
    setState(() => producing = true);
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      steel -= 2;
      aluminium -= 1;
      parts += 1;
      balance += 500; // reward
      producing = false;
    });
  }

  void _sellParts() {
    if (parts == 0) {
      _msg(AppLocalizations.of(context)!.nothingToSell);
      return;
    }
    setState(() {
      balance += parts * 450;
      parts = 0;
    });
  }

  void _buyMaterials() {
    const steelPrice = 100;
    const aluPrice = 150;
    if (balance < (steelPrice * 5 + aluPrice * 3)) {
      _msg('Low balance');
      return;
    }
    setState(() {
      balance -= (steelPrice * 5 + aluPrice * 3);
      steel += 5;
      aluminium += 3;
    });
  }

  void _submitLeaderboard() async {
    await LeaderboardService.submit(score: balance);
    _msg('Leaderboard OK (stub)');
  }

  void _msg(String t) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t)));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.workshop), actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(child: Text('${l.balance}: ' + formatMoney(balance, widget.currency))),
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(l.machineCncLathe, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Center(
                          child: Icon(Icons.precision_manufacturing, size: 110, color: Colors.blueGrey),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: producing ? null : _startProduction,
                              child: Text(producing ? l.producing : l.produce),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(onPressed: _sellParts, child: Text(l.selling)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(l.inventory, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text('${l.steel}: $steel'),
                          Text('${l.aluminium}: $aluminium'),
                          Text('${l.parts}: $parts'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(l.quickActions, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          ElevatedButton(onPressed: _buyMaterials, child: Text(l.buyMaterials)),
                          const SizedBox(height: 6),
                          ElevatedButton(onPressed: _submitLeaderboard, child: Text(l.sendLeaderboard)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
