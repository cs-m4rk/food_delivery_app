import 'package:flutter/material.dart';

class DividerRow extends StatelessWidget {
  const DividerRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(child: Divider())
      ],
    );
  }
}
