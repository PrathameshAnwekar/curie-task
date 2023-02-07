import 'package:curie_task/models/custom_numpad.dart';
import 'package:curie_task/models/transaction.dart';
import 'package:curie_task/utils/size_config.dart';
import 'package:curie_task/views/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class UPIScreen extends HookConsumerWidget {
  const UPIScreen({super.key});
  static const routeName = '/upi_screen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction = ref.watch(transactionProvider);
    final pinController = useTextEditingController();
    var obsuctingCharacter = useState("*");

    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xfff1f1f1),
        title: const Text(
          'YOUR BANK',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              "assets/images/upi_logo.png",
              width: 80,
            ),
          ),
        ],
      ),
      body: Stack(alignment: Alignment.topCenter, children: [
        Positioned(
          top: 0,
          child: Container(
            color: const Color(0xff1b317d),
            width: SizeConfig.screenWidth,
            child:  ListTile(
              title: Text(
                transaction.receiver,
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text("₹ ${transaction.amount}", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Positioned(
          top: SizeConfig.screenHeight * 0.25,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text("ENTER UPI PIN"),
                const SizedBox(
                  width: 50,
                ),
                const Icon(Icons.remove_red_eye),
                GestureDetector(
                    onTap: () {
                      obsuctingCharacter.value =
                          (obsuctingCharacter.value == " " ? "*" : " ");
                    },
                    child: const Text(" SHOW"))
              ],
            ),
          ),
        ),
        Positioned(
            top: SizeConfig.screenHeight * 0.3,
            right: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: SizeConfig.screenWidth * 0.23),
              child: PinCodeTextField(
                  animationType: AnimationType.fade,
                  controller: pinController,
                  keyboardType: TextInputType.none,
                  onTap: null,
                  obscuringWidget: obsuctingCharacter.value == " "
                      ? null
                      : Text(obsuctingCharacter.value),
                  appContext: context,
                  length: 4,
                  onChanged: (val) {
                    pinController.text = val;
                  }),
            )),
        Positioned(
            bottom: 0,
            child: NumPad(
                delete: () {
                  pinController.text = pinController.text
                      .substring(0, pinController.text.length - 1);
                },
                onSubmit: () {
                  if (pinController.text.length < 4) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please enter a valid UPI PIN")));
                    return;
                  }
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      SuccessScreen.routeName, (route) => false);
                },
                controller: pinController)),
      ]),
    );
  }
}
