# Satori Ai

A comprehensive Flutter app built with Firebase and an AI-powered chat interface.

## Project Overview

This project is a Flutter application that includes:
- `Firebase Core`, `Firebase Auth`, and `Cloud Firestore`
- Email, Google, and Facebook sign-in support
- Splash screen and onboarding flow
- AI chat interface powered by `google_generative_ai`
- State management with `flutter_bloc`
- Responsive layout with `flutter_screenutil`
- Dependency injection via `get_it`
- Local storage using `shared_preferences`

## Key Features

- Smooth onboarding and splash experience
- User registration and login flows
- Organized navigation through `AppRouter` and `Routes`
- Dark theme support
- Arabic-friendly typography with `Google Fonts`
- Lottie animation support

## Project Structure

- `lib/main.dart` - App entry point, initializes Firebase, ScreenUtil, and DI
- `lib/core/` - Shared core code such as `helper`, `routing`, `services`, `utils`, `widgets`
- `lib/features/` - Feature modules like `auth`, `chat`, `on_boarding`
- `lib/firebase_options.dart` - Firebase configuration for each platform
- `assets/` - Images and animations

## Architecture Overview

- `Firebase`, `SharedPrefHelper`, and dependency injection are initialized at startup
- `AppRouter.generateRoute` handles screen navigation
- `ChatView` is created with `BlocProvider` and `ChatBloc`
- `MaterialApp` uses light and dark theme configurations

## Setup and Run

1. Open the project in a Flutter-supported editor.
2. In the terminal at the project root, run:
   ```bash
   flutter pub get
   flutter run
   ```
3. To ensure Firebase is configured correctly, make sure `google-services.json` exists in `android/app` and the iOS Firebase config files are present.

## Dependencies Used

- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `flutter_bloc`
- `flutter_screenutil`
- `get_it`
- `shared_preferences`
- `google_fonts`
- `flutter_facebook_auth`
- `google_sign_in`
- `google_generative_ai`
- `lottie`
- `flutter_markdown`

## Notes

- Update the `version` and `build number` in `pubspec.yaml` before publishing.
- To add new screens, place them under `lib/features/` and register them in `AppRouter`.
- If targeting additional platforms, ensure Firebase configuration is set up for each platform.
