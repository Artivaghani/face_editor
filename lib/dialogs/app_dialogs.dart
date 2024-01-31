import 'package:face_editor/utils/config_packages.dart';

class Appdialogs {
  static showSnackBar(String msg, {double? bMargin}) {
    return ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          dismissDirection: DismissDirection.up,
          content: Container(
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(AppDimen.dimen10)),
            padding: EdgeInsets.all(AppDimen.dimen20),
            child: Text(
              msg,
              textAlign: TextAlign.center,
              style: Get.theme.textTheme.headlineLarge,
            ),
          ).paddingOnly(bottom: bMargin ?? AppDimen.dimen800)),
    );
  }
}
