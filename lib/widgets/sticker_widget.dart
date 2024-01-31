import 'package:face_editor/utils/config_packages.dart';

class StickerImg extends StatelessWidget {
  final String img;
  const StickerImg({
    Key? key,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      img,
    );
  }
}
