import 'dart:io';

import 'package:face_editor/dialogs/app_dialogs.dart';
import 'package:face_editor/model/info_model.dart';
import 'package:face_editor/utils/app_utils.dart';
import 'package:face_editor/utils/config_packages.dart';
import 'package:flutter/foundation.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CemeraCOntroller extends GetxController {
  XFile? imageFile;
  final faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions());
  ScreenshotController screenshotController = ScreenshotController();
  int faceLength = 0;

  List<StickerInfo> stickerList = [];

  @override
  void onInit() {
    getImageFromCamera();
    super.onInit();
  }

  updatePosition(BuildContext context, DraggableDetails drag, StickerInfo e) {
    int index = stickerList.indexOf(e);
    final renderBox = context.findRenderObject() as RenderBox;
    Offset off = renderBox.globalToLocal(drag.offset);
    stickerList[index].top = off.dy - 96;
    stickerList[index].left = off.dx;

    update();
  }

  Future<void> getImageFromCamera() async {
    faceLength = 0;
    stickerList = [];
    final ImagePicker picker = ImagePicker();
    imageFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 90);
    update();
    if (imageFile != null) {
      checkFaces();
    }
  }

  Future<void> checkFaces() async {
    try {
      final InputImage inputImage = InputImage.fromFile(File(imageFile!.path));
      final List<Face> faces = await faceDetector.processImage(inputImage);
      faceLength = faces.length;
      update();
      if (faceLength > 1) {
        Appdialogs.showSnackBar(AppString.twoOrMoreFaceDetected);
      } else if (faceLength != 1) {
        Appdialogs.showSnackBar(AppString.noFaceDetected);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  addSticker(String path) {
    stickerList.add(StickerInfo(
        path: path, top: AppDimen.dimen300, left: AppDimen.dimen210));
    update();
  }

  saveImage() {
    if (stickerList.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) async {
        await saveImageTOGallery(image!);
        Appdialogs.showSnackBar(AppString.imgDownlodedMsg,
            bMargin: AppDimen.dimen700);
      }).catchError((err) {
        debugPrint(err.toString());
      });
    }
  }

  Future<void> saveImageTOGallery(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "${AppString.appName}_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }
}
