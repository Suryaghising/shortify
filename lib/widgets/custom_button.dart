import 'package:flutter/material.dart';

import '../utils/responsive_text.dart';
import '../utils/util.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onPressed, required this.backgroundColor});

  final Function()? onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              backgroundColor),
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(
                  vertical: kVerticalMargin / 2))),
      child: const ResponsiveText(
        'Shorten URL',
        textColor: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
      onPressed: onPressed,
    );
  }
}
