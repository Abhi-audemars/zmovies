import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class customButton extends StatelessWidget {
  final Color color;
  final String text;
  // final Icon icon;
  final LottieBuilder lottie;
  const customButton(
      {super.key,
      required this.color,
      required this.text,
      required this.lottie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        color: color,
      ),
      height: 50,
      width: 260,
      child: Row(
        children: [
          lottie,
          const SizedBox(
            width: 5,
          ),
          DefaultTextStyle(
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w300, color: Colors.white),
            child: Text(text),
          ),
          // Text(
          //   text,
          //   style:const TextStyle(
          //       fontSize: 15, fontWeight: FontWeight.w300, color: Colors.white),
          // ),
        ],
      ),
    );
  }
}
