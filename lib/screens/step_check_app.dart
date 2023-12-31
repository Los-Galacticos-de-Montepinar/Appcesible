import 'package:appcesible/screens/select_main.dart';
import 'package:appcesible/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/widgets/widget_top_confirmation.dart';

class StepCheckMobile extends StatelessWidget {
  final String image;
  final String texto;
  final Widget destinationScreen;

  const StepCheckMobile({
    required this.image,
    required this.texto,
    required this.destinationScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double buttonSize = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
      appBar: TopScreenConfirmations(image: image, texto: texto),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => destinationScreen),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      minimumSize: Size(buttonSize, buttonSize),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 80.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      minimumSize: Size(buttonSize, buttonSize),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 80.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
