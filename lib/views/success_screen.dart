import 'package:curie_task/utils/size_config.dart';
import 'package:curie_task/views/fadeInHelper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatefulHookConsumerWidget {
  const SuccessScreen({super.key});
  static const routeName = "/succes-screen";

  @override
  ConsumerState<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends ConsumerState<SuccessScreen>{
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      backgroundColor: const Color(0xff5186ec),
      body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3)),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else {
              return SizedBox(
                width: SizeConfig.screenWidth,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: LottieBuilder.asset(
                          "assets/animations/payment_successful.json",
                          repeat: false,
                          width: SizeConfig.screenWidth * 0.5,
                        ),
                      ),
                      const 
                      FadeInHelper()
                      
                    ]),
              );
            }
          }),
    );
  }
}
