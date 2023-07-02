// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:the_hafleh/common/values/colors.dart';
import './prompt_anwer_page.dart';
import 'package:pressable/pressable.dart';

class CustomSelectElement extends StatefulWidget {
  final String value;
  const CustomSelectElement({
    super.key,
    required this.value,
  });

  @override
  _CustomSelectElementState createState() => _CustomSelectElementState();
}

class _CustomSelectElementState extends State<CustomSelectElement> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Pressable.opacity(
          onPressed: () {
            Navigator.of(context).push<void>(MaterialPageRoute(
              builder: (context) => PromptAnswerPage(value: widget.value),
            ));
          },
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        widget.value,
                        style: TextStyle(
                          color: Color(0xFF212325),
                          fontSize: 20,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.40,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
