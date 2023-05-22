import 'dart:ui';
import 'package:flutter/material.dart';

class InformDialog extends StatelessWidget {
  VoidCallback continueCallBack;

  InformDialog(this.continueCallBack);
  TextStyle textStyle = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        title: new Text(
          "Belge Doğrulama",
          style: textStyle,
        ),
        content: new Text(
          "Belgenizde bulunan 12 haneli belge kodunu eksiksiz bir şekilde 'belge kodu' alanına girerek sorgulama yapabilirsiniz. ",
          style: textStyle,
        ),
        actions: <Widget>[
          new ElevatedButton(
            child: new Text("Tamam"),
            onPressed: () {
              continueCallBack();
            },
          ),
        ],
      ),
    );
  }
}
