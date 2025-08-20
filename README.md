
# Chat App

A real-time chat application built with Flutter and Firebase.

## Features
- User authentication (sign up, sign in, password reset)
- Real-time global chat
- Messages ordered by timestamp
- Email verification

## Getting Started
1. **Clone the repository:**
	```sh
	git clone <repo-url>
	cd chat_app
	```
2. **Install dependencies:**
	```sh
	flutter pub get
	```
3. **Firebase Setup:**
	- Add your Firebase project configuration files:
	  - `google-services.json` for Android in `android/app/`
	  - `GoogleService-Info.plist` for iOS in `ios/Runner/`
	- Enable Authentication and Firestore in your Firebase console.

4. **Run the app:**
	```sh
	flutter run
	```

## Project Structure
- `lib/models/` - Data models
- `lib/services/` - Firebase and authentication services
- `lib/screens/` - UI screens
- `lib/widgets/` - Reusable widgets
- `lib/view_model/` - App logic and state management

## Dependencies
- flutter
- firebase_core
- firebase_auth
- cloud_firestore

## License
This project is licensed under the MIT License.

