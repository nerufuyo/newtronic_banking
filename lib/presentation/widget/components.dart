import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:newtronic_banking/styles/pallet.dart';
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
  buttonBorderRadius,
  buttonFirstGradientColor,
  buttonSecondGradientColor,
  buttonPadding,
  textStyles,
  textColor,
  buttonWidth,
  buttonLeftIcon,
  buttonRightIcon,
  isButtonIcon = false,
}) {
  return InkWell(
    onTap: buttonOnTap,
    child: Container(
      width: buttonWidth ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: buttonBorderRadius ?? BorderRadius.circular(40),
        gradient: LinearGradient(
          colors: [buttonFirstGradientColor, buttonSecondGradientColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: buttonPadding ??
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: isButtonIcon == true
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.center,
        children: [
          Visibility(
            visible: buttonLeftIcon != null,
            child: buttonLeftIcon ?? const SizedBox.shrink(),
          ),
          customText(
            textValue: buttonText,
            textStyle: textStyles ??
                headline4.copyWith(color: textColor ?? secondary0),
          ),
          Visibility(
            visible: buttonRightIcon != null,
            child: buttonRightIcon ?? const SizedBox.shrink(),
          ),
        ],
      ),
    ),
  );
}

TextField customTextField({
  required TextEditingController controller,
  required String hintText,
  required String errorText,
  List<TextInputFormatter>? inputFormatters,
  void Function(String)? onChanged,
  void onTapTextField,
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
  prefixIcon,
  suffixIcon,
  isFilled = false,
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    onChanged: onChanged,
    onTap: () => onTapTextField,
    inputFormatters: inputFormatters,
    decoration: InputDecoration(
      errorText: errorText.isEmpty ? null : errorText,
      filled: isFilled,
      fillColor: secondary10.withOpacity(.5),
      hintText: hintText,
      hintStyle: bodyText2.copyWith(color: text),
      prefixIcon: Icon(
        prefixIcon ?? Icons.person_rounded,
        color: secondary20,
      ),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: secondary20),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: secondary20),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: primary90),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
    ),
  );
}

Future<dynamic> customDialog(BuildContext context,
    {required animationIcon, required textDialog}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset(
              animationIcon,
              height: 140,
              width: 140,
              fit: BoxFit.cover,
            ),
            customSpaceVertical(8),
            customText(
              textValue: textDialog,
              textStyle: headline4.copyWith(color: text),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

void showLoadingDialog(BuildContext context) {
  customDialog(
    context,
    animationIcon: 'lib/assets/lotties/lottieLoading.json',
    textDialog: 'Please wait...',
  );
}

void showSuccessDialog(BuildContext context,
    {required String message, required onAction}) {
  customDialog(
    context,
    animationIcon: 'lib/assets/lotties/lottieSuccess.json',
    textDialog: message,
  );
  Future.delayed(const Duration(seconds: 2), () => onAction());
}

void showErrorDialog(BuildContext context, {required String message}) {
  customDialog(
    context,
    animationIcon: 'lib/assets/lotties/lottieFailed.json',
    textDialog: message,
  );
  Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context));
}

Future<dynamic> customDialogWithButton(
  context, {
  required dialogTextValue,
  required dialogAction,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset(
              'lib/assets/lotties/lottieAsk.json',
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            customSpaceVertical(16),
            customText(
              textValue: dialogTextValue,
              textStyle: headline4.copyWith(color: text),
              textAlign: TextAlign.center,
            ),
            customSpaceVertical(16),
            Column(
              children: List.generate(
                2,
                (buttonIndex) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: customButton(
                    buttonOnTap: () {
                      if (buttonIndex == 0) {
                        dialogAction();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    buttonBorderRadius: BorderRadius.circular(8),
                    buttonText: buttonIndex == 0 ? 'Yes' : 'No',
                    buttonFirstGradientColor:
                        buttonIndex == 0 ? primary80 : secondary20,
                    buttonSecondGradientColor:
                        buttonIndex == 0 ? primary90 : secondary20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<dynamic> customDraggableModalBottomSheet(
  BuildContext context, {
  required bottomSheetTitle,
  required bottomSheetSearchController,
  required bottomSheetItemCount,
  required bottomSheetOnTap,
  required bottomSheetImage,
  required bottomSheetItemName,
}) {
  return showModalBottomSheet(
    context: context,
    barrierColor: text.withOpacity(.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    isDismissible: true,
    builder: (context) => Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: secondary0),
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 80,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: text.withOpacity(.25),
                  ),
                ),
              ),
              customSpaceVertical(16),
              customText(
                textValue: bottomSheetTitle,
                textStyle: headline5,
              ),
              customSpaceVertical(16),
              customTextField(
                controller: bottomSheetSearchController,
                hintText: 'Search',
                errorText: '',
                prefixIcon: Icons.search_rounded,
                isFilled: true,
              ),
              customSpaceVertical(16),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) =>
                        customSpaceVertical(16),
                    itemCount: bottomSheetItemCount,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        bottomSheetOnTap();
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: CachedNetworkImage(
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                            imageUrl: bottomSheetImage,
                            placeholder: (context, url) => Image.asset(
                              'lib/assets/images/profile.jpg',
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        title: customText(
                          textValue: bottomSheetItemName,
                          textStyle: headline5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
