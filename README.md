# Visual Novel Engine

A modern Flutter-based engine for creating visual novels with support for dialogues, choices, backgrounds, and audio.

## 🎮 Features

- **Interactive Dialogues** - Support for character dialogues
- **Choice System** - Multiple story branching paths
- **Background Switching** - Dynamic background image changes
- **Audio System** - Background music and sound effects
- **YAML Scripts** - Simple and readable script format
- **Modern UI** - Beautiful and responsive interface
- **Cross-platform** - Works on all Flutter platforms

## 🚀 Quick Start

### Requirements

- Flutter SDK 3.6.2 or higher
- Dart 3.0 or higher

### Installation

1. Clone the repository:
```bash
git clone https://github.com/nomad-pixel/visual_novel_flutter.git
cd visual_novel_flutter
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart                    # Application entry point
├── constants/                   # Constants and configuration
│   ├── app_colors.dart         # Color palette
│   └── app_constants.dart      # General constants
├── models/                      # Data models
│   ├── game_state.dart         # Game state
│   └── script_nodes.dart       # Script nodes
├── services/                    # Business logic
│   ├── audio_manager.dart      # Audio management
│   ├── script_engine.dart      # Script engine
│   └── script_loader.dart      # Script loading
├── screens/                     # Application screens
│   └── novel_screen.dart       # Main novel screen
├── ui/widgets/                  # UI components
│   ├── background_widget.dart  # Background widget
│   ├── choice_box.dart         # Choice box
│   ├── dialogue_box.dart       # Dialogue box
│   ├── end_screen.dart         # End screen
│   ├── error_screen.dart       # Error screen
│   └── loading_screen.dart     # Loading screen
└── utils/                       # Utilities
    └── decorations.dart        # Decorations and styles
```

## 📝 Creating Scripts

Scripts are written in YAML format. Example:

```yaml
label: intro
nodes:
  - bg: "bg/room_morning.png"
  - music: "audio/soft_morning.mp3"
  - say: { who: "Aki", text: "The alarm didn't ring. Strange." }
  - choice:
      text: "What to do?"
      options:
        - { text: "Go outside", jump: "street" }
        - { text: "Look out the window", jump: "window" }

---
label: street
nodes:
  - bg: "bg/street_empty.jpg"
  - say: { who: "Aki", text: "Empty storefronts, hot air shimmers." }
  - end: true
```

### Supported Nodes

- `bg` - Background change
- `music` - Play music
- `say` - Character dialogue
- `choice` - Player choice
- `jump` - Jump to another scene
- `end` - End the story

## 🎨 Customization

### Colors

Modify colors in `lib/constants/app_colors.dart`:

```dart
class AppColors {
  static const Color primaryBlue = Colors.blue;
  static const Color backgroundDark = Color(0xFF1a1a2e);
  // ... other colors
}
```

### Constants

Configure parameters in `lib/constants/app_constants.dart`:

```dart
class AppConstants {
  static const String appTitle = 'Visual Novel';
  static const String defaultScriptPath = 'assets/scripts/prologue.yaml';
  // ... other constants
}
```

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🛠 Development

### Building for Release

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```


## 📦 Dependencies

- `flutter` - Main framework
- `yaml` - YAML file parsing
- `audioplayers` - Audio playback

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Your Name**
- GitHub: [@nomad-pixel](https://github.com/nomad-pixel)

## 🙏 Acknowledgments

- Flutter team for the excellent framework
- Developer community for inspiration
- All project contributors

---

⭐ If you liked this project, give it a star!