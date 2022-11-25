import 'package:flutter/material.dart';
import '../theme.dart';

class KtitleWidget extends StatelessWidget {
  final String title;
  final Color? color;
  const KtitleWidget(
    this.title, {
    Key? key,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackTextStyle.copyWith(color: color),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
