import 'package:cartvia_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AppLocalizationsEn extends AppLocalizations {
  const AppLocalizationsEn() : super(const Locale('en'));

  @override
  String get appTitle => 'CartVia';

  @override
  String get profileInitial => 'S';

  @override
  String get retry => 'Retry';

  @override
  String get chooseShoppingList => 'Choose a shopping list';

  @override
  String get shoppingListDropdownHint => 'Select a shopping list';

  @override
  String get noShoppingListsAvailable => 'No shopping lists available.';

  @override
  String get selectShoppingListToViewProducts =>
      'Select a shopping list to view its products.';

  @override
  String get noProductsAvailableForShoppingList =>
      'No products available for this shopping list.';

  @override
  String get addShoppingListTooltip => 'Add shopping list';

  @override
  String get addProductTooltip => 'Add product';

  @override
  String get languageToggleTooltip => 'Switch language';

  @override
  String get switchToEnglish => 'English';

  @override
  String get switchToArabic => 'Arabic';

  @override
  String shoppingListItemsTitle(String listTitle) => '$listTitle list items';

  @override
  String unableToLoadShoppingList(String errorDetails) =>
      'Unable to load shopping list.\n$errorDetails';
}
