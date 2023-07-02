import 'package:flutter/material.dart';
import 'package:the_hafleh/common/widgets/custom_radio_group.dart';

List<String> genders = [
  'Man',
  'Woman',
  'Other',
];

class GendersChoose extends StatefulWidget {
  final String? gender;
  // final bool visible;
  final Function onChange;
  // final Function onVisibilityChange;
  const GendersChoose({
    super.key,
    this.gender,
    // required this.visible,
    required this.onChange,
    // required this.onVisibilityChange
  });

  @override
  _GendersChooseState createState() => _GendersChooseState();
}

class _GendersChooseState extends State<GendersChoose> {
  String option = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomRadioGroup(
            value: widget.gender, options: genders, onChanged: widget.onChange),
      ],
    );
  }
}
