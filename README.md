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

* **🤖 AI Chat Interface:** Real-time conversational AI powered by `google_generative_ai` (Gemini).
* **🔐 Robust Authentication:** Secure login & registration via Email, Google, and Facebook.
* **🎨 Premium UI/UX:** Responsive layouts, gorgeous Dark Theme, and Arabic-friendly typography.
* **🚀 Smooth Navigation:** Organized on-boarding flow and declarative routing.
* **💾 Local Caching:** Fast loading and preferences storage using `shared_preferences`.

---

## 📱 App Screenshots

| Splash Screen | Onboarding | Sign In | Sign Up |
| :-: | :-: | :-: | :-: |
| <img src="https://github.com/user-attachments/assets/86a6512d-650b-4a3d-9d13-f953ea451c39" width="200"> | <img src="https://github.com/user-attachments/assets/2b56994d-7767-4bd6-be6e-c5ca1a11dd70" width="200"> | <img src="https://github.com/user-attachments/assets/12aae4c1-3fc7-49d9-a7bb-07ddae67e2ab" width="200"> | <img src="https://github.com/user-attachments/assets/3832678e-5ce3-43c0-beed-040ec0072262" width="200"> |

| Navigation Drawer | Chat Home | Chat Details |
| :-: | :-: | :-: |
| <img src="https://github.com/user-attachments/assets/9a525b64-dabf-4152-8557-f81c8de4eccd" width="220"> | <img src="https://github.com/user-attachments/assets/5fb30558-8a0d-4395-88fd-c7315260277c" width="220"> | <img src="https://github.com/user-attachments/assets/1330c09b-4706-421c-b4b1-a6c9ea65549f" width="220"> |

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
* `lib/main.dart` - Application entry point (Initializes Firebase, DI, & ScreenUtil).
* `lib/core/` - Shared folder (`helpers`, `routing`, `services`, `widgets`).
* `lib/features/` - Feature-first modules (`auth`, `chat`, `on_boarding`).

---

## ⚡ Setup & Installation

Follow these quick steps to run the project locally:

1. **Clone the Repository:**
   ```bash
   git clone [https://github.com/your-username/satori-ai.git](https://github.com/your-username/satori-ai.git)
   cd satori-ai
