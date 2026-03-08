# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Vai Raja Vai (வை ராஜா வை) — a Flutter mobile app for splitting money in card games among friends. Tracks rounds, calculates gain/loss, and generates who-pays-whom settlement reports. Uses Isar as a local NoSQL database. No internet required, no ads. Targets Android and iOS only.

## Build & Development Commands

```bash
# Get dependencies
flutter pub get

# Run the app (debug)
flutter run

# Build APK (Android)
flutter build apk

# Build iOS
flutter build ios

# Run code generation (required after modifying Isar model annotations)
dart run build_runner build

# Run static analysis
flutter analyze

# Run tests
flutter test

# Run a single test file
flutter test test/widget_test.dart
```

## Architecture

Three-layer architecture with no external state management:

**Screens** (`lib/screens/`) → **Widgets** (`lib/widgets/`) → **IsarService** (`lib/models/isar_service.dart`) → **Isar DB**

- **State management**: Isar's built-in `.watch()` streams drive reactive UI updates directly — no Provider, BLoC, or Riverpod.
- **Navigation**: Standard `Navigator.push()`/`pop()` with parameter passing. No named routes or router package.
- **Data models** (`lib/models/`): `Game`, `Round`, `RoundEntry`, `Player`, `Setting`. Models use Isar annotations; `Round` and `RoundEntry` are embedded types within `Game`.
- **IsarService** (`lib/models/isar_service.dart`): Single data access class handling all CRUD operations, stream queries, and game auto-closure logic.
- **Settlement logic**: The gain/loss and who-pays-whom calculation lives in `lib/screens/settlement_screen.dart`.

## Code Generation

Isar model files (`game.dart`, `player.dart`, `setting.dart`) have corresponding `.g.dart` generated files. After changing any `@collection` or `@embedded` annotations, regenerate with:

```bash
dart run build_runner build
```

## Lint Configuration

- Uses `flutter_lints` package
- `prefer_const_constructors` is disabled
- See `analysis_options.yaml`

## Key Dependencies

- **isar** (3.1.0+1) — local NoSQL database
- **intl** — date/time formatting
- **flutter_native_splash** — splash screen (red background #FF5252)
- **flutter_launcher_icons** — app icon generation
- **url_launcher** — opening external URLs
