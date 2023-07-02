// ignore_for_file: unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:pressable/pressable.dart';
import 'package:hafleh/common/values/custom_text_style.dart';
import './prompt_select_page.dart';

class PromptInput extends StatefulWidget {
  final List<String> prompts;
  final List<String> answers;
  final Function onChangePrompts;
  final Function onChangeAnswers;
  const PromptInput({
    super.key,
    required this.prompts,
    required this.answers,
    required this.onChangePrompts,
    required this.onChangeAnswers,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PromptInputState createState() => _PromptInputState();
}

class _PromptInputState extends State<PromptInput>
    with AutomaticKeepAliveClientMixin<PromptInput> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        SizedBox(
            child: DottedBorder(
          color: Theme.of(context).colorScheme.primary,
          strokeWidth: 1,
          dashPattern: widget.prompts[0] != "" ? [1, 0] : [10, 6],
          borderType: BorderType.RRect,
          radius: const Radius.circular(20),
          padding: const EdgeInsets.all(0),
          child: Pressable.opacity(
            onPressed: () {
              Navigator.of(context).push<void>(MaterialPageRoute(
                builder: (context) => PromptSelectPage(
                    prompt: widget.prompts[0], answer: widget.answers[0]),
              ));
            },
            child: SizedBox(
              height: 120,
              width: double.infinity,
              child: widget.prompts[0] != ""
                  ? Stack(children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(
                                  widget.prompts[0],
                                  style: CustomTextStyle.getTitleStyle(
                                      Theme.of(context).colorScheme.onSecondary,
                                      16,
                                      FontWeight.w700),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(
                                  widget.answers[0],
                                  style: CustomTextStyle.getTitleStyle(
                                      Theme.of(context).colorScheme.onSecondary,
                                      16,
                                      FontWeight.w400),
                                ),
                              ),
                            ]),
                      ),
                      Positioned(
                        right: -2.5,
                        top: 0,
                        child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "assets/icons/close.svg",
                              fit: BoxFit.fitWidth,
                            )),
                      )
                    ])
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Select a prompt',
                          style: TextStyle(
                            color: Color(0xFF828282),
                            fontSize: 16,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        SvgPicture.asset("assets/icons/add.svg"),
                      ],
                    ),
            ),
          ),
        )),
        const SizedBox(height: 12),
        SizedBox(
            child: DottedBorder(
          color:
              Theme.of(context).colorScheme.primary, //color of dotted/dash line
          strokeWidth: 1, //thickness of dash/dots
          dashPattern: const [10, 6],
          borderType: BorderType.RRect,
          radius: const Radius.circular(20),
          child: Pressable.opacity(
            onPressed: () {
              // Navigator.of(context).push<void>(PromptSelectPage.route());
            },
            child: SizedBox(
              height: 120,
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Select a prompt',
                    style: TextStyle(
                      color: Color(0xFF828282),
                      fontSize: 16,
                      fontFamily: 'Noto Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset("assets/icons/add.svg"),
                ],
              ),
            ),
          ),
        )),
        const SizedBox(height: 12),
        SizedBox(
            child: DottedBorder(
          color:
              Theme.of(context).colorScheme.primary, //color of dotted/dash line
          strokeWidth: 1, //thickness of dash/dots
          dashPattern: const [10, 6],
          borderType: BorderType.RRect,
          radius: const Radius.circular(20),
          child: Pressable.opacity(
            onPressed: () {
              // Navigator.of(context).push<void>(PromptSelectPage.route());
            },
            //inner container
            child: SizedBox(
              height: 120,
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Select a prompt',
                    style: TextStyle(
                      color: Color(0xFF828282),
                      fontSize: 16,
                      fontFamily: 'Noto Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset("assets/icons/add.svg"),
                ],
              ),
            ),
          ),
        )),
        const SizedBox(height: 34),
        SizedBox(
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
                            'We recommend you fill in all 3 prompts to find a match quicker',
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
