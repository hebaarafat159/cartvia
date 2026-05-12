import 'package:cartvia_project/l10n/app_localizations_ar.dart';
import 'package:cartvia_project/l10n/app_localizations_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class AppLocalizations {
  const AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    final localizations = Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );
    assert(localizations != null, 'AppLocalizations not found in context.');
    return localizations!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const localizationsDelegates = [
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  String get appTitle;
  String get profileInitial;
  String get retry;
  String get chooseShoppingList;
  String get shoppingListDropdownHint;
  String get noShoppingListsAvailable;
  String get selectShoppingListToViewProducts;
  String get noProductsAvailableForShoppingList;
  String get shareListAction;
  String get notifyChangesAction;
  String get addShoppingListTooltip;
  String get addProductTooltip;
  String get languageToggleTooltip;
  String get switchToEnglish;
  String get switchToArabic;
  String shoppingListItemsTitle(String listTitle);
  String unableToLoadShoppingList(String errorDetails);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales.any(
        (supportedLocale) =>
            supportedLocale.languageCode == locale.languageCode,
      );

  @override
  Future<AppLocalizations> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'ar':
        return const AppLocalizationsAr();
      case 'en':
      default:
        return const AppLocalizationsEn();
    }
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
