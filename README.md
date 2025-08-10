# Boss of Factory (Flutter Prototype)

Industrial entrepreneurship sim — **Boss of Factory**.
This prototype includes:
- TR/EN localization
- USD/EUR currency display
- Production loop (materials -> produce -> sell)
- Shop & Orders scaffolding
- Firebase-ready leaderboard stubs (no secrets included)

## Requirements
- Flutter SDK (stable)
- Android SDK / Xcode (as applicable)

## Run
```bash
flutter pub get
flutter run
```

## Build APK
```bash
flutter build apk --debug
# or for release:
# flutter build apk --release
```

## Localization
Strings live in `lib/l10n/*.arb`. After edits, run:
```bash
flutter gen-l10n
```

## Firebase Leaderboard (optional)
1. Create a Firebase project and enable Firestore.
2. Add Android app; download `google-services.json` to `android/app/`.
3. (iOS) Add app; download `GoogleService-Info.plist` to `ios/Runner/`.
4. Uncomment Firestore code in `lib/services/leaderboard_service.dart` and add packages in `pubspec.yaml`:
   ```yaml
   dependencies:
     firebase_core: ^3.3.0
     cloud_firestore: ^5.4.4
   ```
5. Initialize Firebase in `main.dart` as indicated.
6. Create `leaderboard` collection (fields: player, score, ts).

## Notes
- This is a minimal, clean starting point. Extend screens in `lib/screens/*`.
- All images are placeholders; replace with your art in `assets/images/`.
