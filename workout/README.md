# Workout Flutter App

A Flutter app with splash screen (5s), Auth & Profile (mock), Workout Programs, Workout Sessions, Nutrition, and daily reminders via local notifications.

## Requirements
- Flutter SDK

## Setup
```bash
flutter pub get
flutter run
```

## Features
- Splash (5s) then route to login/home
- Auth & Profile using SharedPreferences (stub)
- Programs list
- Sessions (today demo)
- Nutrition meals list + total calories
- Daily reminder notifications using flutter_local_notifications & timezone

## Notes
- Android 13+ requires notification permission; the plugin handles runtime prompts when showing/scheduling notifications.
- iOS: permissions are requested on initialization.

## Future Work
- Switch auth to Firebase
- Persist data with Firestore/SQLite
- Add program/session details and progress tracking
