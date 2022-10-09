// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Mditor`
  String get appName {
    return Intl.message(
      'Mditor',
      name: 'appName',
      desc: 'The application name',
      args: [],
    );
  }

  /// `Hi, I am {name}`
  String hello(Object name) {
    return Intl.message(
      'Hi, I am $name',
      name: 'hello',
      desc: 'A welcome message',
      args: [name],
    );
  }

  /// `No notes`
  String get noNotes {
    return Intl.message(
      'No notes',
      name: 'noNotes',
      desc: 'A hint when notebook is empty',
      args: [],
    );
  }

  /// `Open drawer on the left to create or select a notebook`
  String get addNotebookHint {
    return Intl.message(
      'Open drawer on the left to create or select a notebook',
      name: 'addNotebookHint',
      desc: 'A help message to create notebook',
      args: [],
    );
  }

  /// `Click the floating button in the lower right corner to create your first note`
  String get addNoteHint {
    return Intl.message(
      'Click the floating button in the lower right corner to create your first note',
      name: 'addNoteHint',
      desc: 'A help message to create note',
      args: [],
    );
  }

  /// `New note`
  String get addNote {
    return Intl.message(
      'New note',
      name: 'addNote',
      desc: 'Add note label',
      args: [],
    );
  }

  /// `Welcome`
  String get home {
    return Intl.message(
      'Welcome',
      name: 'home',
      desc: 'Home title',
      args: [],
    );
  }

  /// `Notebooks`
  String get notebooks {
    return Intl.message(
      'Notebooks',
      name: 'notebooks',
      desc: 'Label of notebooks',
      args: [],
    );
  }

  /// `New notebook`
  String get addNotebook {
    return Intl.message(
      'New notebook',
      name: 'addNotebook',
      desc: 'Label of add notebook',
      args: [],
    );
  }

  /// `Edit notebook`
  String get editNotebook {
    return Intl.message(
      'Edit notebook',
      name: 'editNotebook',
      desc: 'Label of edit notebook',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: 'Label of delete',
      args: [],
    );
  }

  /// `Do you want to delete "{name}"?`
  String deleteConfirmMessage(Object name) {
    return Intl.message(
      'Do you want to delete "$name"?',
      name: 'deleteConfirmMessage',
      desc: 'Confirm message of delete',
      args: [name],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: 'Label of view',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: 'Label of edit',
      args: [],
    );
  }

  /// `Rename`
  String get rename {
    return Intl.message(
      'Rename',
      name: 'rename',
      desc: 'Label of rename',
      args: [],
    );
  }

  /// `Rename note`
  String get renameNote {
    return Intl.message(
      'Rename note',
      name: 'renameNote',
      desc: 'Label of rename note',
      args: [],
    );
  }

  /// `Move to notebook`
  String get moveTo {
    return Intl.message(
      'Move to notebook',
      name: 'moveTo',
      desc: 'Label of moveTo',
      args: [],
    );
  }

  /// `No notebooks`
  String get noNotebooks {
    return Intl.message(
      'No notebooks',
      name: 'noNotebooks',
      desc: 'Message: no notebooks',
      args: [],
    );
  }

  /// `Click the add button to create your first notebook`
  String get noNotebooksHint {
    return Intl.message(
      'Click the add button to create your first notebook',
      name: 'noNotebooksHint',
      desc: 'Message: no notebooks help message',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'Label of settings',
      args: [],
    );
  }

  /// `Start here`
  String get inputHint {
    return Intl.message(
      'Start here',
      name: 'inputHint',
      desc: 'Input hint for general editor',
      args: [],
    );
  }

  /// `Untitled`
  String get nameInputHint {
    return Intl.message(
      'Untitled',
      name: 'nameInputHint',
      desc: 'Input hint for name editor',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
