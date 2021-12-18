import 'package:flutter/material.dart';

class PrimaryCard extends StatelessWidget {
  final Widget child;
  const PrimaryCard({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
