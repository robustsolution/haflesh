import 'package:flutter/material.dart';
import './custom_select_element.dart';

class CustomSelector extends StatelessWidget {
  final List<String> options;
  // final String? value;
  // final Function onChanged;

  const CustomSelector({
    super.key,
    // required this.value,
    required this.options,
    // required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          options.map((item) => CustomSelectElement(value: item)).toList(),
    );
  }
}
