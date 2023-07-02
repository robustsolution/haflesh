import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hafleh/common/values/colors.dart';
import 'package:the_hafleh/common/values/custom_text_style.dart';
import 'package:the_hafleh/common/widgets/image_placeholder_button.dart';

class ProfilePhotos extends StatefulWidget {
  final List<dynamic> profileImages;
  final Function onChange;

  const ProfilePhotos(
      {super.key, required this.profileImages, required this.onChange});
  @override
  _ProfilePhotosState createState() => _ProfilePhotosState();
}

class _ProfilePhotosState extends State<ProfilePhotos> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> images = widget.profileImages;

    return Column(
      children: [
        const SizedBox(height: 28),
        SizedBox(
          height: 124,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ImagePlaceholderButton(
                    image: images[0],
                    onDelete: () {
                      // onDelete(0);
                    },
                    onPressed: (e) {
                      // onImageButtonClicked(e, 0);
                    }),
              ),
              const SizedBox(width: 17),
              Expanded(
                  flex: 1,
                  child: ImagePlaceholderButton(
                      image: images[1],
                      onDelete: () {
                        // onDelete(1);
                      },
                      onPressed: (e) {
                        // onImageButtonClicked(e, 1);
                      })),
              const SizedBox(width: 17),
              Expanded(
                  flex: 1,
                  child: ImagePlaceholderButton(
                      image: images[2],
                      onDelete: () {
                        // onDelete(2);
                      },
                      onPressed: (e) {
                        // onImageButtonClicked(e, 2);
                      }))
            ],
          ),
        ),
        const SizedBox(height: 17),
        SizedBox(
          height: 124,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ImagePlaceholderButton(
                    image: images[3],
                    onDelete: () {
                      // onDelete(3);
                    },
                    onPressed: (e) {
                      // onImageButtonClicked(e, 3);
                    }),
              ),
              const SizedBox(width: 17),
              Expanded(
                  flex: 1,
                  child: ImagePlaceholderButton(
                      image: images[4],
                      onDelete: () {
                        // onDelete(4);
                      },
                      onPressed: (e) {
                        // onImageButtonClicked(e, 4);
                      })),
              const SizedBox(width: 17),
              Expanded(
                  flex: 1,
                  child: ImagePlaceholderButton(
                      image: images[5],
                      onDelete: () {
                        // onDelete(5);
                      },
                      onPressed: (e) {
                        // onImageButtonClicked(e, 5);
                      }))
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text("Tap to edit,drag to reorder",
            textAlign: TextAlign.center,
            style: CustomTextStyle.getDescStyle(
                Theme.of(context).colorScheme.onSurface)),
        const SizedBox(height: 24),
        SizedBox(
          // width: 361,
          height: 62,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/star.svg",
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Container(
                  height: 62,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: ShapeDecoration(
                    color: const Color(0x0C9D9D9D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: SizedBox(
                          child: Text(
                            'Videos bring your profile to life, giving others a better sense of who you are :)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFF95F80),
                              fontSize: 14,
                              fontFamily: 'Noto Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
