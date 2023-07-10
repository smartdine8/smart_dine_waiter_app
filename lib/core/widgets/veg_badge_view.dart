import 'package:flutter/material.dart';

class VegBadgeView extends StatelessWidget {
  final bool isVeg;
  const VegBadgeView({Key? key, required this.isVeg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      height: 15.0,
      width: 15.0,
      decoration: BoxDecoration(
        border:
            Border.all(color: isVeg ? Colors.green[800]! : Colors.red[800]!),
      ),
      child: ClipOval(
        child: Container(
          height: 5.0,
          width: 5.0,
          color: isVeg ? Colors.green[800]! : Colors.red[800]!,
        ),
      ),
    );
  }
}
