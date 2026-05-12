import 'package:flutter/material.dart';

abstract final class AppSpacing {
  static const double xSmall = 4;
  static const double small = 6;
  static const double medium = 8;
  static const double regular = 10;
  static const double large = 12;
  static const double xLarge = 16;
  static const double xxLarge = 18;
  static const double xxxLarge = 20;
  static const double section = 24;
  static const double screenGap = 25;
  static const double cardMarginBottom = 15;
  static const double dropdownVertical = 14;

  static const EdgeInsets pagePadding = EdgeInsets.all(xxxLarge);
  static const EdgeInsets dialogPadding = EdgeInsets.all(section);
  static const EdgeInsets listPadding = EdgeInsets.all(xLarge);
  static const EdgeInsets cardPadding = EdgeInsets.all(xLarge);
  static const EdgeInsets featureCardPadding = EdgeInsets.all(xxxLarge);
  static const EdgeInsets listCardPadding = EdgeInsets.all(xxLarge);
  static const EdgeInsetsGeometry toggleLabelPadding =
      EdgeInsetsDirectional.only(end: medium);
  static const EdgeInsetsGeometry dropdownContentPadding =
      EdgeInsetsDirectional.symmetric(
        horizontal: xLarge,
        vertical: dropdownVertical,
      );
  static const EdgeInsets ctaPadding = EdgeInsets.symmetric(
    horizontal: xxLarge,
    vertical: large,
  );
  static const EdgeInsets pillPadding = EdgeInsets.symmetric(
    horizontal: xLarge,
    vertical: regular,
  );
  static const EdgeInsets listCardMargin =
      EdgeInsets.only(bottom: cardMarginBottom);
  static const EdgeInsets buttonTopPadding = EdgeInsets.only(top: xLarge);
  static const EdgeInsetsGeometry dividerIndent =
      EdgeInsetsDirectional.only(start: productContentOffset);
  static const EdgeInsetsGeometry productImagesPadding =
      EdgeInsetsDirectional.only(top: large);

  static const double productContentOffset = 48;
}
