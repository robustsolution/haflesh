import 'package:flutter/material.dart';
import 'package:the_hafleh/common/values/colors.dart';
import 'package:the_hafleh/common/values/custom_text_style.dart';

class SubscriptionCard extends StatelessWidget {
  List<String> features = [
    'Unlimited slides',
    'Video calling',
    'Ability to unsend messages',
    'Ability to return to previous user\'s profile'
  ];

  SubscriptionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.outline,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: features
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 24,
                        color: ThemeColors.onSecondary,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Flexible(
                          child: Text(e,
                              softWrap: true,
                              maxLines: 2,
                              style: CustomTextStyle.getSubtitleStyle(
                                  ThemeColors.onSecondary)))
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
