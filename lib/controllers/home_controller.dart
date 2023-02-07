import 'package:curie_task/models/transaction.dart';
import 'package:curie_task/views/upi_screen.dart';
import 'package:flutter/material.dart';

class HomeController {
  static void proceedToPay(formKey, ref, amountController, context) {
    if (formKey.currentState!.validate()) {
      ref.read(transactionProvider).amount =
          double.parse(amountController.text);

      Navigator.of(context).pushNamed(UPIScreen.routeName);
    }
  }
}
