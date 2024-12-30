import 'package:delivery_man/const/my_color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    required this.onTap,
    required this.buttonText,
    this.sizeHeight,
    required this.sizeWidth,
    this.buttonColor,
    this.borderRadius,
    this.textColor,
    this.borderColor,
    this.icon,
    this.iconColor,
    this.isIcon = false,
    this.fontFamily,
    this.buttonTextSize,
    this.buttonTextWeight,
    this.buttonBorderWidth,
    this.isLoading,
    Key? key,
  }) : super(key: key);

  VoidCallback onTap;
  Color? buttonColor;
  double? borderRadius;
  Color? textColor;
  String buttonText;
  Color? borderColor;
  IconData? icon;
  bool? isIcon;
  Color? iconColor;
  double? sizeHeight;
  double sizeWidth;
  String? fontFamily;
  double? buttonTextSize;
  FontWeight? buttonTextWeight;
  double? buttonBorderWidth;
  bool? isLoading;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeHeight ?? 50,
      width: sizeWidth,
      decoration: BoxDecoration(
        color: buttonColor ?? myColor.themeColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        border: Border.all(
            color: borderColor ?? Colors.transparent,
            //strokeAlign: borderstroke ?? 1,
            width: buttonBorderWidth ?? 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: isIcon == false
                  ? isLoading == true
                      ? CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        )
                      : Text(
                          buttonText,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: textColor ?? Colors.white,
                              fontSize: buttonTextSize ?? 15,
                              fontWeight:
                                  buttonTextWeight ?? FontWeight.normal),
                        )
                  : Icon(
                      icon,
                      color: iconColor,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
