// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hafleh/common/values/custom_text_style.dart';
import 'package:hafleh/common/widgets/image_placeholder_button.dart';
import 'package:hafleh/common/values/colors.dart';
import 'package:hl_image_picker/hl_image_picker.dart';


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
    final _picker = HLImagePicker();
    List<HLPickerItem> _selectedImages = [];

    bool _isCroppingEnabled = true;
    int _count = 4;
    MediaType _type = MediaType.all;
    bool _isExportThumbnail = true;
    bool _enablePreview = false;
    bool _usedCameraButton = true;
    int _numberOfColumn = 3;
    bool _includePrevSelected = false;
    CropAspectRatio? _aspectRatio;
    List<CropAspectRatioPreset>? _aspectRatioPresets;
    double _compressQuality = 0.9;
    CroppingStyle _croppingStyle = CroppingStyle.normal;

    _openCamera() async {
      try {
        final image = await _picker.openCamera(
          cropping: _isCroppingEnabled,
          cameraOptions: HLCameraOptions(
            cameraType:
                _type == MediaType.video ? CameraType.video : CameraType.image,
            recordVideoMaxSecond: 40,
            isExportThumbnail: _isExportThumbnail,
            thumbnailCompressFormat: CompressFormat.jpg,
            thumbnailCompressQuality: 0.9,
          ),
          cropOptions: HLCropOptions(
            aspectRatio: _aspectRatio,
            aspectRatioPresets: _aspectRatioPresets,
            croppingStyle: _croppingStyle,
          ),
        );
        setState(() {
          _selectedImages = [image];
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    _openPicker() async {
      try {
        final images = await _picker.openPicker(
          cropping: _isCroppingEnabled,
          selectedIds: _includePrevSelected
              ? _selectedImages.map((e) => e.id).toList()
              : null,
          pickerOptions: HLPickerOptions(
            mediaType: _type,
            enablePreview: _enablePreview,
            isExportThumbnail: _isExportThumbnail,
            thumbnailCompressFormat: CompressFormat.jpg,
            thumbnailCompressQuality: 0.9,
            recordVideoMaxSecond: 40,
            maxSelectedAssets: _isCroppingEnabled ? 1 : _count,
            usedCameraButton: _usedCameraButton,
            numberOfColumn: _numberOfColumn,
          ),
          cropOptions: HLCropOptions(
            aspectRatio: _aspectRatio,
            aspectRatioPresets: _aspectRatioPresets,
            compressQuality: _compressQuality,
            compressFormat: CompressFormat.jpg,
            croppingStyle: _croppingStyle,
          ),
        );
        setState(() {
          _selectedImages = images;
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    _openCropper() async {
      try {
        if (_selectedImages.isEmpty) {
          return;
        }
        final image = await _picker.openCropper(
          _selectedImages[0].path,
          cropOptions: HLCropOptions(
            aspectRatio: _aspectRatio,
            aspectRatioPresets: _aspectRatioPresets,
            compressQuality: _compressQuality,
            compressFormat: CompressFormat.jpg,
            croppingStyle: _croppingStyle,
          ),
        );
        setState(() {
          _selectedImages = [image];
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    void onImageButtonClicked(String type, int index) async {
      if (type == 'Take Photo') {
        _openCamera();
      } else {
        _openPicker();
      }
      widget.onChange(images);
    }

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
                      onImageButtonClicked(e, 0);
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
