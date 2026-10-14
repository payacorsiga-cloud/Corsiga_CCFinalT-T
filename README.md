# TrikeFlow – Digital Management System

TrikeFlow is a beginner-friendly Flutter app for managing tricycles, drivers,
routes, and vehicle status. It includes a fleet dashboard, search and status
filters, add/edit/delete forms, and current weather from Open-Meteo.

## Run the app

1. Install Flutter and set up an Android emulator or connect a device.
2. In this project folder, run:

   ```sh
   flutter pub get
   flutter run
   ```

3. Run checks with:

   ```sh
   flutter analyze
   flutter test
   ```

The Weather tab needs an internet connection. On Android, the app requests
internet access through the permission in
`android/app/src/main/AndroidManifest.xml`.

## Fleet data

Sample tricycle records appear when the app starts. New, edited, or deleted
records are kept in memory only and reset when the app restarts. Permanent
database storage is not included in this school project.

## Main files

- `lib/main.dart` sets up the app and colors.
- `lib/models/tricycle.dart` describes a tricycle and sample records.
- `lib/pages/` contains navigation and app screens.
- `lib/services/weather_service.dart` requests and reads Open-Meteo weather.
- `lib/widgets/` contains reusable fleet and dashboard cards.
