# Done — Gamified Habit Tracking App

## Overview

**Done** is a modern habit-tracking iOS app built with **SwiftUI**, **Core Data**, and **Firebase Authentication**. The app combines clean UI design with lightweight gamification to help users stay consistent with their habits and visually track progress over time.

Users can create habits, track daily or weekly completion, maintain streaks, and earn GP (Growth Points) for consistency — all while keeping their habit data stored locally and securely on-device.

---

## Features

### Authentication
- Firebase Email/Password Authentication
- User registration and login
- Input validation and error handling
- Automatic login after registration
- Account-specific habit filtering

### Habit Management
- Create custom habits
- Set:
  - Habit name
  - Goal days
  - Daily or weekly frequency
- Automatically sorted by newest habits first
- Persistent local storage using Core Data

### Habit Completion System
- One-tap daily completion
- Visual completion indicators
- Completion history tracking
- Daily reset system
- Stores:
  - Completed dates
  - Missed dates
  - Current day status

### Gamification
- Current streak tracking
- Longest streak tracking
- Total GP accumulation
- Habit consistency visualization

### UI/UX
- Custom splash screen
- Modern SwiftUI interface
- Reusable custom components
- Responsive layouts
- Animated status circles
- Minimalist productivity-focused design

---

## Tech Stack

| Technology | Purpose |
|---|---|
| SwiftUI | Frontend UI framework |
| Core Data | Local persistent storage |
| Firebase Auth | User authentication |
| Swift | App logic |
| Xcode | Development environment |

---

## Architecture

The app follows a compartmentalized structure for easier maintenance and debugging.

### Main Components

```plaintext
Done/
│
├── Views/
│   ├── ContentView.swift
│   ├── LoginView.swift
│   ├── RegisterView.swift
│   ├── HomeView.swift
│   ├── HabitRowView.swift
│   ├── AddHabitView.swift
│
├── Models/
│   ├── Habit.swift
│
├── CoreData/
│   ├── Persistence.swift
│   ├── HabitEntity+CoreDataClass.swift
│   ├── HabitEntity+CoreDataProperties.swift
│
├── Utilities/
│   ├── UIVals.swift
│
└── DoneApp.swift
```

---

## Core Data Model

### HabitEntity

| Attribute | Type |
|---|---|
| habitID | UUID |
| habitName | String |
| goalDays | Int32 |
| daily | String |
| currStreak | Int32 |
| longestStreak | Int32 |
| daysMade | Int32 |
| daysMissed | Int32 |
| totalGP | Int32 |
| userEmail | String |
| statusToday | Boolean |
| completedDates | Transformable ([Date]) |
| incompleteDates | Transformable ([Date]) |
| timestamp | Date |

---

## Installation

### Requirements
- Xcode 15+
- iOS 17+
- CocoaPods or Swift Package Manager
- Firebase project

### Clone the Repository

```bash
git clone https://github.com/yourusername/done.git
cd done
```

### Install Firebase

Add Firebase SDK through Swift Package Manager:

```plaintext
https://github.com/firebase/firebase-ios-sdk
```

Add:
- FirebaseAuth
- FirebaseCore

---

## Firebase Setup

1. Create a Firebase project
2. Enable Email/Password Authentication
3. Download `GoogleService-Info.plist`
4. Add it to the Xcode project
5. Initialize Firebase in `DoneApp.swift`

```swift
FirebaseApp.configure()
```

---

## Running the App

Open the project in Xcode and run:

```bash
⌘ + R
```

---

## Future Improvements

- Cloud sync
- Push notifications
- Widgets
- Habit analytics
- Calendar view
- Social accountability
- Apple Sign In
- Dark mode customization
- Advanced streak logic

---

## Screenshots

### Splash Screen
Minimal branded launch screen with animated transition.

### Authentication
Clean login and registration flow with validation.

### Home View
Scrollable habit dashboard showing:
- Habit names
- Completion history
- Current-day completion
- Streak information
- GP totals

### Add Habit
Custom form for creating habits with:
- Frequency selector
- Goal stepper
- Validation handling

---

## Design Philosophy

Done was built around three core ideas:

1. **Reduce friction**
   - Fast habit creation
   - One-tap completion

2. **Make progress visible**
   - Completion history circles
   - Streaks
   - GP tracking

3. **Keep users motivated**
   - Gamification without overwhelming complexity

---

## License

MIT License

---

## Author

Developed by Rishi Venkat

---
