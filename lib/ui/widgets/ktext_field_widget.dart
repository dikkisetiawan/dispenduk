import '/ui/theme.dart';
import 'package:flutter/material.dart';

class KtextFieldWidget extends StatelessWidget {
  final String? title;
  final String hintText;
  final bool obscureText;
  final Widget suffixIcon;
  final TextEditingController? controller;

  const KtextFieldWidget({
    Key? key,
    this.title,
    required this.hintText,
    this.obscureText = false,
    required this.suffixIcon,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: defaultMargin / 3),
                child: Text(
                  title!,
                  style: blackTextStyle.copyWith(
                      letterSpacing: 0.0, fontSize: 18.0),
                ),
              )
            : SizedBox(),
        Container(
          decoration: BoxDecoration(
            color: kDarkGreyColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(defaultCircular),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: greyTextStyle,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
