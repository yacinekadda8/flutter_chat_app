import 'package:flutter/material.dart';

import '../../constants.dart';

class DividerText extends StatelessWidget {
  const DividerText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding / 2,
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        children: [
          const Divider(
            color: kbodyTextColor,
          ),
          Container(
            padding: const EdgeInsets.all(defaultPadding / 2),
            decoration: BoxDecoration(
              color: thiredColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'or',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                backgroundColor: thiredColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
