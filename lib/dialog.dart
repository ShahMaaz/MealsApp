import 'package:flutter/material.dart';

class MyDialog{

  static Future buildDialog(BuildContext context, String contents){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Icon(
          Icons.check_circle,
          color: Colors.teal,
          size: 50,
        ),
        content: Text(contents + '!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Ok',
            ),
          ),
        ],
      );
    });
  }
}