import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  CustomContainer({
    required this.child,
    this.sizeWidth,
    this.offsetShadow,
    this.spreadRadius,
    this.padding,
    this.sizeHeight,
    this.color,
    this.radius,
    this.margin,
    this.border,
    this.clipBehavior,
    this.shadowBlurRadius,
    this.shadowColor,
    this.alignment,
    super.key,
  });

  Widget child;
  double? sizeWidth;
  double? sizeHeight;
  Color? color;
  double? radius;
  EdgeInsetsGeometry? margin;
  BoxBorder? border;
  Clip? clipBehavior;
  double? shadowBlurRadius;
  Color? shadowColor;
  EdgeInsetsGeometry? padding;
  Alignment? alignment;
  double? spreadRadius;
  Offset? offsetShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      height: sizeHeight ?? 45,
      width: sizeWidth ?? 100,
      margin: margin,
      padding: padding,
      clipBehavior: clipBehavior ?? Clip.none,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade100,
        borderRadius: BorderRadius.circular(radius ?? 10),
        border: border ?? const Border(),
        boxShadow: [
          BoxShadow(
            offset: offsetShadow ?? const Offset(0, 0),
            spreadRadius: spreadRadius ?? 0,
            color: shadowColor ?? Colors.white,
            blurRadius: shadowBlurRadius ?? 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
