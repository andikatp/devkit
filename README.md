# DevKit

[![Dart & Flutter CI](https://github.com/andikatp/devkit/actions/workflows/flutter_ci.yml/badge.svg)](https://github.com/andikatp/devkit/actions/workflows/flutter_ci.yml)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

A cyber-themed developer toolkit built with Flutter for Android device management, wireless ADB debugging, real-time Logcat streaming, and automated permissions setup.

## Features

- **DevKit Dashboard (Home)**: Quick action toggles, wireless connection command card, recent actions tracker, and status header.
- **Logcat**: Real-time logcat streaming with level filtering, search capabilities, and live stream control.
- **Tools**: Essential developer utility shortcuts, system toggles, and device configuration tools.

## Getting Started

### Prerequisites

- Flutter SDK (stable channel)
- Java 17

### Installation

```bash
flutter pub get
flutter run
```

### Running Tests

To run permissions feature unit & widget tests:

```bash
flutter test test/features/permissions
```
