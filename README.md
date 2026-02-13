<div align="center">

# 🍬 NovaHealth – Beat the Sugar Spike  
### AI-Powered Cross-Platform Health & Sugar Intelligence Platform

[![Flutter](https://img.shields.io/badge/Flutter-3.7+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.115+-009688?logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.5+-EE4C2C?logo=pytorch&logoColor=white)](https://pytorch.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

NovaHealth is a privacy-first, AI-powered health intelligence platform designed to reduce sugar-related health risks through real-time behavioral nudges and predictive modeling.

[**Live Demo (Web)**](https://BhumiLodaya.github.io/Nova-SugarGuard/) | [**Report Bug**](https://github.com/BhumiLodaya/Nova-SugarGuard/issues) | [**Request Feature**](https://github.com/BhumiLodaya/Nova-SugarGuard/issues)

</div>

---

## 📑 Table of Contents

| 🎯 Getting Started | 🔧 Development | 📚 Resources |
| :--- | :--- | :--- |
| • [Highlights](#-highlights) | • [Project Structure](#-project-structure) | • [FAQ](#-frequently-asked-questions-faq) |
| • [Screenshots](#-screenshots) | • [Architecture](#%EF%B8%8F-architecture) | • [Performance](#-performance-benchmarks) |
| • [Disclaimer](#%EF%B8%8F-disclaimer) | • [API Documentation](#-api-documentation) | • [Tech Specs](#%EF%B8%8F-tech-specifications) |
| • [Features](#-features) | • [Installation](#-getting-started) | • [Roadmap](#%EF%B8%8F-roadmap) |

---

## 🌟 Highlights

- 🤖 **95.93% Accuracy** – TabNet ML models for obesity risk prediction.
- 💬 **AI Chatbot** – Gemini-powered health assistant with 40+ language support.
- 🔒 **Privacy First** – Offline-first architecture with AES-256 local encryption.
- 🎯 **Smart Insights** – Pattern detection across nutrition, mood, sleep & activity.
- 🗣️ **Voice Logging** – Natural Language Processing for hands-free health entry.
- 📊 **Visual Analytics** – Glassmorphic charts for tracking longitudinal progress.

---

## ⚠️ Disclaimer

**NovaHealth is a wellness tracking application and is NOT intended for medical diagnosis or treatment.**

- 🏥 Not a replacement for professional medical advice.
- 🚨 In case of emergency, contact your local healthcare provider.
- 📊 ML predictions are statistical estimates based on population data.

---

## 📋 Features

### 🧠 ML-Powered Intelligence
- **Obesity Risk Prediction**: Deep learning via TabNet with 95.93% accuracy.
- **Exercise Calorie Estimation**: Regression model (R²=0.9980) for high-precision burn tracking.
- **Sugar Impact Analysis**: Predicts glucose spikes based on intake type (e.g., Chai vs. Soda) and provides corrective physical nudges.
- **Menstrual Health**: Cycle irregularity detection with 91.06% accuracy.

### 🏃 Comprehensive Tracking
- **Workout Logger**: Tracks intensity, MET values, and duration.
- **Hydration**: Smart reminders based on physical activity levels.
- **Wellness**: Mood and symptom logging to identify correlations between diet and mental health.

### 🤖 AI Engagement
- **Gemini Integration**: Context-aware responses that analyze your local health data to provide personalized tips.
- **Multi-language**: Fully accessible in English, Hindi, Spanish, Chinese, and more.

---

## 🏗️ Tech Stack



| Category | Technologies |
| :--- | :--- |
| **Frontend** | Flutter, Dart, Riverpod (State Management) |
| **Backend** | FastAPI (Python), Uvicorn |
| **AI/ML** | PyTorch, TabNet, Google Gemini API |
| **Database** | SQLite (Local), Hive (Cache), Supabase (Cloud Sync) |
| **Security** | Firebase Auth, AES-256 Encryption |

---

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: 3.7+
- **Python**: 3.9+ (for local ML backend)
- **API Keys**: Google Gemini API Key

### Quick Installation

1. **Clone & Install Flutter**
   ```bash
   git clone [https://github.com/BhumiLodaya/Nova-SugarGuard.git](https://github.com/BhumiLodaya/Nova-SugarGuard.git)
   cd Nova-SugarGuard
   flutter pub get
Configure API Keys
Create lib/config/api_keys.dart:

Dart
class ApiKeys {
  static const String geminiApiKey = 'YOUR_GEMINI_KEY';
}
Run Mobile/Web

Bash
flutter run -d chrome  # For Web
flutter run -d android # For Android
Local ML Backend (Optional)
Bash
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn fastapi_server:app --reload
🏛️ Architecture
NovaHealth follows a Layered Architecture to ensure scalability:

Presentation: UI Widgets and Riverpod Providers.

Domain/Business: Services (Auth, ML Client, Insights Engine).

Data: Local (SQLite/Hive) and Remote (Firebase/Supabase).

📡 API Documentation
POST /predict/sugar-insight
Request:

JSON
{
  "sugarType": "cold_drink",
  "bmi": 24.5,
  "steps": 5000
}
Response:

JSON
{
  "shortTermImpact": "40g of liquid sugar will spike glucose in 15m.",
  "correctiveAction": "A 5-minute brisk walk will blunt this spike."
}
🚢 Deployment
GitHub Pages (Automatic)
The project is configured with GitHub Actions. Any push to the main branch automatically deploys the latest web version.

URL: https://BhumiLodaya.github.io/Nova-SugarGuard/

Manual Web Build
Bash
flutter build web --release --base-href="/Nova-SugarGuard/"
🗺️ Roadmap
[x] v1.0: Core ML models, Gemini Chat, and Cross-platform UI.

[ ] v1.1: Apple Health & Google Fit Synchronization.

[ ] v1.2: Computer Vision for meal photo recognition.

[ ] v2.0: Federated Learning for improved privacy-preserving ML.

🤝 Contributing
Fork the Project.

Create your Feature Branch (git checkout -b feature/AmazingFeature).

Commit your Changes (git commit -m 'Add AmazingFeature').

Push to the Branch (git push origin feature/AmazingFeature).

Open a Pull Request.

📄 License
Distributed under the MIT License. See LICENSE for more information.

<div align="center">

Made with ❤️ for the Beat the Sugar Spike Hackathon
Bhumi Lodaya | LinkedIn | GitHub

</div>


Would you like me to generate a specific **"Architecture Diagram"** image description or help you draft the `LICENSE` file for this project?ucture)
- [Architecture](#%EF%B8%8F-architecture)
- [API Documentation](#-api-documentation)
- [Configuration](#-configuration)
- [Testing](#-testing)
- [Troubleshooting](#-troubleshooting)
- [Deployment](#-deployment)

</td>
<td valign="top" width="33%">

### 📚 Resources
- [FAQ](#-frequently-asked-questions-faq)
- [Performance](#-performance-benchmarks)
- [Tech Specs](#%EF%B8%8F-tech-specifications)
- [Contributing](#-contributing)
- [Roadmap](#%EF%B8%8F-roadmap)
- [License](#-license)
- [Contact](#-contact--support)

</td>
</tr>
</table>

---

## 🌟 Highlights

- 🤖 **95.93% Accuracy** - TabNet ML models for obesity risk prediction
- 💬 **AI Chatbot** - Gemini-powered health assistant with 40+ language support
- 🔒 **Privacy First** - Offline-first architecture with optional cloud sync
- 🎯 **Smart Insights** - Pattern detection across nutrition, mood, sleep & activity
- 🗣️ **Voice Logging** - Speech-to-text for quick health data entry
- 📊 **Visual Analytics** - Beautiful charts and progress tracking
- 🏆 **Gamification** - Streaks, milestones, and leaderboards

---

## ⚠️ Disclaimer

**NovaHealth is a wellness tracking application and is NOT intended for medical diagnosis, treatment, or prevention of disease.**

- 🏥 This app is for **informational and educational purposes only**
- 👨‍⚕️ Always consult qualified healthcare professionals for medical advice
- 🚨 In case of emergency, contact your local emergency services immediately
- 📊 ML predictions are statistical estimates, not medical diagnoses
- 🔬 Health insights are based on patterns, not clinical assessments

**By using NovaHealth, you acknowledge that:**
- The app does not replace professional medical care
- You should not rely solely on the app for health decisions
- The developers are not liable for any health outcomes
- You use the app at your own risk

---

## 📋 Features

### 🏃 Health Tracking
- **Workout Logger** - Track exercises, duration, intensity, and calories burned
- **Hydration Monitor** - Log water intake with smart reminders and daily goals
- **Period Tracker** - Menstrual cycle tracking with symptom logging and predictions
- **Mood Tracker** - Daily mood logging with intensity and contributing factors
- **Symptom Logger** - Record and monitor health symptoms with severity levels
- **Nutrition Tracker** - Food logging with calorie counting and USDA database

### 🧠 ML-Powered Health Intelligence
- **Obesity Risk Prediction** - 95.93% accuracy using TabNet neural networks
- **Exercise Calorie Prediction** - R²=0.9980 for precise calorie burn estimates
- **Menstrual Health Analysis** - 91.06% accuracy for cycle irregularity detection
- **Sugar Impact Analysis** - Real-time glucose spike predictions with corrective actions
- **Health Insights Engine** - Rule-based pattern detection across all metrics:
  - Weight & Activity Correlation
  - Sleep Pattern Analysis
  - Hydration-Mood Correlation
  - Exercise Consistency
  - Recovery Analysis
  - Nutrition Trends

### 🤖 AI Features
- **Health Chatbot** - Gemini-powered conversational AI for personalized health guidance
- **Multi-language Support** - 40+ languages supported (English, Spanish, Hindi, Chinese, etc.)
- **Context-Aware Responses** - Chatbot accesses your health data for personalized advice
- **Voice Input** - Speech-to-text for natural conversation
- **Chat History** - Persistent conversations across sessions

### 🔐 Security & Privacy
- **Firebase Authentication** - Secure email/password login with industry standards
- **Multi-Factor Authentication** - SMS-based 2FA for enhanced security
- **End-to-End Encryption** - Local data encryption with AES-256
- **Offline-First** - All data stored locally by default
- **Optional Cloud Sync** - Backup to Supabase/Firebase (user-controlled)
- **Guest Mode** - Use app without creating an account

### 🎨 User Experience
- **Glassmorphic UI** - Modern frosted glass design with smooth animations
- **Dynamic Island** - iPhone 16-inspired header with live health stats
- **Quick Actions** - One-tap logging for common activities
- **Success Animations** - Delightful feedback for completed actions
- **Streak System** - Daily logging streaks with milestone celebrations
- **Health Calendar** - Visual timeline of all health events
- **Dark/Light Theme** - Automatic theme switching

### 🌐 Cross-Platform Support
<table>
  <tr>
    <td align="center">📱 Android</td>
    <td align="center">🍎 iOS</td>
    <td align="center">🌐 Web</td>
  </tr>
  <tr>
    <td align="center">💻 Windows</td>
    <td align="center">🖥️ macOS</td>
    <td align="center">🐧 Linux</td>
  </tr>
</table>

---

## 🏗️ Tech Stack

<table>
  <tr>
    <th>Category</th>
    <th>Technologies</th>
  </tr>
  <tr>
    <td><strong>Frontend</strong></td>
    <td>Flutter 3.7+, Dart, Riverpod (State Management)</td>
  </tr>
  <tr>
    <td><strong>Backend</strong></td>
    <td>FastAPI, Python 3.9+, Uvicorn</td>
  </tr>
  <tr>
    <td><strong>ML/AI</strong></td>
    <td>PyTorch, TabNet, Scikit-learn, Google Gemini API</td>
  </tr>
  <tr>
    <td><strong>Database</strong></td>
    <td>SQLite (local), Hive (cache), Supabase/Firebase (cloud)</td>
  </tr>
  <tr>
    <td><strong>Authentication</strong></td>
    <td>Firebase Auth, Flutter Secure Storage</td>
  </tr>
  <tr>
    <td><strong>UI/Charts</strong></td>
    <td>fl_chart, custom animations, glassmorphism</td>
  </tr>
  <tr>
    <td><strong>Voice</strong></td>
    <td>speech_to_text, Google Speech Recognition</td>
  </tr>
  <tr>
    <td><strong>Deployment</strong></td>
    <td>Render.com (ML backend), Firebase Hosting (web)</td>
  </tr>
</table>

---

## 🎯 Platforms

All platforms use the same codebase with native compilation:

- ✅ **Android** (API 21+) - Native ARM/x64
- ✅ **iOS** (iOS 12+) - Native ARM64
- ✅ **Web** (All modern browsers) - Progressive Web App
- ✅ **Windows** (Windows 10+) - Native Win32/UWP
- ✅ **macOS** (macOS 10.14+) - Native Cocoa
- ✅ **Linux** (GTK 3.0+) - Native x64

---

## 🚀 Getting Started

### Prerequisites

<table>
  <tr>
    <th>Tool</th>
    <th>Version</th>
    <th>Purpose</th>
  </tr>
  <tr>
    <td><a href="https://flutter.dev/docs/get-started/install">Flutter SDK</a></td>
    <td>3.7+</td>
    <td>Mobile & Desktop UI</td>
  </tr>
  <tr>
    <td><a href="https://dart.dev/get-dart">Dart SDK</a></td>
    <td>3.0+</td>
    <td>Included with Flutter</td>
  </tr>
  <tr>
    <td><a href="https://developer.android.com/studio">Android Studio</a></td>
    <td>Latest</td>
    <td>Android builds (optional)</td>
  </tr>
  <tr>
    <td><a href="https://developer.apple.com/xcode/">Xcode</a></td>
    <td>14+</td>
    <td>iOS/macOS builds (Mac only)</td>
  </tr>
  <tr>
    <td><a href="https://www.python.org/downloads/">Python</a></td>
    <td>3.9+</td>
    <td>ML backend (optional)</td>
  </tr>
</table>

### Quick Start (5 minutes)

```bash
# 1️⃣ Clone the repository
git clone https://github.com/yourusername/nova-health.git
cd nova-health

# 2️⃣ Install Flutter dependencies
flutter pub get

# 3️⃣ Run the app (any platform)
flutter run

# Optional: Specify platform
flutter run -d chrome       # Web
flutter run -d android      # Android
flutter run -d windows      # Windows
```

### Full Setup (with ML Backend)

#### Step 1: Configure API Keys

Create `lib/config/api_keys.dart`:

```dart
class ApiKeys {
  // Get free key at: https://aistudio.google.com/app/apikey
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY_HERE';
}
```

**Or** directly edit `lib/services/chatbot_service.dart`:

```dart
static const String _apiKey = 'YOUR_GEMINI_API_KEY_HERE';
```

#### Step 2: Firebase Setup (Optional - for Auth & Cloud Sync)

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Enable **Email/Password Authentication**
3. Download configuration files:
   - `google-services.json` → `android/app/`
   - `GoogleService-Info.plist` → `ios/Runner/`
4. Run the Firebase CLI:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

#### Step 3: Supabase Setup (Optional - for Cloud Backup)

1. Create a Supabase project at [supabase.com](https://supabase.com)
2. Edit `lib/config/supabase_config.dart`:

```dart
class SupabaseConfig {
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
  static const bool isConfigured = true;
}
```

#### Step 4: Run ML Backend Locally (Optional)

```bash
# Navigate to backend directory
cd backend

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Start FastAPI server
uvicorn fastapi_server:app --host 0.0.0.0 --port 8000 --reload

# Server will be available at: http://localhost:8000
```

**Update ML endpoint** in `lib/services/ml_prediction_service.dart`:

```dart
static const String baseUrl = 'http://localhost:8000';  // For local testing
// static const String baseUrl = 'https://novahealth-backend.onrender.com';  // Production
```

#### Step 5: Run the App

```bash
# Web (recommended for development)
flutter run -d chrome

# Android (requires device/emulator)
flutter run -d android

# iOS (requires Mac + device/simulator)
flutter run -d ios

# Windows Desktop
flutter run -d windows

# macOS Desktop
flutter run -d macos

# Linux Desktop
flutter run -d linux
```

---

## 📱 Platform-Specific Instructions

### Android

```bash
# Check connected devices
flutter devices

# Run in debug mode
flutter run -d android

# Build APK
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

### iOS

```bash
# Check connected devices
flutter devices

# Run on simulator
open -a Simulator
flutter run -d ios

# Build for release
flutter build ipa

# Output: build/ios/archive/Runner.xcarchive
```

### Web

```bash
# Run in Chrome
flutter run -d chrome

# Build for production
flutter build web --release

# Output: build/web/
# Deploy to Firebase Hosting, Netlify, or any static host
```

### Windows

```bash
# Run desktop app
flutter run -d windows

# Build executable
flutter build windows --release

# Output: build/windows/runner/Release/
```

---

## 📂 Project Structure

```
nova-health/
├── 📱 android/             # Android native code
├── 🍎 ios/                 # iOS native code
├── 🌐 web/                 # Web-specific assets
├── 💻 windows/             # Windows native code
├── 🖥️  macos/              # macOS native code
├── 🐧 linux/               # Linux native code
│
├── 🎯 lib/                 # Main Flutter application
│   ├── config/             # App configuration
│   │   ├── routes.dart           # Navigation routes
│   │   ├── theme.dart            # App theming
│   │   └── supabase_config.dart  # Cloud sync config
│   │
│   ├── models/             # Data models (with Hive adapters)
│   │   ├── user_model.dart
│   │   ├── workout_model.dart
│   │   ├── food_log_model.dart
│   │   ├── hydration_model.dart
│   │   ├── mood_log_model.dart
│   │   ├── period_cycle_model.dart
│   │   ├── symptom_model.dart
│   │   └── health_metric_model.dart
│   │
│   ├── pages/              # UI screens
│   │   ├── auth/                 # Authentication
│   │   │   ├── landing_page.dart
│   │   │   ├── login_page.dart
│   │   │   ├── signup_page.dart
│   │   │   ├── forgot_password_page.dart
│   │   │   ├── mfa_challenge_page.dart
│   │   │   └── consent_screen.dart
│   │   │
│   │   ├── home/                 # Main navigation
│   │   │   └── home_page.dart
│   │   │
│   │   ├── dashboard/            # Health overview
│   │   │   └── dashboard_page.dart
│   │   │
│   │   ├── tracking/             # Health tracking
│   │   │   ├── workout_log_page.dart
│   │   │   ├── hydration_page.dart
│   │   │   ├── period_tracker_page.dart
│   │   │   └── symptoms_page.dart
│   │   │
│   │   ├── nutrition/            # Food & meal tracking
│   │   │   ├── nutrition_page.dart
│   │   │   └── meal_plan_page.dart
│   │   │
│   │   ├── wellness/             # Mental wellness
│   │   │   ├── mood_tracker_page.dart
│   │   │   └── meditation_page.dart
│   │   │
│   │   ├── chatbot/              # AI assistant
│   │   │   └── chatbot_page.dart
│   │   │
│   │   ├── profile/              # User profile
│   │   │   ├── profile_page.dart
│   │   │   ├── edit_profile_page.dart
│   │   │   └── change_password_page.dart
│   │   │
│   │   ├── settings/             # App settings
│   │   │   ├── settings_page.dart
│   │   │   ├── mfa_settings_page.dart
│   │   │   ├── language_page.dart
│   │   │   └── sync_test_page.dart
│   │   │
│   │   ├── calendar/             # Health calendar
│   │   │   └── health_calendar_page.dart
│   │   │
│   │   ├── leaderboard/          # Gamification
│   │   │   └── leaderboard_page.dart
│   │   │
│   │   ├── onboarding/           # First-time user flow
│   │   │   └── onboarding_page.dart
│   │   │
│   │   └── health_risk_page.dart # ML predictions
│   │
│   ├── providers/          # State management (Riverpod)
│   │   ├── auth_provider.dart
│   │   ├── health_provider.dart
│   │   ├── nutrition_providers.dart
│   │   ├── tracking_providers.dart
│   │   ├── wellness_providers.dart
│   │   ├── streak_provider.dart
│   │   └── sugar_log_provider.dart
│   │
│   ├── services/           # Business logic & APIs
│   │   ├── auth_service.dart             # Authentication
│   │   ├── database_service.dart         # Local database
│   │   ├── sqlite_service.dart           # SQLite operations
│   │   ├── supabase_service.dart         # Cloud sync
│   │   ├── database_sync_service.dart    # Sync logic
│   │   ├── ml_prediction_service.dart    # ML API client
│   │   ├── chatbot_service.dart          # Gemini AI
│   │   ├── voice_log_service.dart        # Speech-to-text
│   │   ├── health_insights_engine.dart   # Pattern detection
│   │   ├── sugar_insight_service.dart    # Sugar analysis
│   │   ├── security_service.dart         # Encryption
│   │   ├── guest_service.dart            # Guest mode
│   │   └── backend_keepalive_service.dart # Keep ML server awake
│   │
│   ├── widgets/            # Reusable UI components
│   │   ├── custom_button.dart
│   │   ├── custom_text_field.dart
│   │   ├── glass_widgets.dart
│   │   ├── quick_action_card.dart
│   │   ├── quick_log_widget.dart
│   │   ├── streak_widgets.dart
│   │   ├── success_animation_overlay.dart
│   │   └── signup_gate_card.dart
│   │
│   ├── utils/              # Helper functions
│   │   ├── constants.dart
│   │   ├── validators.dart
│   │   ├── helpers.dart
│   │   ├── data_export.dart
│   │   └── demo_data_seeder.dart
│   │
│   ├── main.dart           # App entry point
│   └── firebase_options.dart
│
├── 🤖 backend/             # Python ML Backend
│   ├── fastapi_server.py         # FastAPI application
│   ├── lightweight_models.py     # Model optimization
│   ├── optimize_models.py        # Training scripts
│   ├── requirements.txt          # Python dependencies
│   ├── runtime.txt               # Python version
│   ├── Procfile                  # Render deployment
│   ├── railway.json              # Railway deployment
│   │
│   └── optimized_models/         # Trained ML models
│       ├── obesity/              # Obesity prediction model
│       ├── exercise/             # Exercise calorie model
│       ├── menstrual/            # Menstrual health model
│       └── metrics.json          # Model performance
│
├── 📊 ml_models/           # ML training datasets
├── 📈 ml_reports/          # Training reports
├── 🧪 test/                # Unit & widget tests
├── 📄 pubspec.yaml         # Flutter dependencies
├── 🔥 firebase.json        # Firebase config
├── 📋 README.md            # This file
└── 📜 LICENSE              # MIT License
```

---

## 🏛️ Architecture

### Frontend Architecture (Flutter)

```
┌─────────────────────────────────────────────────────────┐
│                     Presentation Layer                   │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌─────────┐ │
│  │  Pages   │  │ Widgets  │  │  Theme   │  │ Routes  │ │
│  └────┬─────┘  └────┬─────┘  └──────────┘  └─────────┘ │
└───────┼────────────┼─────────────────────────────────────┘
        │            │
        ▼            ▼
┌─────────────────────────────────────────────────────────┐
│                  State Management Layer                  │
│  ┌──────────────────────────────────────────────────┐   │
│  │           Riverpod Providers                     │   │
│  │  • Auth Provider    • Health Provider            │   │
│  │  • Nutrition        • Tracking                   │   │
│  │  • Wellness         • Streak                     │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────┬───────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│                     Business Logic Layer                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   Services   │  │  Insights    │  │    Utils     │  │
│  │              │  │   Engine     │  │              │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└───────────┬─────────────────────────────────────────────┘
            │
            ▼
┌─────────────────────────────────────────────────────────┐
│                      Data Layer                          │
│  ┌─────────┐  ┌─────────┐  ┌──────────┐  ┌──────────┐ │
│  │ SQLite  │  │  Hive   │  │ Firebase │  │ Supabase │ │
│  │ (Local) │  │ (Cache) │  │ (Cloud)  │  │ (Cloud)  │ │
│  └─────────┘  └─────────┘  └──────────┘  └──────────┘ │
└─────────────────────────────────────────────────────────┘
```

### Backend Architecture (FastAPI + ML)

```
┌─────────────────────────────────────────────────────────┐
│                      Client (Flutter)                    │
└────────────────────────┬────────────────────────────────┘
                         │ HTTP/REST
                         ▼
┌─────────────────────────────────────────────────────────┐
│                   FastAPI Server                         │
│  ┌───────────────────────────────────────────────────┐  │
│  │              API Endpoints                        │  │
│  │  • /predict/health-risk                           │  │
│  │  • /predict/obesity                               │  │
│  │  • /predict/exercise                              │  │
│  │  • /predict/menstrual                             │  │
│  │  • /predict/sugar-insight                         │  │
│  └───────────────────────┬───────────────────────────┘  │
└───────────────────────────┼──────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────┐
│                   ML Pipeline                            │
│  ┌─────────────────┐  ┌─────────────────┐              │
│  │ Data Processing │→ │   TabNet Model  │              │
│  │ • Normalization │  │  • PyTorch      │              │
│  │ • Feature Eng   │  │  • Inference    │              │
│  └─────────────────┘  └─────────────────┘              │
└─────────────────────────────────────────────────────────┘
```

### Data Flow

```
User Input → Flutter UI → Riverpod Provider → Service Layer
                                                    │
                          ┌─────────────────────────┼─────────────────────┐
                          │                         │                     │
                          ▼                         ▼                     ▼
                    SQLite (Local)            ML Backend            Gemini AI
                          │                    (FastAPI)           (Chatbot)
                          ▼                         │                     │
                    Cloud Sync                      │                     │
                  (Optional Backup)                 │                     │
                          │                         │                     │
                          └─────────────────────────┴─────────────────────┘
                                              │
                                              ▼
                                      User gets insights
```

---

## 📡 API Documentation

### ML Backend

The ML backend is hosted on Render.com and provides health predictions via REST API.

**🌐 Live API**: `https://novahealth-backend.onrender.com`

#### Endpoints

##### 1. Health Check

```http
GET /
```

**Response:**
```json
{
  "status": "healthy",
  "message": "NovaHealth ML API is running",
  "models": {
    "obesity": "loaded",
    "exercise": "not_loaded",
    "menstrual": "not_loaded"
  }
}
```

---

##### 2. Comprehensive Health Risk Assessment

```http
POST /predict/health-risk
```

**Request Body:**
```json
{
  "age": 28,
  "gender": "female",
  "weight": 65,
  "height": 165,
  "activityLevel": "moderately_active",
  "targetWeight": 60,
  "totalWaterMl": 2000,
  "hydrationLogs": [
    {"timestamp": "2024-01-15T08:00:00Z", "amount_ml": 250}
  ],
  "moodLogs": [
    {
      "mood": "happy",
      "intensity": 8,
      "factors": ["exercise", "good_sleep"]
    }
  ],
  "symptoms": [
    {"type": "headache", "severity": 3}
  ],
  "exerciseDuration": 30,
  "exerciseIntensity": 7,
  "heartRate": 145
}
```

**Response:**
```json
{
  "obesityRisk": {
    "risk_level": "low",
    "risk_score": 0.15,
    "bmi": 23.9,
    "bmi_category": "normal"
  },
  "exerciseMetrics": {
    "predicted_calories": 285,
    "met_value": 8.5,
    "intensity_level": "moderate"
  },
  "recommendations": [
    "Excellent hydration! Keep it up.",
    "Your workout intensity is optimal for your age group."
  ]
}
```

---

##### 3. Obesity Risk Prediction

```http
POST /predict/obesity
```

**Request Body:**
```json
{
  "age": 35,
  "gender": "male",
  "weight": 85,
  "height": 175,
  "activityLevel": "lightly_active"
}
```

**Response:**
```json
{
  "risk_level": "moderate",
  "risk_score": 0.62,
  "bmi": 27.8,
  "bmi_category": "overweight",
  "confidence": 0.89,
  "recommendations": [
    "Consider increasing physical activity to 150 min/week",
    "Focus on reducing 5-10% body weight gradually"
  ]
}
```

---

##### 4. Sugar Impact Insight

```http
POST /predict/sugar-insight
```

**Request Body:**
```json
{
  "sugarType": "cold_drink",
  "bmi": 24.5,
  "steps": 5000
}
```

**Response:**
```json
{
  "shortTermImpact": "~40 g of liquid sugar will spike your blood glucose within 15 minutes. Expect an energy crash in ~90 min.",
  "correctiveAction": "Good step count so far. A quick 5-minute stair climb or 20 squats will blunt the spike."
}
```

**Sugar Types:**
- `chai` - Tea with sugar (~10g)
- `cold_drink` - Soda/juice (~40g)
- `sweets` - Desserts (~30g)
- `snack` - Packaged snacks (~15g)

---

### Error Responses

**400 Bad Request:**
```json
{
  "detail": "Invalid input parameters"
}
```

**500 Internal Server Error:**
```json
{
  "detail": "Model inference failed"
}
```

---

## 🧪 ML Model Performance

<table>
  <tr>
    <th>Model</th>
    <th>Task</th>
    <th>Metric</th>
    <th>Score</th>
    <th>Dataset Size</th>
  </tr>
  <tr>
    <td><strong>Obesity Risk</strong></td>
    <td>Classification</td>
    <td>Accuracy</td>
    <td><strong>95.93%</strong></td>
    <td>2,111 samples</td>
  </tr>
  <tr>
    <td><strong>Exercise Calories</strong></td>
    <td>Regression</td>
    <td>R² Score</td>
    <td><strong>0.9980</strong></td>
    <td>15,000+ samples</td>
  </tr>
  <tr>
    <td><strong>Menstrual Health</strong></td>
    <td>Classification</td>
    <td>Accuracy</td>
    <td><strong>91.06%</strong></td>
    <td>21,960 samples</td>
  </tr>
</table>

### Model Architecture

All models use **TabNet** (Attentive Interpretable Tabular Learning):
- **Framework**: PyTorch
- **Architecture**: Self-attention mechanism with sequential feature selection
- **Training**: 50-100 epochs with early stopping
- **Optimization**: Memory-optimized for 512MB RAM (Render free tier)
- **Inference**: ~50-100ms per prediction

---

## 🔧 Configuration

### Environment Variables

Create `.env` file in the root directory:

```env
# AI Chatbot (Required for chatbot feature)
GEMINI_API_KEY=your_gemini_api_key_here

# Supabase (Optional - for cloud backup)
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_ANON_KEY=your_supabase_anon_key

# Firebase (Optional - for authentication)
FIREBASE_API_KEY=your_firebase_api_key
FIREBASE_PROJECT_ID=your_firebase_project_id
```

### Firebase Configuration

1. **Create Firebase Project**: [console.firebase.google.com](https://console.firebase.google.com)
2. **Enable Authentication**:
   - Email/Password
   - Phone (for MFA)
3. **Download Config Files**:
   - Android: `google-services.json` → `android/app/`
   - iOS: `GoogleService-Info.plist` → `ios/Runner/`
   - Web: Copy config to `lib/firebase_options.dart`
4. **Enable Firestore Database** (optional for cloud sync)

### Supabase Configuration

1. **Create Project**: [supabase.com](https://supabase.com)
2. **Run Migration**:
   ```sql
   -- Use provided schema
   -- See: supabase_schema_no_auth.sql
   ```
3. **Update Config**: Edit `lib/config/supabase_config.dart`

---

## 🐛 Troubleshooting

### Common Issues

#### Build Errors

**Problem**: `flutter pub get` fails

```bash
# Solution: Clear cache and reinstall
flutter clean
flutter pub cache repair
flutter pub get
```

**Problem**: Platform-specific build errors

```bash
# Android
cd android && ./gradlew clean && cd ..

# iOS
cd ios && pod deintegrate && pod install && cd ..

# Flutter
flutter clean
flutter pub get
```

#### ML Backend Issues

**Problem**: Backend not responding

- The free tier sleeps after 15 minutes of inactivity
- First request may take 30-60 seconds to wake up
- Keep-alive service pings every 10 minutes

**Problem**: Model loading timeout

```python
# Solution: Increase timeout in ml_prediction_service.dart
timeout: const Duration(seconds: 30)  # Increase from 10
```

#### Firebase Issues

**Problem**: Firebase initialization fails

```bash
# Re-run FlutterFire CLI
dart pub global activate flutterfire_cli
flutterfire configure
```

#### Database Issues

**Problem**: SQLite database locked

```dart
// Solution: Close database properly
await DatabaseService().close();
```

**Problem**: Data not syncing

```dart
// Check sync status
final syncService = DatabaseSyncService();
final status = await syncService.getSyncStatus();
print('Last sync: ${status.lastSync}');
```

---

## 🧪 Testing

### Run Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

### Test Coverage

Current coverage:
- Unit Tests: ✅ Auth, Database, Insights Engine
- Widget Tests: ✅ Custom Widgets
- Integration Tests: 🚧 In Progress

---

## 🚢 Deployment

### Mobile App Stores

#### Google Play Store

```bash
# Build signed APK
flutter build apk --release --split-per-abi

# Build App Bundle
flutter build appbundle --release
```

#### Apple App Store

```bash
# Build iOS archive
flutter build ipa --release

# Open in Xcode
open build/ios/archive/Runner.xcarchive
```

### Web Deployment

#### GitHub Pages (Recommended)

**Automatic deployment with GitHub Actions** - See [DEPLOYMENT.md](DEPLOYMENT.md) for full guide.

**Live Demo**: https://BhumiLodaya.github.io/Nova-SugarGuard/

```bash
# Automatic deployment is configured!
# Just push to main branch:
git add .
git commit -m "Deploy to GitHub Pages"
git push origin main

# Manual deployment (alternative):
flutter build web --release --base-href="/Nova-SugarGuard/"
gh-pages -d build/web
```

**Setup Steps:**
1. Enable GitHub Pages in repository settings (Source: `gh-pages` branch)
2. Grant workflow write permissions in Settings → Actions
3. Push to `main` branch - deployment happens automatically!

#### Firebase Hosting

```bash
# Build web app
flutter build web --release

# Deploy to Firebase
firebase deploy --only hosting
```

#### Netlify

```bash
# Build
flutter build web --release

# Deploy (drag build/web folder to Netlify)
```

### ML Backend Deployment

#### Render.com (Current)

1. Connect GitHub repository
2. Environment: Docker/Python
3. Build Command: `pip install -r backend/requirements.txt`
4. Start Command: `cd backend && uvicorn fastapi_server:app --host 0.0.0.0 --port $PORT`

#### Railway.app

```bash
# Install Railway CLI
npm i -g @railway/cli

# Deploy
cd backend
railway up
```

---

## ❓ Frequently Asked Questions (FAQ)

<details>
<summary><strong>Is NovaHealth free to use?</strong></summary>

Yes! NovaHealth is completely free and open-source under the MIT License. All core features are available without any subscription or payment.

</details>

<details>
<summary><strong>Do I need an account to use the app?</strong></summary>

No! NovaHealth has a Guest Mode that lets you use all features without creating an account. Your data stays on your device. Creating an account enables cloud backup and sync across devices.

</details>

<details>
<summary><strong>Is my health data secure?</strong></summary>

Absolutely! NovaHealth uses:
- Offline-first architecture (data stays on your device)
- AES-256 encryption for local storage
- Optional cloud sync (you control it)
- No data selling or third-party sharing
- Firebase/Supabase for secure cloud backup
</details>

<details>
<summary><strong>Which platforms are supported?</strong></summary>

NovaHealth runs on all major platforms:
- 📱 Mobile: Android, iOS
- 🌐 Web: All modern browsers
- 💻 Desktop: Windows, macOS, Linux
</details>

<details>
<summary><strong>Can I use NovaHealth offline?</strong></summary>

Yes! NovaHealth is designed offline-first. All features work without internet except:
- AI Chatbot (requires Gemini API)
- ML Predictions (requires backend API)
- Cloud sync

Your data is always saved locally.
</details>

<details>
<summary><strong>How accurate are the ML predictions?</strong></summary>

Our models achieve high accuracy:
- Obesity Risk: 95.93%
- Exercise Calories: R²=0.9980
- Menstrual Health: 91.06%

However, these are statistical estimates, not medical diagnoses. Always consult healthcare professionals.
</details>

<details>
<summary><strong>Can I export my health data?</strong></summary>

Yes! You can export all your data to:
- CSV format (for Excel/Google Sheets)
- JSON format (for developers)
- PDF reports (coming soon)

Go to Settings → Export Data
</details>

<details>
<summary><strong>Does NovaHealth integrate with Apple Health or Google Fit?</strong></summary>

Not yet, but it's on our roadmap for v1.1! Currently, you need to manually log data in the app.
</details>

<details>
<summary><strong>Is NovaHealth HIPAA compliant?</strong></summary>

NovaHealth is a personal wellness app, not a medical records system, so HIPAA doesn't directly apply. However, we follow best practices for data security and privacy.
</details>

<details>
<summary><strong>Can I contribute to the project?</strong></summary>

Yes! We welcome contributions. See the [Contributing](#-contributing) section below for guidelines.
</details>

---

## ⚡ Performance Benchmarks

### App Performance

<table>
  <tr>
    <th>Metric</th>
    <th>Android</th>
    <th>iOS</th>
    <th>Web</th>
    <th>Desktop</th>
  </tr>
  <tr>
    <td><strong>Startup Time</strong></td>
    <td>1.2s</td>
    <td>0.9s</td>
    <td>1.5s</td>
    <td>0.8s</td>
  </tr>
  <tr>
    <td><strong>Memory Usage</strong></td>
    <td>~80MB</td>
    <td>~70MB</td>
    <td>~120MB</td>
    <td>~100MB</td>
  </tr>
  <tr>
    <td><strong>APK Size</strong></td>
    <td>25MB</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td><strong>IPA Size</strong></td>
    <td>-</td>
    <td>30MB</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td><strong>Exe Size</strong></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>35MB</td>
  </tr>
</table>

### ML Backend Performance

| Operation | Latency | Rate Limit |
|-----------|---------|------------|
| Health Risk Prediction | ~80ms | 60 req/min |
| Obesity Prediction | ~50ms | 100 req/min |
| Sugar Insight | ~30ms | 120 req/min |
| Model Loading (Cold Start) | ~15s | N/A |

*Tested on Render.com free tier (512MB RAM, 0.1 CPU)*

### Database Performance

| Operation | Time | Notes |
|-----------|------|-------|
| Write (Single) | <5ms | SQLite local |
| Read (Single) | <2ms | Indexed queries |
| Bulk Write (100 items) | ~50ms | Transaction batched |
| Cloud Sync | ~500ms | Depends on network |

---

## 🛠️ Tech Specifications

### Frontend (Flutter)

```yaml
SDK: Flutter 3.7+, Dart 3.0+
State Management: Riverpod 2.5+
Local Storage: SQLite + Hive
Animations: Custom spring animations
Charts: fl_chart 0.66+
HTTP Client: http 1.2+
```

### Backend (Python)

```python
Framework: FastAPI 0.115+
ML Framework: PyTorch 2.5+
Model: TabNet 4.1+
Server: Uvicorn (ASGI)
Deployment: Docker, Render.com
Memory: Optimized for 512MB RAM
```

### Security

```
Encryption: AES-256
Authentication: Firebase Auth (JWT)
MFA: SMS-based (Twilio)
Storage: flutter_secure_storage
API Security: CORS, Rate limiting
```

---

## 📋 Quick Command Reference

### Flutter Commands

```bash
# Development
flutter run -d chrome          # Run on Chrome
flutter run -d android         # Run on Android
flutter hot-reload            # Hot reload (r in terminal)
flutter hot-restart           # Hot restart (R in terminal)

# Code Quality
flutter analyze               # Static analysis
dart format .                 # Format code
flutter test                  # Run tests
flutter test --coverage       # Test with coverage

# Build Release
flutter build apk --release           # Android APK
flutter build appbundle --release     # Android App Bundle
flutter build ipa --release           # iOS
flutter build web --release           # Web
flutter build windows --release       # Windows
flutter build macos --release         # macOS
flutter build linux --release         # Linux

# Maintenance
flutter clean                 # Clean build cache
flutter pub get               # Install dependencies
flutter pub upgrade           # Upgrade dependencies
flutter doctor                # Check setup
flutter devices               # List connected devices
```

### Python Backend Commands

```bash
# Environment Setup
python -m venv venv                          # Create virtual env
source venv/bin/activate                     # Activate (Unix)
venv\Scripts\activate                        # Activate (Windows)

# Dependencies
pip install -r requirements.txt              # Install packages
pip freeze > requirements.txt                # Save packages

# Development
uvicorn fastapi_server:app --reload          # Run with auto-reload
uvicorn fastapi_server:app --host 0.0.0.0 --port 8000  # Production

# Testing
pytest                                       # Run tests
pytest --cov                                 # With coverage
```

### Git Commands

```bash
# Setup
git clone <repo-url>                         # Clone repository
git checkout -b feature/name                 # Create branch

# Development
git status                                   # Check status
git add .                                    # Stage changes
git commit -m "message"                      # Commit
git push origin branch-name                  # Push to GitHub

# Sync
git pull origin main                         # Pull latest
git merge main                               # Merge main into branch
```

### Database Commands (SQLite)

```bash
# Open database
sqlite3 novahealth.db

# Common queries
.tables                                      # List tables
.schema table_name                           # Show schema
SELECT * FROM health_metrics LIMIT 10;      # Query data
.exit                                        # Exit SQLite
```

---

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help:

### Ways to Contribute

1. 🐛 **Report Bugs** - Open an issue with detailed reproduction steps
2. 💡 **Suggest Features** - Share your ideas for new features
3. 📝 **Improve Documentation** - Fix typos, add examples
4. 🎨 **Design Improvements** - Suggest UI/UX enhancements
5. 🔧 **Code Contributions** - Submit pull requests

### Development Workflow

1. **Fork the Repository**
   ```bash
   # Click "Fork" on GitHub
   git clone https://github.com/yourusername/nova-health.git
   cd nova-health
   ```

2. **Create Feature Branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```

3. **Make Changes**
   - Follow Dart style guide
   - Add tests for new features
   - Update documentation

4. **Test Your Changes**
   ```bash
   flutter test
   flutter analyze
   dart format .
   ```

5. **Commit Changes**
   ```bash
   git add .
   git commit -m "Add: Amazing new feature"
   ```
   
   **Commit Convention:**
   - `Add:` New features
   - `Fix:` Bug fixes
   - `Update:` Changes to existing features
   - `Docs:` Documentation changes
   - `Style:` Code style changes
   - `Refactor:` Code refactoring
   - `Test:` Testing additions/changes

6. **Push to GitHub**
   ```bash
   git push origin feature/amazing-feature
   ```

7. **Open Pull Request**
   - Go to your fork on GitHub
   - Click "New Pull Request"
   - Describe your changes
   - Link related issues

### Code Style Guidelines

**Dart/Flutter:**
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `dart format` before committing
- Max line length: 80 characters
- Use meaningful variable names

**Python:**
- Follow [PEP 8](https://pep8.org/)
- Use type hints
- Max line length: 100 characters
- Use docstrings for functions

### Testing Guidelines

- Write unit tests for business logic
- Write widget tests for UI components
- Maintain >80% code coverage
- Test on multiple platforms

---

## 🗺️ Roadmap

### ✅ Completed (v1.0)

- [x] Core health tracking (workout, hydration, mood, period)
- [x] ML-powered predictions (obesity, exercise, menstrual)
- [x] AI chatbot with Gemini
- [x] Voice logging for sugar intake
- [x] Offline-first architecture
- [x] Cloud sync (Firebase + Supabase)
- [x] Multi-factor authentication
- [x] 6-platform support
- [x] Health insights engine
- [x] Gamification (streaks, leaderboards)

### 🚧 In Progress (v1.1)

- [ ] Sleep tracking integration
- [ ] Apple Health / Google Fit sync
- [ ] Wearable device integration (Fitbit, Apple Watch)
- [ ] Social features (share progress with friends)
- [ ] Meal photo recognition (AI food detection)
- [ ] Custom workout plans
- [ ] Medication reminders
- [ ] Doctor appointment scheduling

### 🔮 Future (v2.0)

- [ ] Blood glucose monitoring (for diabetics)
- [ ] Heart rate variability (HRV) tracking
- [ ] Stress detection via biometrics
- [ ] Pregnancy tracking mode
- [ ] Family account management
- [ ] Health report generation (PDF export)
- [ ] Telemedicine integration
- [ ] Prescription tracking
- [ ] Insurance claim assistance
- [ ] Multilevel ML models (LSTM for time-series)
- [ ] Federated learning (privacy-preserving ML)
- [ ] Blockchain for health records (optional)

### 💡 Ideas Under Consideration

- AR/VR guided workouts
- Mental health therapy chatbot
- Nutrition coach with meal suggestions
- Water quality tracking
- Air quality alerts
- UV index warnings
- Community challenges
- Health expert Q&A forum

**Want to see a feature?** [Open an issue](https://github.com/yourusername/nova-health/issues/new) and tell us!

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024-2026 NovaHealth Team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---

## 🙏 Acknowledgments

### Technologies & Frameworks

- **[Flutter](https://flutter.dev)** - Google's UI toolkit for beautiful cross-platform apps
- **[FastAPI](https://fastapi.tiangolo.com)** - Modern Python web framework for ML serving
- **[PyTorch](https://pytorch.org)** - Deep learning framework
- **[TabNet](https://github.com/dreamquark-ai/tabnet)** - Interpretable tabular ML architecture
- **[Firebase](https://firebase.google.com)** - Authentication and cloud infrastructure
- **[Supabase](https://supabase.com)** - Open-source Firebase alternative
- **[Google Gemini](https://ai.google.dev)** - Conversational AI for health guidance

### Datasets

- **[UCI ML Repository](https://archive.ics.uci.edu/ml/index.php)** - Obesity and menstrual health datasets
- **[Kaggle](https://kaggle.com)** - Exercise and fitness datasets
- **[USDA FoodData Central](https://fdc.nal.usda.gov/)** - Nutrition database

### Inspiration

- Apple Health
- Google Fit
- MyFitnessPal
- Flo Period Tracker
- Headspace

### Contributors

Thanks to all contributors who have helped make NovaHealth better! 🎉

<!-- Add contributor avatars here -->
<!-- ALL-CONTRIBUTORS-LIST:START -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

---

## 📞 Contact & Support

### Get Help

- 📖 **Documentation**: [Read the Docs](https://github.com/yourusername/nova-health/wiki)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/yourusername/nova-health/discussions)
- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/yourusername/nova-health/issues)
- 📧 **Email**: support@novahealth.app (not active yet)

### Community

- 🌐 **Website**: [www.novahealth.app](https://novahealth.app) (coming soon)
- 🐦 **Twitter**: [@NovaHealthApp](https://twitter.com/NovaHealthApp) (coming soon)
- 📱 **Discord**: [Join our Discord](https://discord.gg/novahealth) (coming soon)

### Maintainers

This project is actively maintained by:

- **Lead Developer**: [@yourusername](https://github.com/yourusername)
- **ML Engineer**: [@yourusername](https://github.com/yourusername)
- **UI/UX Designer**: [@yourusername](https://github.com/yourusername)

---

## 📊 Project Stats

![GitHub repo size](https://img.shields.io/github/repo-size/yourusername/nova-health)
![GitHub code size](https://img.shields.io/github/languages/code-size/yourusername/nova-health)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/yourusername/nova-health)
![GitHub last commit](https://img.shields.io/github/last-commit/yourusername/nova-health)
![GitHub issues](https://img.shields.io/github/issues/yourusername/nova-health)
![GitHub pull requests](https://img.shields.io/github/issues-pr/yourusername/nova-health)

---

<div align="center">

### Made with ❤️ by the NovaHealth Team

**NovaHealth: Your AI-Powered Health Companion**

[⬆ Back to Top](#-novahealth)

</div>
