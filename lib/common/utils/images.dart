import 'dart:ui' as ui; // Importing 'ui' class only for its type 'ByteData'
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:the_hafleh/common/values/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

String getPublicPhotoUrl(String path) {
  final supabase = Supabase.instance.client;
  return supabase.storage.from(SupabaseConsts.photoBucket).getPublicUrl(path);
}
