import 'package:curie_task/models/custom_numpad.dart';
import 'package:curie_task/utils/logger.dart';
import 'package:curie_task/utils/size_config.dart';
import 'package:curie_task/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class UPIScreen extends HookConsumerWidget {
  const UPIScreen({super.key});
  static const routeName = '/upi_screen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          Image.asset(
            "assets/images/upi_logo.png",
            width: 50,
          ),
        ],
      ),
      body: Stack(alignment: Alignment.topCenter, children: [
        Positioned(
          top: 0,
          child: Container(
            color: const Color(0xff1b317d),
            width: SizeConfig.screenWidth,
            child: const ListTile(
              title: Text(
                "Verve Financial Services",
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text("₹ 1.00", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Positioned(
          top: SizeConfig.screenHeight * 0.25,
          left:0,
          right: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
               Text("ENTER UPI PIN"),
              SizedBox(
                width: 50,
              ),
              Icon(Icons.remove_red_eye),
              GestureDetector(onTap: () {
                obsuctingCharacter.value = (obsuctingCharacter.value == " "
                    ? "*"
                    : " ");
              }, child: Text("SHOW"))
            ],
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
                  Navigator.of(context).pushNamed(Home.routeName);
                },
                controller: pinController)),
      ]),
    );
  }
}
