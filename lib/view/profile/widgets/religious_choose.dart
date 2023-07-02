import 'package:flutter/material.dart';
import 'package:the_hafleh/common/widgets/custom_radio_group.dart';

class ReligiousChoose extends StatefulWidget {
  final String? religious;
  final Function onChange;
  const ReligiousChoose({
    super.key,
    this.religious,
    required this.onChange,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ReligiousChooseState createState() => _ReligiousChooseState();
}

class _ReligiousChooseState extends State<ReligiousChoose> {
  @override
  Widget build(BuildContext context) {
    final List<String> religiouses = [
      'Agnostic',
      'Atheist',
      'Gay',
      'Buddist',
      'Christian',
      'Hindu',
      'Jewish',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomRadioGroup(
            value: widget.religious,
            options: religiouses,
            onChanged: widget.onChange),
      ],
    );
  }
}
