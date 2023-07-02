// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:hafleh/common/values/colors.dart';

class BioInput extends StatefulWidget {
  final String bio;
  final Function onChange;
  const BioInput({
    super.key,
    required this.bio,
    required this.onChange,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BioInputState createState() => _BioInputState();
}

class _BioInputState extends State<BioInput>
    with AutomaticKeepAliveClientMixin<BioInput> {
  final TextEditingController _bioEditingController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _bioEditingController.text = widget.bio;
  }

  @override
  void dispose() {
    _bioEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: new BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          border: new Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: new BorderRadius.circular(15.0)),
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _bioEditingController,
        maxLength: 200,
        maxLines: 10,
        decoration: const InputDecoration(
          hintText: "My name is ...",
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        // keyboardType: TextInputType.text,
        // inputFormatters: [LengthLimitingTextInputFormatter(120)],
        style: const TextStyle(color: ThemeColors.onSecondary, fontSize: 15),
        onChanged: (value) {
          widget.onChange(value);
        },
      ),
    );
  }
}
