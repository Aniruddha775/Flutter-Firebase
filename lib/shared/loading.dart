import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 248, 232, 5),
      child: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
