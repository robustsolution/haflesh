import 'dart:ui' as ui; // Importing 'ui' class only for its type 'ByteData'
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

Future<Uint8List> getImageBytes(ImageProvider imageProvider) async {
  final Completer<Uint8List> completer = Completer();
  final ImageStream stream = imageProvider.resolve(ImageConfiguration.empty);
  final listener =
      ImageStreamListener((ImageInfo image, bool synchronousCall) async {
    final ByteData? byteData =
        await image.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    completer.complete(pngBytes);
  });

  stream.addListener(listener);

  return completer.future;
}
