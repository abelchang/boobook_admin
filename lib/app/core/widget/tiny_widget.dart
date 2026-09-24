import 'package:flutter/material.dart';

class C extends StatelessWidget {
  const C(this.size, {super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size, width: size);
  }
}
