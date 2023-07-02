import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hafleh/common/values/colors.dart';
import 'package:the_hafleh/common/values/custom_text_style.dart';
import 'package:the_hafleh/common/widgets/button.dart';
import './custom_selector.dart';

List<String> prompts = [
  "I feel most supported when",
  "My cry-in-the-car song is",
  "Therapy recently taught me",
  "When I need advice, I go to",
  "I hype myself up by",
  "My friends ask me for advice about",
  "My self-care routine is",
  "My happy place is",
  "To me,relaxation is",
];

class PromptSelectPage extends StatefulWidget {
  @override
  _PromptSelectPageState createState() => _PromptSelectPageState();

  static Page<void> page() => MaterialPage<void>(child: PromptSelectPage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => PromptSelectPage());
}

class _PromptSelectPageState extends State<PromptSelectPage> {
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
                      "assets/icons/selfcare.svg",
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 12),
                    Text('Select a prompt',
                        style: CustomTextStyle.getTitleStyle()),
                    const SizedBox(height: 24),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            child: CustomSelector(options: prompts)),
                      ),
                    )
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