import 'package:flutter/material.dart';

class DestinationImage extends StatelessWidget {
  const DestinationImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.borderRadius = 18,
    this.iconSize = 34,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final double borderRadius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return _fallback();
        },
        errorBuilder: (context, error, stackTrace) => _fallback(),
      ),
    );
  }

  Widget _fallback() {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB8D8CB), Color(0xFFEEF2DB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.landscape_rounded,
          color: const Color(0xFF397568),
          size: iconSize,
        ),
      ),
    );
  }
}
