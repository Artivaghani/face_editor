import 'package:face_editor/utils/config_packages.dart';

class AppTheme {
  static final dark = ThemeData.light().copyWith(
      primaryColor: AppColors.secondaryColor,
      scaffoldBackgroundColor: AppColors.primaryColor,
      iconTheme: const IconThemeData(color: AppColors.secondaryColor),
      cardColor: AppColors.secondaryColor,
      hintColor: AppColors.terneryColor,
      dividerColor: AppColors.terneryColor,
      textTheme: TextTheme(
        headlineLarge: getTextStyle(AppColors.secondaryColor, FontDimen.dimen12,
            fontWeight: FontWeight.w700),
        headlineSmall: getTextStyle(AppColors.primaryColor, FontDimen.dimen12,
            fontWeight: FontWeight.w400),
      ));
}

TextStyle getTextStyle(Color color, double size, {FontWeight? fontWeight}) =>
    TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
      letterSpacing: 0.3,
      height: 1.2,
    );
