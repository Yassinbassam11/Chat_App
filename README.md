
# Chat App

Real-time global chat built with Flutter and Firebase (Auth + Cloud Firestore).

## Features
- Email/password authentication (sign up, sign in, password reset)
- Email verification flow
- Real-time messages via Firestore
- Messages ordered by timestamp (oldest → newest)

## Quick start (Windows PowerShell)
1) Clone the repo
   
	 ```powershell
	 git clone https://github.com/Yassinbassam11/Chat_App.git
	 cd Chat_App
	 ```

2) Install dependencies

	 ```powershell
	 flutter pub get
	 ```

3) Firebase setup
- In Firebase Console, create a project and add Android/iOS apps.
- Enable Authentication → Email/Password.
- Enable Cloud Firestore (in native mode).
- Download and place config files:
	- Android: android/app/google-services.json
	- iOS: ios/Runner/GoogleService-Info.plist

4) Run the app

	 ```powershell
	 flutter run
	 ```

## How it works
- Model: `lib/models/chat_model.dart` with `timestamp: DateTime` (stored as Firestore `Timestamp`).
- Stream: `lib/services/chat_service.dart` queries `chats` ordered by `timestamp`.
- UI: `lib/screens/chat_screen.dart` renders a `StreamBuilder` of `ChatModel` and sends messages.

## Firestore rules (basic example)
Adjust to your needs; this allows authenticated users to read/write their own content. For a global room, consider stricter validation.

```javascript
rules_version = '2';
service cloud.firestore {
	match /databases/{database}/documents {
		match /chats/{docId} {
			allow read: if request.auth != null;
			allow create: if request.auth != null && request.resource.data.timestamp is timestamp;
			allow update, delete: if false; // lock down edits/deletes by default
		}
	}
}
```

## Project structure
- `lib/models/` — data models
- `lib/services/` — Firebase/Auth services
- `lib/screens/` — screens (sign in, sign up, verify, forgot password, chat)
- `lib/widgets/` — reusable widgets
- `lib/view_model/` — simple app logic/state

## Troubleshooting
- Stuck on auth or verification: check Firebase Auth is enabled and your app is registered.
- Firestore permission errors: verify rules and that you’re signed in.
- Messages not ordered: confirm documents contain a `timestamp` field of type Firestore `Timestamp`.

## License
MIT

