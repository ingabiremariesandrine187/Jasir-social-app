import 'dart:typed_data';

class Post {
  final Uint8List imageData;
  final String caption;

  Post({required this.imageData, required this.caption});
}
