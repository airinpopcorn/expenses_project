import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final VoidCallback handler;

  const AdaptiveFlatButton(this.text, this.handler, {super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(
              text,
            ),
          )
        : TextButton(
            onPressed: handler,
            child: Text(
              text,
            ),
          );
  }
}
