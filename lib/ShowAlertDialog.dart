import 'package:flutter/material.dart';

///Alert dialog for displaying issues that appear within the application
showAlertDialog(BuildContext context, String reason) {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    ///display the reason for the error
    content: Text("Reason: $reason"),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
