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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'Login button label',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: 'Label for email input field',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'Label for password input field',
      args: [],
    );
  }

  /// `Please enter your email`
  String get enterEmail {
    return Intl.message(
      'Please enter your email',
      name: 'enterEmail',
      desc: 'Validation message shown when email field is empty',
      args: [],
    );
  }

  /// `Invalid email format`
  String get invalidEmail {
    return Intl.message(
      'Invalid email format',
      name: 'invalidEmail',
      desc: 'Validation message shown when the email format is invalid',
      args: [],
    );
  }

  /// `Please enter your password`
  String get enterPassword {
    return Intl.message(
      'Please enter your password',
      name: 'enterPassword',
      desc: 'Validation message shown when password field is empty',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get shortPassword {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'shortPassword',
      desc: 'Validation message shown when password is too short',
      args: [],
    );
  }

  /// `Don't have an account? Register`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account? Register',
      name: 'dontHaveAccount',
      desc: 'Prompt shown below login form to redirect users to register',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: 'Register button label',
      args: [],
    );
  }

  /// `Please enter your name`
  String get enterName {
    return Intl.message(
      'Please enter your name',
      name: 'enterName',
      desc: 'Validation message shown when name field is empty',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: 'Label for name input field',
      args: [],
    );
  }

  /// `Already have an account? Login`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? Login',
      name: 'alreadyHaveAccount',
      desc: 'Prompt shown below register form to redirect users to login',
      args: [],
    );
  }

  /// `Registered successfully! Please login.`
  String get registeredSuccessfully {
    return Intl.message(
      'Registered successfully! Please login.',
      name: 'registeredSuccessfully',
      desc: 'Message shown when registration is successful',
      args: [],
    );
  }

  /// `Available Cars`
  String get homeTitle {
    return Intl.message(
      'Available Cars',
      name: 'homeTitle',
      desc: 'Title shown on the home screen listing cars',
      args: [],
    );
  }

  /// `Tap to buy this car`
  String get clickToBuy {
    return Intl.message(
      'Tap to buy this car',
      name: 'clickToBuy',
      desc: 'Label for a button or prompt to buy a car',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
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
