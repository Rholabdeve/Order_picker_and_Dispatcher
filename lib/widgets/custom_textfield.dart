// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final bool? enabled;
  final String? prefixText;
  final Widget? suffix_widget;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final String? hintText;
  final Widget? prefixIcon;
  final String? defaultText;
  final FocusNode? focusNode;
  bool obscureText;
  final TextEditingController? controller;
  final Function? functionValidate;
  final String? parametersValidate;
  final TextInputAction? actionKeyboard;
  final int? maxLines;
  final Color? iconColor;
  final FormFieldValidator? validate;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final String? label;
  final GestureTapCallback? onTap;
  final bool? readonly;
  final IconData? suffixIcon;
  final IconData? suffixIcon2;
  final Color? fillColor;
  final bool? filled;
  final ValueChanged<String>? onChanged;
  final Widget? prefix;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool? focus;

  // final SpellCheckConfiguration? spellCheckConfiguration;

  CustomTextField(
      {super.key,
      this.suffixIcon,
      this.hintText,
      this.focus,
      this.textStyle,
      this.hintStyle,
      this.enabled,
      this.focusNode,
      this.textInputType,
      this.defaultText,
      this.obscureText = false,
      this.controller,
      this.functionValidate,
      this.parametersValidate,
      this.actionKeyboard = TextInputAction.next,
      this.prefixIcon,
      this.iconColor,
      this.maxLines,
      this.validate,
      this.inputFormatters,
      this.maxLength,
      this.maxLengthEnforcement,
      this.label,
      this.onTap,
      this.readonly,
      this.suffixIcon2,
      this.fillColor,
      this.filled,
      this.onChanged,
      this.prefix,
      this.suffix_widget,
      this.prefixText});

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  double bottomPaddingToError = 12;
  bool tap = true;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var mq = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: Container(
        // color: const Color.fromARGB(255, 255, 141, 133),
        // height: mq.height * 0.05,
        // color: const Color.fromARGB(255, 255, 176, 170),
        child: TextFormField(
          autofocus: widget.focus ?? false,
          enabled: widget.enabled ?? true,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          maxLengthEnforcement: widget.maxLengthEnforcement,
          validator: widget.validate,
          // spellCheckConfiguration: SpellCheckConfiguration(),
          maxLines: widget.maxLines,
          cursorColor: Colors.black,
          obscureText: widget.obscureText,
          keyboardType: widget.textInputType,
          textInputAction: widget.actionKeyboard,
          focusNode: widget.focusNode,
          readOnly: widget.readonly ?? false,
          style: widget.textStyle,
          decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(minWidth: 5, minHeight: 0),
            prefixStyle: TextStyle(
              color: Colors.black,
            ), // Change prefix text color to black
            prefixText: widget.prefixText,
            suffixIcon: widget.suffix_widget,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            labelText: widget.label,
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText,
            labelStyle: const TextStyle(color: Colors.black),
            fillColor: widget.fillColor ?? Colors.grey.shade100,
            filled: widget.filled,
            prefix: widget.prefix,
            border: OutlineInputBorder(
              // borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: myColor.themeColor, width: 2.0),
            //   borderRadius: BorderRadius.circular(8),
            // ),
            hintStyle: widget.hintStyle,
            // fontFamily: 'Ubuntu Regular',

            // errorStyle: const TextStyle(
            //   color: Colors.red,
            //   fontSize: 12.0,
            //   fontWeight: FontWeight.w300,
            //   fontStyle: FontStyle.normal,
            //   letterSpacing: 1.2,
            // ),
            // errorBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(color: Colors.red),
            //   borderRadius: BorderRadius.circular(8),
            // ),
            // focusedErrorBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(color: Colors.red),
            //   borderRadius: BorderRadius.circular(8),
            // ),
          ),
          controller: widget.controller,
        ),
      ),
    );
  }
}

String? commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);
  if (required != null) {
    return required;
  }
  return null;
}

String? requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

void changeFocus(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
