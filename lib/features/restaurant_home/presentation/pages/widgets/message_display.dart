import 'package:flutter/material.dart';
import 'package:smartdine_waiter/core/utils/app_theme.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: appPrimaryTheme().textTheme.headline4,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
