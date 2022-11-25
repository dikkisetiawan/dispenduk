import 'package:flutter/material.dart';
import '../theme.dart';

class KtitleWidget extends StatelessWidget {
  final String title;
  const KtitleWidget(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackTextStyle,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
