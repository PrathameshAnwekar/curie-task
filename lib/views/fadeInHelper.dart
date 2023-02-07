import 'package:curie_task/models/transaction.dart';
import 'package:curie_task/views/home.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FadeInHelper extends StatefulHookConsumerWidget {
  const FadeInHelper({super.key});

  @override
  ConsumerState<FadeInHelper> createState() => _FadeInHelperState();
}

class _FadeInHelperState extends ConsumerState<FadeInHelper>
    with TickerProviderStateMixin {
  bool _visible = false;
  bool init = true;
  @override
  Widget build(BuildContext context) {
    final transaction = ref.watch(transactionProvider);
    if (init) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _visible = true;
          init = false;
        });
      });
    }
    return AnimatedOpacity(
      // If the widget is visible, animate to 0.0 (invisible).
      // If the widget is hidden, animate to 1.0 (fully visible).
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      // The green box must be a child of the AnimatedOpacity widget.
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "₹ ${transaction.amount} paid",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              transaction.receiver,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              transaction.receiverUPI,
              style: const TextStyle(color: Color(0xff7da4f0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
                ),
                onPressed: () {
                  ref.read(transactionProvider).reset();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Home.routeName, (route) => false);
                },
                child: const Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Text(
                    "Done",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
