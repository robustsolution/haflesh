import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hafleh/common/values/colors.dart';
import 'package:pressable/pressable.dart';

class ImagePlaceholderButton extends StatelessWidget {
  final Function onPressed;
  final Function onDelete;
  final dynamic image;

  ImagePlaceholderButton(
      {this.image, required this.onPressed, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    List<String> options = ['Choose From library', 'Take Photo'];

    return Pressable.opacity(
      onPressed: () {
        if (image == null) {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => CupertinoActionSheet(
                actions: options
                    .map((e) => CupertinoActionSheetAction(
                          child: Text(e),
                          onPressed: () {
                            Navigator.pop(context, e);
                            onPressed(e);
                          },
                        ))
                    .toList(),
                cancelButton: CupertinoActionSheetAction(
                  child: const Text('Cancel'),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                )),
          );
        }
      },
      child: Container(
          child: DottedBorder(
              color: image != null
                  ? Colors.transparent
                  : Theme.of(context).colorScheme.primary,
              strokeWidth: 2.5,
              dashPattern: [8, 8],
              padding: EdgeInsets.all(0),
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
              child: Container(
                  height: 110,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      image: (image != null
                          ? (image is ImageProvider
                              ? DecorationImage(
                                  image: image!, fit: BoxFit.cover)
                              : DecorationImage(
                                  image: NetworkImage(image!),
                                  fit: BoxFit.cover))
                          : null)),
                  child: image == null
                      ? Center(
                          child: Container(
                              child: SvgPicture.asset(
                          "assets/icons/attach.svg",
                          fit: BoxFit.cover,
                        )))
                      : Stack(children: [
                          Container(),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                                onTap: () {
                                  onDelete();
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/close.svg",
                                  fit: BoxFit.cover,
                                )),
                          )
                        ])))),
    );
  }
}
