import 'package:curie_task/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Home extends HookWidget {
  static const routeName = '/home';
  final formKey = GlobalKey<FormState>();
  Home({super.key});
  @override
  Widget build(BuildContext context) {
    final amountController = useTextEditingController();
    final focusNode = useFocusNode();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Form(
        key: formKey,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color(0xff1a73e8),
          appBar: AppBar(
            leading: const Icon(Icons.navigate_before),
            actions: [],
          ),
          body: Stack(
            children: [
              Column(children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/man.jpg"),
                      radius: 30,
                    ),
                    Icon(
                      Icons.navigate_next_outlined,
                      color: Colors.white,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/woman.jpg"),
                      radius: 30,
                    )
                  ],
                ),
                const Text("Payment to Red Bus"),
                const Text("(redbus@axis)"),
                SizedBox(
                  height: 100,
                  width: 50,
                  child: TextField(
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      prefixIcon: Text("₹ "),
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                    ),
                    keyboardType: TextInputType.number,
                    controller: amountController,
                  ),
                )
              ])
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                context: context,
                builder: (context) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    height: SizeConfig.screenHeight * 0.25,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                              leading:
                                  Image.asset("assets/images/bank_logo.png"),
                              title: const Text("YOUR BANK xxxx 4321"),
                              subtitle: const Text("Debit Card"),
                              trailing: const Icon(
                                  Icons.keyboard_arrow_down_outlined)),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.8,
                            child: ElevatedButton(
                              onPressed: null,
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xff1a73e8)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  )),
                              child: const Text(
                                "Proceed to pay",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        Text("In partnership with YOUR BANK", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),) ]),
                  );
                },
              );
            },
            child: const Icon(
              Icons.done,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
