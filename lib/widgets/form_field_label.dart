import 'package:flutter/material.dart';

class FormFieldLabel extends StatelessWidget {
  const FormFieldLabel({
    super.key,
    required this.title,
    this.isRequired = false,
  });

  final String title;

  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 21 / 14,
            ),
          ),
          if (isRequired)
            const TextSpan(
              text: '* ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w200,
                color: Color(0xffED1C2E),
              ),
            ),
        ],
      ),
    );
  }
}
