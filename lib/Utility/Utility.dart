import 'package:crud_application/Screen/ProductCreateScreen.dart';
import 'package:crud_application/Screen/ProductUpdateScreen.dart';
import 'package:flutter/cupertino.dart';
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

  OutlinedButton goToUpdateScreen(context, productItem) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => ProductUpdateScreen(productItem),
          ),
        );
      },
      child: const Icon(
        CupertinoIcons.ellipsis_vertical_circle,
        size: 18,
        color: Colors.green,
      ),
    );
  }

    FloatingActionButton goToCreateScreen(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => ProductCreateScreen(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  
  Text ProductName(context, int index, String value) {
    final productName = value;

    final displayText = productName ?? "null";

    return Text(
      displayText,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Text ProductUnitPrice(context, int index, String value) {
    final productName = value;

    final displayText = productName ?? "null";

    return Text(
      "Price: ${displayText}.00 BDT",
    );
  }
