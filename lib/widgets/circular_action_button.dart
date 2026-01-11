import 'package:flutter/material.dart';
import '../utility/sizes.dart';

class CircularActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CircularActionButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 10.pW,
        height: 10.pW,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.2),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 5.pW,
        ),
      ),
    );
  }
}
