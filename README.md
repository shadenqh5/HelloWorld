# Learning Streak

A SwiftUI app that helps you learn something every day. Set a learning goal, log each day you study, and keep your streak alive with limited freezes.

## Main features

- Set a learning goal (what you want to learn) and choose a duration: week, month, or year
- Log a day as learned from the Activity screen
- Freeze a day to protect your streak. Freezes are limited by duration: 2 per week, 8 per month, 96 per year
- Log and Freeze disable each other for the rest of the day, and both re-enable at 12 AM
- See the current week, your learned days, and your frozen days at a glance
- Open the calendar to view all your learned and frozen days
- Edit your goal at any time. Updating it resets your streak, and the app asks you to confirm first
- Streak resets after more than 32 hours without logging or freezing
- Goal completed and goal failed screens with an option to set a new goal


## Technologies used

- Swift
- SwiftUI
- MVVM architecture (Models, Views, ViewModels)
- Liquid Glass (iOS 26)
- Git and GitHub

## Project structure

- `Models`: `LearningGoal`, `LearningDuration`, `DayStatus`
- `ViewModels`: one per screen (Onboarding, Activity, Learning Goal, Calendar)
- `Views`: screens and reusable pieces (`DayCircle`, `StatCard`, `DurationChip`, `GoalForm`)

## Requirements

- Xcode with iOS 26 SDK
- iPhone simulator or device running iOS 26
