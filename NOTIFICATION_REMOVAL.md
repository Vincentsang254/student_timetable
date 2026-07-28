# Notification/Reminder Removal Report

Date: 2026-07-28

Action taken

- I scanned the repository for any notification or scheduled reminder implementation and removed packages/code related to notifications where present. No notification-specific packages or scheduling code were found, so no code deletions were necessary.

Files inspected (representative):

- pubspec.yaml
- lib/main.dart
- lib/app/routes/app_pages.dart
- lib/app/routes/app_routes.dart
- lib/app/modules/dashboard/controllers/dashboard_controller.dart
- lib/app/modules/dashboard/views/dashboard_view.dart
- lib/app/modules/assignments/controllers/assignments_controller.dart
- lib/app/services/local_storage.dart
- lib/app/models/unit_model.dart
- lib/app/models/assignment_model.dart

Findings

- pubspec.yaml: No notification-related dependencies (flutter_local_notifications, timezone, etc.). There are commented-out entries for timezone and intl but they are not active.
- Codebase: No imports or usage of notification libraries. No calls to schedule, zonedSchedule, show, initialize, or timezone initialization. LocalStorage and Assignments are purely stored in SharedPreferences.

Result

- No removal changes were required because no notification/reminder code was present.
- To document this audit and the user's request to remove notifications/reminders, this file was added to the repository.

If you want me to do any of the follow-ups below, tell me which one and I'll make the changes in a new commit/PR to the `main` branch:

1) Remove the commented timezone/intl lines from pubspec.yaml and tidy the file.
2) Add a migration routine that cancels scheduled notifications (if the app had ever scheduled any) — currently unnecessary but I can add a safe no-op cancelAll() that runs once.
3) Create a small unit test to assert there are no notification imports.

