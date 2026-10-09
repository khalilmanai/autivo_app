<div align="center">

# 🚗 Autivo

**Smart Vehicle Management & Maintenance Companion**

A polished Flutter app to manage your garage, track maintenance, monitor vehicle health, and explore full vehicle specs — with a racing-inspired design, trilingual UI, and a secure token-based backend.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-^3.11.5-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS-green)](#)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

</div>

---

## 📖 Overview

Autivo helps drivers keep every vehicle in their garage healthy and documented. Add a car in seconds by scanning its **VIN**, log every service with cost and mileage, track the condition of individual **parts**, and browse a full **vehicle catalog** of makes, models, engines, and specifications.

The app talks to a REST API (`/api/v1`) with JWT auth, automatic token refresh, and Google Sign-In, and ships with a fully localized experience in **English, French, and Arabic (RTL)**.

### ✨ Key features

| Area | What it does |
| --- | --- |
| 🏠 **Garage** | Add, edit, and delete vehicles; per-car photos, mileage, VIN, plate, color, engine, and a configurable service interval with a visual "service due" progress indicator. |
| 🔍 **VIN Decode** | Enter a 17-character VIN and get make, model, year, engine, transmission, body class, drivetrain, assembly plant, and EV battery data pre-filled automatically. |
| 🛠️ **Services** | Full maintenance log per vehicle: 11 record types (maintenance, repair, paint & body, accident, fuel, document, inspection, modification, tires, battery, electrical) with cost, mileage, garage, category, notes, parts used, and next-service mileage — plus an **upcoming maintenance** tab. |
| ❤️ **Vehicle health** | Per-part condition tracking (`original`, `replaced`, `serviced`, `worn`, `damaged`) with replacement date and mileage, and a color-coded legend. |
| 📚 **Catalog** | Browse makes → models → specifications, with configurations, engines, transmissions, and EPA class/MPG data. Doubles as a vehicle picker when adding a car. |
| 👤 **Profile & settings** | Edit profile and avatar, change email/password, and set language, distance unit (km/mi), and currency (TND / EUR / USD). |
| 🎨 **Themes** | Three hand-crafted themes — **White**, **Black**, and **Night Owl** — built on a single racing-inspired design-token system. |
| 🔐 **Auth** | Register, login, forgot/reset password, Google Sign-In, and route-level auth guarding with secure on-device token storage. |

---

## 🏗️ Architecture

Autivo follows **Clean Architecture** with a strict one-way dependency flow: `presentation → domain ← data`, wired together by a dependency-injection layer.

```
lib/
├── app/                 # App shell, GoRouter config, theme (design tokens)
├── core/                # config, constants, localization, network, storage, utils, widgets
├── data/                # API data sources, DTO models (json_serializable), repository impls
├── domain/              # Repository interfaces, use cases, entities
├── presentation/        # Views (screens), ViewModels (ChangeNotifier), shared views
├── l10n/                # slang translation sources (en / fr / ar)
├── gen/                 # Generated assets (flutter_gen)
├── di.dart              # GetIt service locator — single composition root
└── main.dart
```

- **State management:** `provider` + `ChangeNotifier` ViewModels
- **Dependency injection:** `get_it` (all wiring lives in `lib/di.dart`)
- **Navigation:** `go_router` with a `ShellRoute` hosting a persistent curved bottom nav, animated page transitions, and an auth redirect guard
- **Networking:** `dio` with an `AuthInterceptor` that transparently refreshes expired access tokens (and force-logs-out on refresh-token reuse), a typed `Result<T>` API, and a global error-code catalog localized into the UI
- **Security:** tokens stored in `flutter_secure_storage` (EncryptedSharedPreferences on Android, Keychain on iOS)
- **Design system:** `app/theme` exposes palette, gradients, typography, spacing, and motion tokens only — never business logic

---

## 🧰 Tech stack

| Concern | Packages |
| --- | --- |
| UI & animation | `flutter`, `flutter_svg`, `lottie`, custom curved nav bar, staggered entrance animations |
| State & DI | `provider`, `get_it` |
| Navigation | `go_router` |
| Networking | `dio` |
| Auth | `google_sign_in` |
| Storage | `flutter_secure_storage`, `shared_preferences` |
| Localization | `slang`, `slang_flutter`, `intl`, `flutter_localizations` (EN / FR / AR, RTL) |
| Codegen | `build_runner`, `json_serializable`, `flutter_gen_runner`, `slang_build_runner` |
| Misc | `equatable`, `image_picker`, `url_launcher` |

---

## 🚀 Getting started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart `^3.11.5`) — run `flutter doctor` to verify your toolchain
- A running instance of the Autivo backend API (`/api/v1`), or point the app at a deployed environment
- Android Studio / Xcode for platform-specific setup (Google Sign-In client IDs, etc.)

### 1. Clone & install

```bash
git clone https://github.com/<your-user>/autivo.git
cd autivo
flutter pub get
```

### 2. Generate code

The project relies on generated code (JSON serializers, assets, translations). Regenerate after changing models, assets, or `.i18n.json` files:

```bash
dart run build_runner build --delete-conflicting-outputs
dart run slang           # translations only, faster
```

> 💡 Tip: add `--watch` to either command during development so generated files rebuild on save.

### 3. Configure the API backend

The base URL is resolved at **compile time** via `--dart-define` (see `lib/core/config/api_config.dart`):

| `ENV` | Base URL |
| --- | --- |
| `dev` *(default)* | `http://192.168.1.21:5000/api/v1` |
| `staging` | `https://staging-api.autivo.com/api/v1` |
| `prod` | `https://api.autivo.com/api/v1` |

You can also override the URL entirely:

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:5000/api/v1
```

> `10.0.2.2` is the Android emulator's alias for `localhost` — use it when the backend runs on your machine.

### 4. Run the app

```bash
flutter run                                  # dev environment
flutter run --dart-define=ENV=staging        # staging
flutter run --dart-define=ENV=prod           # production
```

Release builds:

```bash
flutter build apk --release --dart-define=ENV=prod
flutter build ipa --release --dart-define=ENV=prod
```

---

## ✅ Testing & linting

```bash
flutter test        # unit & widget tests
flutter analyze     # strict lint set (see analysis_options.yaml)
```

The test suite covers VIN decoding (including a guard that fails if the model grows a field the backend doesn't send), the catalog ViewModel, and catalog selection behavior.

---

## 🌍 Localization

Translations live in `lib/l10n/translations/*.i18n.json`, organized by namespace (`auth`, `garage`, `services`, `parts`, `catalog`, `profile`, `common`, `errors`) and generated by `slang` into `strings.g.dart`.

- Base locale: **English (`en`)** — also available: **French (`fr`)** and **Arabic (`ar`)** with full RTL support
- Non-default locales are loaded as **deferred** modules to keep the initial bundle small
- To add a language: create `<namespace>_<code>.i18n.json`, run `dart run slang`, and register the locale

---

## 🔌 Backend API surface

The app expects a REST API under `/api/v1` with these routes:

| Group | Endpoints |
| --- | --- |
| **Auth** | `POST /auth/register`, `POST /auth/login`, `GET /auth/me`, `POST /auth/refresh`, `POST /auth/logout`, `POST /auth/forgot-password`, `POST /auth/reset-password`, `POST /auth/google` |
| **User** | `GET /users/me`, `PATCH /users/me`, `PATCH /users/me/preferences`, `PUT /users/me/email`, `PUT /users/me/password` |
| **Cars** | `GET/POST /cars`, `GET/PATCH/DELETE /cars/:id`, `POST /cars/decode-vin` |
| **Parts** | `GET /cars/:carId/parts`, `PUT/DELETE /cars/:carId/parts/:partId` |
| **Maintenance** | `GET/POST /cars/:carId/maintenance`, `GET/PATCH/DELETE /cars/:carId/maintenance/:id` |
| **Catalog** | `GET /vehicles/{makes,models,years,configurations,engines,transmissions,specs}` |
| **Health** | `GET /health` |

Auth uses bearer JWTs with an access/refresh token pair; the client handles refresh automatically and maps server error codes (e.g. `REFRESH_TOKEN_REUSE_DETECTED`) to localized messages.

---

## 🗺️ Roadmap

- [ ] Push notifications for upcoming service reminders
- [ ] Fuel & expense analytics dashboard
- [ ] Document storage (insurance, registration, inspections)
- [ ] Offline-first caching
- [ ] Tablet & web layouts

Contributions and ideas are welcome — open an issue or a PR!

---

## 🤝 Contributing

1. Fork the repo and create your branch: `git checkout -b feature/amazing-feature`
2. Make your changes and keep `flutter analyze` + `flutter test` green
3. Commit using conventional commits: `git commit -m "feat(garage): add fuel log"`
4. Open a Pull Request describing the change and its motivation

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
#   a u t i v o _ a p p  
 