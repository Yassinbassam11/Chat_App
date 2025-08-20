

# Chat App

Real-time global chat built with Flutter and Firebase (Auth + Cloud Firestore).

![Flutter](https://img.shields.io/badge/flutter-%5E3.8-blue)
![Firebase](https://img.shields.io/badge/firebase-Firestore%20%2B%20Auth-orange)

---

## ✨ Features

- Email/password authentication (sign up, sign in, password reset)
- Email verification flow
- Real-time chat with Firestore
- Messages ordered by timestamp (oldest → newest)
- Delete message support (Firestore document delete)
- Simple, clean UI

---

## 🚀 Quick Start

### Prerequisites

- Flutter SDK (see `flutter --version`)
- Android Studio/SDK (for Android) and Xcode (for iOS)
- A Firebase project with Authentication and Cloud Firestore enabled

Check your setup:

```powershell
flutter --version
flutter doctor -v
```

### Firebase Setup

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add Android/iOS app(s) to your project
3. Enable Authentication → Email/Password
4. Enable Cloud Firestore (start in native mode)
5. Download and add config files:
	 - Android: `google-services.json` → `android/app/`
	 - iOS: `GoogleService-Info.plist` → `ios/Runner/`

> **Note:** This repo includes a sample `google-services.json` for Android. Replace it with your own for your Firebase project.

### Running the App

```powershell
cd path\to\Chat_App
flutter pub get
flutter run
```

Build a release APK:

```powershell
flutter build apk --release
# Output: build\app\outputs\flutter-apk\app-release.apk
```

List devices:

```powershell
flutter devices
flutter run -d <deviceId>
```

---

## 🗂️ Project Structure

- `lib/models/` — Data models (e.g., `ChatModel`)
- `lib/services/` — Firestore and Auth logic (e.g., `ChatService`)
- `lib/screens/` — UI screens (e.g., `chat_screen.dart`)
- `lib/widgets/` — Reusable widgets

---

## 💬 How Messages Are Stored

Each chat message is a document in the `chats` collection:

```json
{
	"id": "<docId>",
	"message": "Hello world",
	"senderId": "uid_123",
	"senderName": "Alice",
	"timestamp": { "_seconds": 1620000000, "_nanoseconds": 0 }
}
```

- See `lib/models/chat_model.dart` for Firestore <-> Dart conversion
- See `lib/services/chat_service.dart` for Firestore queries and delete logic

**Message order:**

```dart
FirebaseFirestore.instance
	.collection('chats')
	.orderBy('timestamp') // oldest → newest
	.snapshots();
```

To show newest first, use `.orderBy('timestamp', descending: true)` or reverse the `ListView` in the UI.

---

## 🔒 Firestore Security Rules (Example)

> **Always review and harden rules before production!**

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

---

## 🛠️ Troubleshooting

- **Firestore permission errors:** Check your rules and authentication state
- **Missing `timestamp`:** Ensure messages include a Firestore `Timestamp` (see `ChatModel.toJson`)
- **Email verification not working:** Confirm email sending is enabled in Firebase and check the `emailVerified` flag

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repo and create a feature branch
2. Run the app and add tests for new features
3. Open a PR with a clear description

Ideas:
- Add unit tests for `ChatModel` serialization
- Add UI tests for message ordering

---

## 👤 Author / Maintainer

Yassin Bassam — [GitHub](https://github.com/Yassinbassam11)

---

## 📄 License

MIT License

