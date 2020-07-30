// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home_page {
    return Intl.message(
      'Home',
      name: 'home_page',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get shopping_cart {
    return Intl.message(
      'Cart',
      name: 'shopping_cart',
      desc: '',
      args: [],
    );
  }

  /// `Mine`
  String get mine {
    return Intl.message(
      'Mine',
      name: 'mine',
      desc: '',
      args: [],
    );
  }

  /// `RegisterUser`
  String get register_user {
    return Intl.message(
      'RegisterUser',
      name: 'register_user',
      desc: '',
      args: [],
    );
  }

  /// `Please Input Username`
  String get please_input_username {
    return Intl.message(
      'Please Input Username',
      name: 'please_input_username',
      desc: '',
      args: [],
    );
  }

  /// `Please Input Password`
  String get please_input_password {
    return Intl.message(
      'Please Input Password',
      name: 'please_input_password',
      desc: '',
      args: [],
    );
  }

  /// `Please Again Confirm Password`
  String get please_again_confirm_password {
    return Intl.message(
      'Please Again Confirm Password',
      name: 'please_again_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forget_password {
    return Intl.message(
      'Forget Password',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `New User Register`
  String get new_user_register {
    return Intl.message(
      'New User Register',
      name: 'new_user_register',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `AddCart`
  String get add_to_cart {
    return Intl.message(
      'AddCart',
      name: 'add_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contact {
    return Intl.message(
      'Contact',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get go_to_bug {
    return Intl.message(
      'Buy',
      name: 'go_to_bug',
      desc: '',
      args: [],
    );
  }

  /// `Recommend For You`
  String get recommend_for_you {
    return Intl.message(
      'Recommend For You',
      name: 'recommend_for_you',
      desc: '',
      args: [],
    );
  }

  /// `Not More`
  String get more_load_end {
    return Intl.message(
      'Not More',
      name: 'more_load_end',
      desc: '',
      args: [],
    );
  }

  /// `Load Fail, Click Retry`
  String get more_load_error {
    return Intl.message(
      'Load Fail, Click Retry',
      name: 'more_load_error',
      desc: '',
      args: [],
    );
  }

  /// `Release Refresh`
  String get release_the_refresh {
    return Intl.message(
      'Release Refresh',
      name: 'release_the_refresh',
      desc: '',
      args: [],
    );
  }

  /// `Refreshing`
  String get is_pull_refreshing {
    return Intl.message(
      'Refreshing',
      name: 'is_pull_refreshing',
      desc: '',
      args: [],
    );
  }

  /// `Refresh End`
  String get fresh_end {
    return Intl.message(
      'Refresh End',
      name: 'fresh_end',
      desc: '',
      args: [],
    );
  }

  /// `Refresh Fail`
  String get fresh_fail {
    return Intl.message(
      'Refresh Fail',
      name: 'fresh_fail',
      desc: '',
      args: [],
    );
  }

  /// `Pull To Refresh`
  String get pull_to_fresh {
    return Intl.message(
      'Pull To Refresh',
      name: 'pull_to_fresh',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Recommend`
  String get recommend {
    return Intl.message(
      'Recommend',
      name: 'recommend',
      desc: '',
      args: [],
    );
  }

  /// `AllCheck`
  String get all_check {
    return Intl.message(
      'AllCheck',
      name: 'all_check',
      desc: '',
      args: [],
    );
  }

  /// `count`
  String get count {
    return Intl.message(
      'count',
      name: 'count',
      desc: '',
      args: [],
    );
  }

  /// `Total Price:`
  String get total_price {
    return Intl.message(
      'Total Price:',
      name: 'total_price',
      desc: '',
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
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}