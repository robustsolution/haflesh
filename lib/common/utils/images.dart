import 'dart:io';
import 'dart:ui' as ui; // Importing 'ui' class only for its type 'ByteData'
import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
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

Future<String> updateFile(
    int uid, bool type, String filename, File file) async {
  String typePath = type == true ? "media" : "thumbnail";
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child('user/$uid/$typePath/$filename');
  UploadTask uploadTask = ref.putFile(file);
  String url = "";
  uploadTask.whenComplete(() async {
    url = await ref.getDownloadURL();
  }).catchError((err) {
    debugPrint(err.toString());
  });
  return url;
}
