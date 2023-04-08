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
- Run `git submodule update --init --recursive` to checkout all submodule packages
- Before compile, run `flutter pub get`
- flutter intl plugin
    - Helper for localization
    - [Guide](https://localizely.com/blog/flutter-localization-step-by-step/?tab=automated-using-flutter-intl)
- flutter launcher icons
    1. Update `assets/icon/launcher*.png`, no transparent for ios
    2. `flutter pub get`
    3. Run `flutter pub run icons_launcher:create`

### BLoC - Business Logic Components

> Here `bloc` stands for a design pattern, and a flutter state management library.
> A design pattern presented by Paolo Soares and Cong hui, from Google at the DartConf 2018.
> A flutter state management library created and maintained by Felix Angelo.

- [Theory of BLoC](https://medium.com/flutter-community/reactive-programming-streams-bloc-6f0d2bd2d248)
- [bloc lib](https://bloclibrary.dev/#/gettingstarted)
- [flutter bloc](https://github.com/felangel/bloc/blob/master/packages/flutter_bloc/README.md)
- [Cubit vs Bloc](https://bloclibrary.dev/#/coreconcepts?id=cubit-vs-bloc)
- [Architecture](https://bloclibrary.dev/#/architecture)

> Compared to MVVM, BLoC is the ViewModel, who handles the logics

### Modular

> A dependency injection and routes framework
> [Developer guide](https://modular.flutterando.com.br/docs/flutter_modular/start)
