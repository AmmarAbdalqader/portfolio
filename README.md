# 🚀 Ammar AbdAl-Qader — Flutter Web Portfolio

A professional, animated portfolio web app built entirely with Flutter.

---

## ✨ Features
- **Dark / Light theme toggle** with smooth animated switch
- **Animated Hero section** — typewriter effect, rotating avatar ring, pulse glow
- **Timeline Experience section** — expandable bullet points, company logos
- **Filterable Projects grid** — filter by category (FinTech, Enterprise, etc.)
- **Skills section** — logo grid + proficiency bars + architecture patterns
- **Certificates section** — Huawei HCIA certs with verification numbers
- **Contact section** — links + mailto form
- **Subtle grid background** with glow blobs
- **Fully responsive** — mobile, tablet, desktop

---

## 📁 Assets You Need to Add

Place your images in the correct paths:

### `assets/images/`
| File | Description |
|---|---|
| `profile.png` | Your professional photo (square, min 400×400) |

### `assets/logos/`
| File | Description |
|---|---|
| `ard_logo.png` | Ard Group company logo |
| `awael_logo.png` | Awael Technologies logo |
| `flutter.png` | Flutter logo (from flutter.dev brand assets) |
| `dart_logo.png` | Dart language logo |
| `firebase_logo.png` | Firebase logo |
| `sqlserver_logo.png` | Microsoft SQL Server logo |
| `mysql_logo.png` | MySQL logo |
| `git_logo.png` | Git logo |
| `expressjs_logo.png` | Express.js logo |
| `dotnet_logo.png` | .NET / ADO.NET / EF Core logo |
| `api_logo.png` | REST API icon (any clean API icon) |

> **All logos render gracefully** — if a logo file is missing, the app shows a styled letter fallback. So you can add logos gradually.

---

## 🚀 Running the App

### Prerequisites
```bash
flutter --version  # Requires Flutter 3.10+
```

### Install dependencies
```bash
flutter pub get
```

### Run on web
```bash
flutter run -d chrome
```

### Build for production
```bash
flutter build web --release
# Output in: build/web/
```

### Deploy
Upload the `build/web/` folder to:
- **Firebase Hosting**: `firebase deploy`
- **Netlify**: Drag-and-drop `build/web/`
- **GitHub Pages**: Push `build/web/` to `gh-pages` branch
- **Vercel**: Import repo and set output to `build/web`

---

## 📝 Customizing Your Projects

Edit `lib/models/portfolio_data.dart` — find the `projects` list and add your apps:

```dart
Project (
  title: 'My App Name',
  description: 'A brief description of what this app does...',
  category: 'FinTech',  // Shows in filter tabs
  tech: ['Flutter', 'Firebase', 'BLoC'],
  playStoreUrl: 'https://play.google.com/store/apps/details?id=com.yourapp',
  appStoreUrl: 'https://apps.apple.com/app/id123456789',
  githubUrl: 'https://github.com/AmmarAbdalqader/your-repo',
  emoji: '💳',
),
```

---

## 🎨 Theming

Colors are defined in `lib/theme/app_theme.dart` — adjust accent colors, background, etc.

Key colors:
- `accent` — `#00D4FF` (cyan blue)
- `accentGlow` — `#0066FF` (deep blue)
- `accentSecondary` — `#7C3AED` (purple)
- `accentGreen` — `#00E5B0` (teal green)

---

## 📦 Dependencies

| Package | Use |
|---|---|
| `flutter_animate` | Smooth enter animations |
| `animated_text_kit` | Typewriter role text |
| `google_fonts` | Orbitron + Space Grotesk fonts |
| `provider` | Theme state management |
| `url_launcher` | Open links / mailto |
| `visibility_detector` | Scroll-triggered animations |
| `smooth_page_indicator` | Page dots |

---

Made with 💙 Flutter by **Ammar AbdAl-Qader**