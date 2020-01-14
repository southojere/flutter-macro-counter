import 'package:flutter/material.dart';

enum DialogAction { yes, abort }

class Dialogs {
  static Future<DialogAction> yesAbortDialog(
      BuildContext ctx, String title, String body) async {
    final action = await showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (BuildContext builder) {
          return AlertDialog(
            title: Text(title),
            content: Text(body),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.of(ctx).pop(DialogAction.abort),
              ),
              RaisedButton(
                onPressed: () => Navigator.of(ctx).pop(DialogAction.yes),
                child: Text('Yes'),
              )
            ],
          );
        });
        return (action != null) ? action : DialogAction.abort;
  }
}
