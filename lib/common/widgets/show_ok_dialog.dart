// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool?> showOkDialog(
  BuildContext context, {
  String? title,
  String? content,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(content ?? ''),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
