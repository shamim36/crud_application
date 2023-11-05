import 'package:flutter/material.dart';

MySnackBar(msg, context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
    ),
  );
}

MyAlertDialog(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return Expanded(
          child: AlertDialog(
            title: Text('Alert !'),
            content: Text('Do you want to Delete?'),
            actions: [
              TextButton(
                onPressed: () {
                  MySnackBar('Delete Success', context);
                  Navigator.of(context).pop();

                },
                child: Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'),
              ),
            ],
          ),
        );
      });
}
