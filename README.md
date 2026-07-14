# 🌌 Satori AI

<p align="center">
  <img src="assets/images/logo.png" alt="Satori AI Logo" width="120px">
  <br>
  <b>An intelligent, modern Flutter application powered by Gemini AI and secured with Firebase.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Firebase-%23039BE5.svg?style=for-the-badge&logo=Firebase&logoColor=white" alt="Firebase">
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=Dart&logoColor=white" alt="Dart">
</p>

---

## 📌 Project Overview

**Satori AI** is a cutting-edge Flutter application designed to provide a seamless, AI-driven chat experience. With robust authentication, smooth animations, and a highly responsive UI, the app bridges the gap between state-of-the-art AI technology and intuitive user design.

---

## ✨ Key Features

*   **🤖 AI Chat Interface:** Real-time conversational AI powered by `google_generative_ai` (Gemini).
*   **🔐 Robust Authentication:** Secure login & registration via Email, Google, and Facebook.
*   **🎨 Premium UI/UX:** Responsive layouts, gorgeous Dark Theme, and Arabic-friendly typography.
*   **🚀 Smooth Navigation:** Organized on-boarding flow and declarative routing.
*   **💾 Local Caching:** Fast loading and preferences storage using `shared_preferences`.

---

## 📱 Screenshots

> **💡 Developer Tip:** replace the placeholder links below with your actual screenshot URLs to showcase your app!

| Splash & Welcome | AI Chat | Authentication |
| :-: | :-: | :-: |
| <img src="https://via.placeholder.com/220x440?text=Onboarding" width="220"> | <img src="https://via.placeholder.com/220x440?text=AI+Chat" width="220"> | <img src="https://via.placeholder.com/220x440?text=Login" width="220"> |

---

## 🛠️ Tech Stack & Architecture

This project follows clean code practices, utilizing industry-standard libraries:

| Category | Libraries / Tools |
| :--- | :--- |
| **State Management** | `flutter_bloc` (Bloc pattern) |
| **Backend / Auth** | `firebase_core`, `firebase_auth`, `cloud_firestore` |
| **Social Logins** | `google_sign_in`, `flutter_facebook_auth` |
| **AI Integration** | `google_generative_ai` |
| **Dependency Injection** | `get_it` (Service Locator) |
| **UI & UX** | `flutter_screenutil`, `google_fonts`, `lottie` |

### 📁 Project Structure
*   `lib/main.dart` - Application entry point (Initializes Firebase, DI, & ScreenUtil).
*   `lib/core/` - Shared folder (`helpers`, `routing`, `services`, `widgets`).
*   `lib/features/` - Feature-first modules (`auth`, `chat`, `on_boarding`).

---

## ⚡ Setup & Installation

Follow these quick steps to run the project locally:

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/your-username/satori-ai.git](https://github.com/your-username/satori-ai.git)
    cd satori-ai
    ```

2.  **Add Configuration Files:**
    *   Place your `google-services.json` in `android/app/`.
    *   Place your `GoogleService-Info.plist` in `ios/Runner/`.

3.  **Run the App:**
    ```bash
    flutter pub get
    flutter run
    ```

---

<p align="center">
  Made with ❤️ using Flutter
</p>
