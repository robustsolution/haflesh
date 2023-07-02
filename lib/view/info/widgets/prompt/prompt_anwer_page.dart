// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hafleh/common/values/colors.dart';
import 'package:hafleh/common/values/custom_text_style.dart';
import 'package:hafleh/common/widgets/button.dart';

class PromptAnswerPage extends StatefulWidget {
  const PromptAnswerPage({super.key});

  @override
  _PromptAnswerPageState createState() => _PromptAnswerPageState();

  static Page<void> page() =>
      const MaterialPage<void>(child: PromptAnswerPage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const PromptAnswerPage());
}

class _PromptAnswerPageState extends State<PromptAnswerPage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  children: [
                    const SizedBox(height: 48),
                    SvgPicture.asset(
                      "assets/icons/answer.svg",
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 12),
                    Text('Write an answer',
                        style: CustomTextStyle.getTitleStyle()),
                    const SizedBox(height: 12),
                    Text('My friends ask me for advice about',
                        style: CustomTextStyle.getTitleStyle()),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.outline),
                          borderRadius: BorderRadius.circular(15.0)),
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        // controller: _bioEditingController,
                        maxLength: 90,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: "Write your answer here",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(
                            color: ThemeColors.onSecondary, fontSize: 15),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                )),
                Row(children: <Widget>[
                  const SizedBox(width: 8),
                  Expanded(
                      child: Button(
                          title: "BACK",
                          flag: true,
                          outlined: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                          })),
                  const SizedBox(width: 8),
                  Expanded(
                      child:
                          Button(title: "NEXT", flag: true, onPressed: () {})),
                  const SizedBox(width: 8),
                ]),
                const SizedBox(height: 16),
              ],
            )));
  }
}
