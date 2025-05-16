
import 'package:flutter/material.dart';

Future<void> appShowInfo(
  BuildContext context, {
  String? title,
  String? content,
  bool barrierDismissible = true,
  bool defaultDismissAction = true,
  List<Widget>? actions,
}) async {
  actions ??= [];
  if (defaultDismissAction) {
    actions.add(
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Dismiss",
        ),
      ),
    );
  }

  final alert = AlertDialog.adaptive(
      title: Text(title ?? 'Sorry'),
      content: Text(
        content ?? 'Something went wrong',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      actions: actions);
  await showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//for loading
Future<void> appLoadingDialog(
  BuildContext context, {
  bool barrierDismissible = false,
}) async {
  final alert = AlertDialog.adaptive(
    content: Row(
      children: const [
        CircularProgressIndicator.adaptive(),
        SizedBox(width: 20),
        Text('Please wait...'),
      ],
    ),
  );
  await showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}