import 'package:flutter/material.dart';

import 'app_colors.dart';


class UtilDialog {
  static showInformation(
      BuildContext context, {
        String? title,
        String? content,
        Function()? onClose,
      }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title ?? "Message for you",
            style: const TextStyle(
              color: kPrimaryColor,
            ),
          ),
          content: Text(content!),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: kSecondaryColor,
              ),
              child: const Text(
                "Close",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: onClose ?? () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  static showWaiting(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 150,
            alignment: Alignment.center,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  static hideWaiting(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<bool?> showConfirmation(
      BuildContext context, {
        String? title,
        required Widget content,
        String confirmButtonText = "Yes",
      }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title ?? "Message for you",
            style: const TextStyle(
              color: kPrimaryColor,
            ),
          ),
          content: content,
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: kSecondaryColor,
              ),
              child: const Text(
                "Close",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: kSecondaryColor,
              ),
              child: Text(
                confirmButtonText,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }
}