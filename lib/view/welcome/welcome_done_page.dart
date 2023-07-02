import 'package:flutter/material.dart';
import 'package:the_hafleh/common/values/colors.dart';
import 'package:the_hafleh/common/values/custom_text_style.dart';
import 'package:the_hafleh/common/widgets/button.dart';
import 'package:the_hafleh/view/invite/invite_friend_page.dart';

class WelcomeDonePage extends StatelessWidget {
  const WelcomeDonePage({
    super.key,
  });

  static Page<void> page() =>
      const MaterialPage<void>(child: WelcomeDonePage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const WelcomeDonePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.background,
        body: Stack(children: [
          SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                "assets/images/1.png",
                fit: BoxFit.cover,
              )),
          Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(251, 104, 94, 0.82),
                      Color.fromRGBO(247, 84, 162, 0.82),
                    ],
                    stops: [
                      0,
                      1
                    ]),
              ),
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        const SizedBox(
                          height: 61,
                        ),
                        Image.asset(
                          "assets/icons/done.png",
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Well done!",
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.getHeaderStyle(
                              Theme.of(context).colorScheme.secondary, 40),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "The app will be available soon",
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.getTitleStyle(
                              Theme.of(context).colorScheme.secondary),
                        ),
                        const SizedBox(
                          height: 72,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(children: [
                                Container(
                                  height: 80,
                                  padding: const EdgeInsets.all(16),
                                  decoration: ShapeDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "09",
                                    style: CustomTextStyle.getHeaderStyle(
                                        Theme.of(context).colorScheme.secondary,
                                        44,
                                        FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Days",
                                  style: CustomTextStyle.getDescStyle(
                                      Theme.of(context).colorScheme.secondary,
                                      16,
                                      FontWeight.w700),
                                )
                              ]),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: Column(children: [
                                Container(
                                  height: 80,
                                  padding: const EdgeInsets.all(16),
                                  decoration: ShapeDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "23",
                                    style: CustomTextStyle.getHeaderStyle(
                                        Theme.of(context).colorScheme.secondary,
                                        44,
                                        FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Hours",
                                  style: CustomTextStyle.getDescStyle(
                                      Theme.of(context).colorScheme.secondary,
                                      16,
                                      FontWeight.w700),
                                )
                              ]),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: Column(children: [
                                Container(
                                  height: 80,
                                  padding: const EdgeInsets.all(16),
                                  decoration: ShapeDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "59",
                                    style: CustomTextStyle.getHeaderStyle(
                                        Theme.of(context).colorScheme.secondary,
                                        44,
                                        FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Min",
                                  style: CustomTextStyle.getDescStyle(
                                      Theme.of(context).colorScheme.secondary,
                                      16,
                                      FontWeight.w700),
                                )
                              ]),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: Column(children: [
                                Container(
                                  height: 80,
                                  padding: const EdgeInsets.all(16),
                                  decoration: ShapeDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "44",
                                    style: CustomTextStyle.getHeaderStyle(
                                        Theme.of(context).colorScheme.secondary,
                                        44,
                                        FontWeight.w700),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Sec",
                                  style: CustomTextStyle.getDescStyle(
                                      Theme.of(context).colorScheme.secondary,
                                      16,
                                      FontWeight.w700),
                                )
                              ]),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(children: <Widget>[
                          Expanded(
                              child: Button(
                                  title: "NOTIFY ME ABOUT RELEASE",
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push<void>(InviteFriendPage.route());
                                  })),
                        ]),
                        const SizedBox(height: 16),
                        Row(children: <Widget>[
                          Expanded(
                              child: Button(
                                  title: "INVITE MORE PEOPLE",
                                  outlined: true,
                                  onPressed: () {})),
                        ]),
                        const SizedBox(height: 50),
                      ],
                    )
                  ]))
        ]));
  }
}
