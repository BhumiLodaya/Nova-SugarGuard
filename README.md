# 🍬 NovaHealth – Beat the Sugar Spike  
### Real-Time, Context-Aware Nudges for Healthier Choices

NovaHealth is an AI-powered, cross-platform health intelligence platform designed to reduce sugar-related health risks through real-time behavioral nudges.

Built for the **“Beat the Sugar Spike” Hackathon**, NovaHealth combines:

- ⚡ 10-second sugar logging  
- 🧠 Context-aware AI insights  
- 🎯 Immediate corrective micro-actions  
- 🎮 Gamified daily habit loop  
- 🔒 Privacy-first anonymous onboarding  

Powered by **Flutter + FastAPI + TabNet Neural Networks**.

---

# 🌍 Vision

To make preventive health simple, addictive, and accessible — starting with everyday sugar habits.

---

# 🎯 Mission

Transform passive sugar consumption into active awareness using:

- Instant feedback  
- Personalized nudges  
- Behavioral psychology  
- Machine learning  

---

# 👥 Target Audience

- Students (16–25)
- Young professionals (22–32)
- Fitness beginners
- Users who dislike calorie-heavy apps
- People who want micro-improvements, not extreme dieting

---

# 🚨 The Problem

Young users frequently consume sugary drinks and snacks without understanding:

- Short-term energy crashes
- Focus reduction
- Sleep disruption
- Long-term metabolic risk

Existing health apps:
- Overwhelm users with calorie data
- Focus only on weight loss
- Require excessive manual input
- Lack real-time behavioral feedback

Result:
No awareness → No action → No habit change.

---

# 💡 Our Behavioral Feedback Loop

NovaHealth builds a micro-habit loop:

**Log → Understand → Act → Reward → Repeat**

Instead of fear-based health messaging,
we provide:

- Immediate insight
- One small corrective action
- Instant reward
- Streak protection

---

# 🚀 Hackathon Requirement Coverage

## ✅ 1. Fast Sugar Logging (<10 seconds)

Quick presets:

- ☕ Chai  
- 🥤 Cold Drink  
- 🍰 Sweets  
- 🍫 Snack  

Optional:
- 🎙 Voice logging
- 📸 Photo logging (extendable)

No friction. No calorie search.

---

## ✅ 2. Anonymous Gamified Onboarding

- Device-based ID
- No email required
- Single-question screens
- Silent BMI calculation
- Progress tracker

Feels like leveling up in a game.

---

## ✅ 3. Passive Data Integration

With permission:

- Step count
- Sleep hours
- Heart rate

Used only for insight personalization.
Raw numbers are never exposed.

---

## ✅ 4. Context-Aware Insight Engine

After every sugar log:

Example:

> “On low-sleep days like today, sugar may reduce focus later.”

Generated using:
- Age
- BMI category
- Sleep data
- Steps today
- Time of day

---

## ✅ 5. Personalized Corrective Action

Each sugar event triggers ONE action:

- 🚶 Walk 10 minutes
- 💧 Drink water
- 🥜 Swap to protein snack
- 🧘 Light stretch

Completed within 30 minutes → Bonus XP 🎉

---

## ✅ 6. Gamification Engine

Includes:

- Daily streaks
- XP rewards (3–10 variable)
- Milestone unlocks
- Progress bar
- Achievement badges
- Success animations
- Sound-based micro-rewards

Inspired by Duolingo habit design.

---

# 🧠 Behavioral Psychology Applied

| Principle | Implementation |
|------------|----------------|
| Loss Aversion | Streak protection |
| Instant Gratification | Immediate animation |
| Variable Rewards | Random XP bonus |
| Commitment | Signup after value |
| Habit Loop | Daily reminder |

Target emotion:

> “This is easy. I want to open it again tomorrow.”

---

# 🤖 Machine Learning System

## TabNet Neural Networks (PyTorch)

| Model | Metric | Score |
|-------|--------|--------|
| Obesity Risk | Accuracy | 95.93% |
| Exercise Calories | R² | 0.9980 |
| Menstrual Health | Accuracy | 91.06% |

### ML Features

- Lazy model loading
- Memory optimized for 512MB servers
- ~50–100ms inference time
- REST API based deployment

---

## 🍬 Sugar Insight API

POST `/predict/sugar-insight`

```json
{
  "shortTermImpact": "~40g sugar may spike glucose within 15 minutes.",
  "correctiveAction": "5-minute stair climb can blunt the spike."
}
