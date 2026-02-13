# 🍬 NovaHealth – Beat the Sugar Spike  
### Real-Time, Context-Aware Nudges for Healthier Choices

NovaHealth is an AI-powered, cross-platform health application built for the **“Beat the Sugar Spike” Hackathon**.

It helps young users reduce sugar-related health risks through:

- ⚡ 10-second sugar logging  
- 🧠 Context-aware AI insights  
- 🎯 Immediate corrective actions  
- 🎮 Gamified daily habit loop  
- 🔒 Signup-free anonymous onboarding  

Built with **Flutter + FastAPI + TabNet Neural Networks**, NovaHealth transforms sugar tracking into a fast, fun, and addictive daily ritual.

---

# 🎯 Problem

Young users (ages 16–32) frequently consume sugary drinks and snacks without tracking or understanding their short-term impact.

Most health apps:
- Focus only on long-term goals
- Require too much data upfront
- Make logging too complex

NovaHealth solves this by creating a **real-time feedback loop**:

**Log → Understand → Act → Get Reward → Repeat**

---

# 🚀 Core Hackathon Features

## ⚡ Fast, Frictionless Sugar Logging (<10 Seconds)

Users log sugar instantly using:

- ☕ Chai  
- 🥤 Cold Drink  
- 🍰 Sweets  
- 🍫 Packaged Snack  

Optional:
- 🎙 Voice-based logging  
- 📸 Photo-based logging  

No calorie forms. No friction. Just tap and log.

---

## 👤 Signup-Free Gamified Onboarding

- Device-based anonymous ID
- No email required to start
- One question per screen:
  - Age
  - Height
  - Weight
  - Gender
- BMI calculated silently (never explicitly shown)
- Progress indicator (“3 of 5 completed”)

Feels like a game, not a form.

---

## 📡 Passive Health Data Sync

With permission, NovaHealth uses:

- Step count
- Sleep duration
- Heart rate (if available)

Important:
- Raw biometric numbers are never shown
- Data is used only for smarter contextual insights

---

## 🧠 Context-Aware Insight Engine (ML-Based)

After every sugar log, NovaHealth generates:

- Simple, non-medical insight
- Cause → Effect format
- Personalized explanation based on:
  - Age
  - BMI category
  - Steps today
  - Sleep hours
  - Time of day

Example:

> “On low-sleep days like today, sugar may reduce your focus later.”

Powered by:
- FastAPI backend
- TabNet neural networks
- Rule-based personalization engine

---

## 🎯 Personalized Corrective Action

Each sugar event triggers ONE immediate action:

- 🚶 10-minute walk  
- 💧 Drink water  
- 🥜 Protein snack swap  
- 🧘 Light stretch  

Rules:
- Only one primary action
- Must be doable immediately
- Context-adaptive

Complete within 30 minutes → Bonus XP awarded 🎉

---

## 🎮 Gamified Scoring System

Built using behavioral psychology principles:

- Daily streaks (Day 1, 3, 7, 30)
- Variable XP rewards (3–10 points)
- Bonus for logging before 6 PM
- Bonus for completing action within 30 minutes
- Milestone celebrations
- Visual progress bar
- Success animations + sound feedback

---

## 🔁 Daily Ritual Loop

Every day users see:

🔥 **“Log today to protect your streak”**

Inspired by habit-forming platforms like Duolingo.

Goal: Make sugar logging a daily micro-habit.

---

## 🔓 Optional Value-First Signup

Upgrade only after receiving value.

Unlocks:
- Cross-device sync
- Deeper insights
- Advanced personalization
- Extra rewards

Never forced. Always optional.

---

# 🧠 Behavioral Psychology Framework

NovaHealth applies:

| Principle | Implementation |
|------------|----------------|
| Loss Aversion | Streak protection |
| Instant Gratification | Immediate animation + sound |
| Variable Rewards | Random XP bonuses |
| Commitment | Signup only after value |
| Habit Formation | Daily ritual loop |

Target user feeling:

> “This is fast, fun, and something I want to do every day.”

---

# 🤖 AI & Machine Learning

## TabNet Neural Networks (PyTorch)

| Model | Metric | Score |
|-------|--------|--------|
| Obesity Risk | Accuracy | 95.93% |
| Exercise Calories | R² | 0.9980 |
| Menstrual Health | Accuracy | 91.06% |

Optimized for 512MB RAM deployment.

---

## 🍬 Sugar Insight API

Endpoint:
POST `/predict/sugar-insight`

Example Response:

```json
{
  "shortTermImpact": "~40g liquid sugar may spike glucose within 15 minutes.",
  "correctiveAction": "A quick 5-minute stair climb can blunt the spike."
}
git clone https://github.com/your-repo-link.git
cd nova-health
flutter pub get
flutter run
