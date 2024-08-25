import 'package:flutter/material.dart';

class TextRich extends StatelessWidget {
  const TextRich({
    super.key,
    required this.textTheme,
    required this.title,
    required this.subTitle,
    this.commentText,
    this.replayText,
  });

  final TextTheme textTheme;
  final String title;
  final String subTitle;
  final String? commentText;
  final String? replayText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: textTheme.labelLarge,
        children: [
          TextSpan(
            text: subTitle,
            style: textTheme.titleMedium,
          ),
          TextSpan(
            text: commentText,
            style: textTheme.titleMedium,
          ),
          TextSpan(
            text: replayText,
            style: textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
