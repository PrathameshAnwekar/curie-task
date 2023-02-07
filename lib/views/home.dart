import 'package:curie_task/controllers/home_controller.dart';
import 'package:curie_task/models/transaction.dart';
import 'package:curie_task/utils/size_config.dart';
import 'package:curie_task/views/upi_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends StatefulHookConsumerWidget {
  const Home({super.key});
  static const routeName = "/home";

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  var formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Form(
        key: formKey,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color(0xff1a73e8),
          appBar: AppBar(
            elevation: 0,
            leading: GestureDetector(onTap: () {
              Navigator.pop(context);
            },child: const Icon(Icons.navigate_before)),
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.more_vert),
              )
            ],
          ),
          body: SizedBox(
            width: SizeConfig.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/images/man.jpg"),
                          radius: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.navigate_next_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/woman.jpg"),
                          radius: 40,
                        )
                      ],
                    ),
                  ),
                  const Text(
                    "Payment to Red Bus",
                    style: TextStyle(color: Colors.white),
                  ),
                  const Text(
                    "(redbus@axis)",
                    style: TextStyle(color: Colors.white),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 5),
                      width: 120,
                      child: TextFormField(
                        maxLength: 6,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 45),
                        // focusNode: focusNode,
                        validator: (value) {
                          return value!.isEmpty ? "Invalid Amount" : null;
                        },
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          counterText: "",
                          prefixIcon: Text(
                            "₹ ",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                        ),
                        keyboardType: TextInputType.number,
                        controller: amountController,
                      ),
                    ),
                  ),
                  const Text(
                    "Payment via Billdesk",
                    style: TextStyle(color: Colors.white),
                  ),
                ])
              ],
            ),
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
                              onPressed: () {
                                HomeController.proceedToPay(
                                    formKey, ref, amountController, context);
                              },
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
                          const Text(
                            "In partnership with YOUR BANK",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
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
