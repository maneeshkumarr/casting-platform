import 'package:flutter/material.dart';

class SignupProgressDots extends StatelessWidget {
  final int currentIndex;
  final Color activeColor;
  final Function(int) onDotTapped;

  const SignupProgressDots({
    required this.currentIndex,
    required this.activeColor,
    required this.onDotTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => onDotTapped(index),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: index == currentIndex ? activeColor : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }
}
