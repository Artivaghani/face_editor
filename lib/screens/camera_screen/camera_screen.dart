import 'dart:io';
import 'package:face_editor/model/info_model.dart';
import 'package:face_editor/utils/config_packages.dart';

class CemeraScreen extends StatelessWidget {
  const CemeraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CemeraCOntroller(),
        builder: (controller) {
          return (controller.imageFile == null)
              ? Scaffold(
                  body: Center(
                      child: Text(AppString.retackByTaping).asButton(
                  onTap: () => controller.getImageFromCamera(),
                )))
              : Scaffold(
                  appBar: AppWidgets.appBar(
                      [
                        Image.asset(AppImages.menuItem)
                            .paddingAll(AppDimen.dimen20)
                      ],
                      const Icon(
                        Icons.close,
                        color: AppColors.secondaryColor,
                      )),
                  body: Column(
                    children: [
                      Expanded(
                        child: Screenshot(
                          controller: controller.screenshotController,
                          child: Stack(
                            children: [
                              selectedImage(controller.imageFile!.path),
                              ...controller.stickerList
                                  .map<Widget>((e) =>
                                      appliedSticker(controller, context, e))
                                  .toList()
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppDimen.dimen160,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.back,
                                  height: AppDimen.dimen26,
                                ),
                                Text(
                                  AppString.reTack,
                                  style: Get.theme.textTheme.headlineLarge,
                                ).paddingOnly(left: AppDimen.dimen10)
                              ],
                            ).asButton(
                                onTap: () => controller.getImageFromCamera()),
                            if (controller.faceLength == 1)
                              Row(
                                children: [
                                  getItemView(AppString.minView).asButton(
                                      onTap: () =>
                                          controller.addSticker(AppImages.eye)),
                                  getItemView(AppString.maxView)
                                      .paddingOnly(left: AppDimen.dimen10)
                                      .asButton(
                                          onTap: () => controller
                                              .addSticker(AppImages.mouth))
                                ],
                              ).paddingOnly(top: AppDimen.dimen20)
                          ],
                        ).paddingAll(AppDimen.dimen20),
                      )
                    ],
                  ),
                  bottomNavigationBar: controller.faceLength != 1
                      ? null
                      : ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  controller.stickerList.isEmpty
                                      ? AppColors.terneryColor
                                      : AppColors.purpleColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppDimen.dimen10),
                              ))),
                          onPressed: () => controller.saveImage(),
                          child: Text(
                            AppString.save,
                            style: Get.theme.textTheme.headlineLarge,
                          )).paddingAll(AppDimen.dimen20),
                );
        });
  }

  Widget getItemView(String title) => Container(
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(AppDimen.dimen10)),
        padding: EdgeInsets.all(AppDimen.dimen20),
        child: Text(
          title,
          style: Get.theme.textTheme.headlineSmall,
        ),
      );

  Widget selectedImage(String img) => Image.file(
        File(
          img,
        ),
        fit: BoxFit.fill,
        width: AppDimen.screenWidth,
        height: double.infinity,
      );

  appliedSticker(
      CemeraCOntroller controller, BuildContext context, StickerInfo e) {
    return Positioned(
      left: e.left,
      top: e.top,
      child: Draggable(
          feedback: StickerImg(img: e.path),
          child: StickerImg(img: e.path),
          onDragEnd: (drag) => controller.updatePosition(context, drag, e)),
    );
  }
}
