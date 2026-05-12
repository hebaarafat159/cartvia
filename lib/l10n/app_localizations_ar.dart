import 'package:cartvia_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AppLocalizationsAr extends AppLocalizations {
  const AppLocalizationsAr() : super(const Locale('ar'));

  @override
  String get appTitle => 'كارت ڤيا';

  @override
  String get profileInitial => 'س';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get chooseShoppingList => 'اختر قائمة تسوق';

  @override
  String get shoppingListDropdownHint => 'حدد قائمة تسوق';

  @override
  String get noShoppingListsAvailable => 'لا توجد قوائم تسوق متاحة.';

  @override
  String get selectShoppingListToViewProducts =>
      'حدد قائمة تسوق لعرض منتجاتها.';

  @override
  String get noProductsAvailableForShoppingList =>
      'لا توجد منتجات متاحة في قائمة التسوق هذه.';

  @override
  String get addShoppingListTooltip => 'إضافة قائمة تسوق';

  @override
  String get addProductTooltip => 'إضافة منتج';

  @override
  String get languageToggleTooltip => 'تبديل اللغة';

  @override
  String get switchToEnglish => 'الإنجليزية';

  @override
  String get switchToArabic => 'العربية';

  @override
  String shoppingListItemsTitle(String listTitle) => 'عناصر قائمة $listTitle';

  @override
  String unableToLoadShoppingList(String errorDetails) =>
      'تعذر تحميل قائمة التسوق.\n$errorDetails';
}
