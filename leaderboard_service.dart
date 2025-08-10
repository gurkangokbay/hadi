// Firebase-ready leaderboard service (stub)
import 'dart:async';
// Uncomment when packages added:
// import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardService {
  static Future<void> submit({required int score}) async {
    // After adding firebase_core & cloud_firestore and initializing Firebase:
    // await FirebaseFirestore.instance.collection('leaderboard').add({
    //   'player': 'guest',
    //   'score': score,
    //   'ts': DateTime.now().millisecondsSinceEpoch,
    // });
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return;
  }
}
