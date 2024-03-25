import 'package:flutter/material.dart';

class FontNames {
  static const String mulish = 'Mulish';
}

class LetterSpacing {
  static const double percent1 = 0;
  static const double percent2 = 0.5;
  static const double percent3 = 1;
}

class CustomFontWeight {
  static const FontWeight normal = FontWeight.normal;
  static const FontWeight semibold = FontWeight.w500;
  static const FontWeight bold = FontWeight.bold;
}

class CustomTypography {
//============================================================
// ** Headlines **
//============================================================

  static const TextStyle h1 =
      TextStyle(fontSize: 40, fontWeight: CustomFontWeight.bold, fontFamily: FontNames.mulish, letterSpacing: LetterSpacing.percent3);
  static const TextStyle h2 =
      TextStyle(fontSize: 34, fontWeight: CustomFontWeight.bold, fontFamily: FontNames.mulish, letterSpacing: LetterSpacing.percent3);
  static const TextStyle h3 =
      TextStyle(fontSize: 30, fontWeight: CustomFontWeight.bold, fontFamily: FontNames.mulish, letterSpacing: LetterSpacing.percent3);
  static const TextStyle h4 =
      TextStyle(fontSize: 26, fontWeight: CustomFontWeight.bold, fontFamily: FontNames.mulish, letterSpacing: LetterSpacing.percent3);
  static const TextStyle h5 =
      TextStyle(fontSize: 22, fontWeight: CustomFontWeight.bold, fontFamily: FontNames.mulish, letterSpacing: LetterSpacing.percent3);

//============================================================
// ** Body Bold **
//============================================================

  static const TextStyle bodySubtitleBold =
      TextStyle(fontSize: 22, fontWeight: CustomFontWeight.bold, fontFamily: FontNames.mulish, letterSpacing: LetterSpacing.percent1);
  static const TextStyle body1Bold =
      TextStyle(fontSize: 20, fontWeight: CustomFontWeight.bold, fontFamily: FontNames.mulish, letterSpacing: LetterSpacing.percent1);
  static const TextStyle body2Bold =
      TextStyle(fontSize: 18, fontWeight: CustomFontWeight.bold, fontFamily: FontNames.mulish, letterSpacing: LetterSpacing.percent1);
  static const TextStyle body3Bold =
      TextStyle(fontSize: 16, fontWeight: CustomFontWeight.bold, fontFamily: FontNames.mulish, letterSpacing: LetterSpacing.percent1);

//============================================================
// ** Body SemiBold **
//============================================================

  static const TextStyle bodySubtitleSemiBold =
      TextStyle(fontSize: 22, fontWeight: CustomFontWeight.semibold, fontFamily: FontNames.mulish, letterSpacing: LetterSpacing.percent1);

//============================================================
// ** Body Medium (Normal) **
//============================================================

  static const TextStyle body1 =
      TextStyle(fontSize: 20, fontWeight: CustomFontWeight.normal, fontFamily: FontNames.mulish, letterSpacing: LetterSpacing.percent1);
  static const TextStyle body2 =
      TextStyle(fontSize: 18, fontWeight: CustomFontWeight.normal, fontFamily: FontNames.mulish, letterSpacing: LetterSpacing.percent1);
  static const TextStyle body3 =
      TextStyle(fontSize: 16, fontWeight: CustomFontWeight.normal, fontFamily: FontNames.mulish, letterSpacing: LetterSpacing.percent1);
  static const TextStyle body4 =
      TextStyle(fontSize: 14, fontWeight: CustomFontWeight.normal, fontFamily: FontNames.mulish, letterSpacing: LetterSpacing.percent1);

}
