import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final transactionProvider = ChangeNotifierProvider((ref) =>
    Transaction(amount: 0, receiver: "Red Bus", receiverUPI: "redbus@axis"));

class Transaction extends ChangeNotifier {
  double amount;
  String receiver;
  String receiverUPI;

  Transaction(
      {required this.amount,
      required this.receiver,
      required this.receiverUPI});

  void updateAmount(double amount) {
    this.amount = amount;
    notifyListeners();
  }

  void reset() {
    amount = 0;
    notifyListeners();
  }
}
