
# Chat App

Real-time global chat built with Flutter and Firebase (Auth + Cloud Firestore).

## Features
- Email/password authentication (sign up, sign in, password reset)
- Email verification flow
- Real-time messages via Firestore
- Messages ordered by timestamp (oldest → newest)
## Badges

![Flutter](https://img.shields.io/badge/flutter-%5E3.8-blue)
![Firebase](https://img.shields.io/badge/firebase-Firestore%20%2B%20Auth-orange)

---

## Quick overview

This repository contains a lightweight chat app built with Flutter and Firebase. It demonstrates
user registration, email verification, real-time chat via Cloud Firestore, and a simple
view-model layer wired to Firestore streams.

## Table of contents
- Prerequisites
- Firebase configuration
- Run & build (PowerShell)
- How messages are stored & ordered
- Firestore rules (example)
- Troubleshooting
- Contributing
- License

## Prerequisites
- Flutter SDK (see `flutter --version`), Android SDK (for Android builds) and Xcode for iOS.
- A Firebase project with Authentication and Cloud Firestore enabled.

Run a quick check in PowerShell:

```powershell
flutter --version
flutter doctor -v
```

## Firebase configuration

1. Create a Firebase project at https://console.firebase.google.com/
2. Add Android and/or iOS app(s) to the project.
3. Enable Authentication → Email/Password.
4. Enable Cloud Firestore (start in native mode).
5. Download and add the platform configuration files:
	 - Android: place `google-services.json` in `android/app/`
	 - iOS: place `GoogleService-Info.plist` in `ios/Runner/`

Note: This repo already contains an Android `google-services.json` under `android/app/` — replace it with your own when connecting to your Firebase project.

## Run & build (Windows PowerShell)

Install dependencies and run on a connected device or emulator:

```powershell
cd path\to\Chat_App
flutter pub get
flutter run
```

Build an Android APK:

```powershell
flutter build apk --release
# output: build\app\outputs\flutter-apk\app-release.apk
```

To run a specific emulator or device, use `flutter devices` and `flutter run -d <deviceId>`.

## How messages are stored and ordered

Each chat message is stored in the `chats` collection. Example document structure:

```json
{
	"id": "<docId>",
	"message": "Hello world",
	"senderId": "uid_123",
	"senderName": "Alice",
	"timestamp": { "_seconds": 1620000000, "_nanoseconds": 0 }
}
```

Important implementation notes from this repository:
- `lib/models/chat_model.dart` converts Firestore `Timestamp` to `DateTime`.
- `lib/services/chat_service.dart` currently uses:

```dart
FirebaseFirestore.instance
	.collection('chats')
	.orderBy('timestamp') // oldest → newest
	.snapshots();
```

If you prefer newest messages first (common for chat UIs that show latest at top), change the query:

```dart
.orderBy('timestamp', descending: true)
```

Alternatively, keep the query ascending and reverse the `ListView` in the UI by setting `reverse: true` on `ListView`.

## Firestore security rules (example)

Use these example rules as a starting point. Review and harden rules before production.

```javascript
rules_version = '2';
service cloud.firestore {
	match /databases/{database}/documents {
		match /chats/{chatId} {
			allow read: if request.auth != null;
			allow create: if request.auth != null
				&& request.resource.data.keys().hasAll(['message','senderId','senderName','timestamp'])
				&& request.resource.data.timestamp is timestamp;
			allow update, delete: if false;
		}
	}
}
```

## Troubleshooting

- Firestore permission errors: ensure rules allow the operation for authenticated users and you're signed in.
- Missing `timestamp` on messages: messages must include a Firestore `Timestamp` (see `ChatModel.toJson`).
- Email verification not working: check that email sending is enabled in Firebase and that the user's `emailVerified` flag is being checked correctly.

## Contributing

Contributions are welcome. Suggested steps:

1. Fork the repo and create a feature branch.
2. Run the app and add tests for new behavior.
3. Open a PR with a clear description of changes.

Small, safe improvements to consider:
- Add unit tests for `ChatModel` JSON serialization.
- Add UI tests that verify message ordering.

## Author / Maintainer

Yassin Bassam — https://github.com/Yassinbassam11

## License

This project is released under the MIT License.

---

If you want, I can also:
- Add a short CONTRIBUTING.md and a CODE_OF_CONDUCT.md.
- Add a small unit test for `ChatModel` serialization and run it.

