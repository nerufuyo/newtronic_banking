import 'package:flutter/material.dart';
import 'package:newtronic_banking/styles/typography.dart';

SizedBox customSpaceHorizontal(double width) => SizedBox(width: width);

SizedBox customSpaceVertical(double height) => SizedBox(height: height);

Text customText({required String textValue, textStyle, textAlign}) {
  return Text(
    textValue,
    style: textStyle ?? headline1,
    textAlign: textAlign ?? TextAlign.start,
  );
}

InkWell customButton({
  required buttonOnTap,
  required String buttonText,
  buttonFirstGradientColor,
  buttonSecondGradientColor,
  textColor,
  buttonWidth,
}) {
  return InkWell(
    onTap: buttonOnTap,
    child: Container(
      width: buttonWidth ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: LinearGradient(
          colors: [buttonFirstGradientColor, buttonSecondGradientColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Center(
        child: customText(
          textValue: buttonText,
          textStyle: headline4.copyWith(
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    ),
  );
}
