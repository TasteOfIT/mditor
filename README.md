# mditor

A markdown editor

### Syntax ref

- [Daring Fireball](https://daringfireball.net/projects/markdown/)
- [Common Mark](https://spec.commonmark.org/])
- [Markdown Guide](https://www.markdownguide.org/)
- [Github flavored markdown](https://github.github.com/gfm/)

### Setup

- Flutter 3.0+(with Dart)
- Android Studio
- Xcode
    - Install from Apple Store
    - `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer`
    - `sudo xcodebuild -runFirstLaunch`
    - `sudo gem install cocoapods`
- Before compile, run `flutter pub get`
- flutter intl plugin
    - [Guide](https://localizely.com/blog/flutter-localization-step-by-step/?tab=automated-using-flutter-intl)
- flutter launcher icons
    1. Update `assets/icon/launcher*.png`, no transparent for ios
    2. `flutter pub get`
    3. Run `flutter pub run icons_launcher:main`
