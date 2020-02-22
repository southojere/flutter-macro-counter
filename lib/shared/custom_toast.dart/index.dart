import 'dart:async';

import 'package:flutter/material.dart';
import 'package:macro_counter_app/shared/custom_toast.dart/toast_animation.dart';
// https://medium.com/@Mak95/how-to-make-custom-toast-messages-in-flutter-9799ef3239b7

enum ToastType {
  complete,
  error,
}

class ToastUtils {
  static Timer toastTimer;
  static OverlayEntry _overlayEntry;

  static void showCustomToast(
    BuildContext context,
    String message,
    Icon icon,
    ToastType type,
  ) {
    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntry = createOverlayEntry(context, message, icon, type);
      Overlay.of(context).insert(_overlayEntry);
      toastTimer = Timer(Duration(seconds: 2), () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
        }
      });
    }
  }

  static OverlayEntry createOverlayEntry(
    BuildContext context,
    String message,
    Icon icon,
    ToastType type,
  ) {
    return OverlayEntry(
        builder: (context) => Positioned(
              top: 50.0,
              width: MediaQuery.of(context).size.width - 20,
              left: 10,
              child: ToastMessageAnimation(Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 10),
                  decoration: BoxDecoration(
                      color: type == ToastType.error
                          ? Color(0xffe53e3f)
                          : Color(0xff007E33),
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        icon,
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ));
  }
}
