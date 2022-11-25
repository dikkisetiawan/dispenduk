import 'package:flutter/material.dart';

import '../theme.dart';

class InfoLayananWidget extends StatelessWidget {
  const InfoLayananWidget({
    Key? key,
    required this.layananDipilih,
  }) : super(key: key);

  final String layananDipilih;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Anda Memilih Layanan \n$layananDipilih',
      style: greenTextStyle,
    );
  }
}
