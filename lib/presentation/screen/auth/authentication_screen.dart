// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:newtronic_banking/common/constants.dart';
import 'package:newtronic_banking/data/repository/repository.dart';
import 'package:newtronic_banking/presentation/screen/main/home_screen.dart';
import 'package:newtronic_banking/presentation/widget/components.dart';
import 'package:newtronic_banking/styles/pallet.dart';
import 'package:newtronic_banking/styles/typography.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});
  static const routeName = '/authentication';

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final PageController pageController = PageController();
  final List<TextEditingController> logInControllers = List.generate(
      logInTextFieldProperties.length, (_) => TextEditingController());
  final List<TextEditingController> signUpControllers = List.generate(
      signUpTextFieldProperties.length, (_) => TextEditingController());

  List<String> logInErrorTexts =
      List.generate(logInTextFieldProperties.length, (_) => '');
  List<String> signUpErrorTexts =
      List.generate(signUpTextFieldProperties.length, (_) => '');
  int pageIndex = 0;
  bool isPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pageIndex == 0) {
          return false;
        } else {
          try {
            pageController.animateToPage(pageIndex - 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
            return false;
          } catch (e) {
            return true;
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: MediaQuery.of(context).viewInsets.bottom == 0,
                  child: Column(
                    children: [
                      Image.asset('lib/assets/images/logo.png'),
                      Visibility(
                        visible: pageIndex == 1 || pageIndex == 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              customText(
                                textValue: pageIndex == 1
                                    ? 'Log in Now'
                                    : 'Sign Up Now',
                                textStyle: headline2.copyWith(color: text),
                                textAlign: TextAlign.center,
                              ),
                              customSpaceVertical(8),
                              customText(
                                textValue: pageIndex == 1
                                    ? 'Please log in to continue using app'
                                    : 'Please fill details to create an account',
                                textStyle: bodyText2.copyWith(color: text),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (newPageIndex) =>
                        setState(() => pageIndex = newPageIndex),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildContent(index),
                        _buildButton(context),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: MediaQuery.of(context).viewInsets.bottom == 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 10,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            customSpaceHorizontal(8),
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) => Container(
                          width: 30,
                          height: 10,
                          decoration: BoxDecoration(
                            color:
                                pageIndex == index ? primary100 : secondary20,
                            borderRadius: BorderRadius.circular(4),
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

  Padding _buildContent(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: index == 0
            ? [
                Image.asset('lib/assets/images/welcome.png'),
                customSpaceVertical(16),
                customText(
                  textValue: 'Welcome',
                  textStyle: headline2.copyWith(color: text),
                  textAlign: TextAlign.center,
                ),
                customSpaceVertical(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: customText(
                    textValue:
                        'Create an account and get access to all cool stuff',
                    textStyle: bodyText2.copyWith(color: text),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]
            : [
                Visibility(
                  visible: pageIndex == 2,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        customSpaceVertical(16),
                    shrinkWrap: true,
                    itemCount: signUpTextFieldProperties.length,
                    itemBuilder: (context, field) => customTextField(
                        controller: signUpControllers[field],
                        keyboardType: signUpTextFieldProperties[field]['type'],
                        inputFormatters: signUpTextFieldProperties[field]
                            ['inputFormatters'],
                        prefixIcon: signUpTextFieldProperties[field]['icon'],
                        hintText: signUpTextFieldProperties[field]['hintText'],
                        errorText: signUpErrorTexts[field],
                        obscureText: field == 3 || field == 4
                            ? isPasswordObscure
                            : false,
                        suffixIcon: field == 3 || field == 4
                            ? InkWell(
                                onTap: () => setState(() =>
                                    isPasswordObscure = !isPasswordObscure),
                                child: Icon(
                                  isPasswordObscure
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  color: secondary20,
                                ),
                              )
                            : null),
                  ),
                ),
                Visibility(
                  visible: pageIndex == 1,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        customSpaceVertical(16),
                    shrinkWrap: true,
                    itemCount: logInTextFieldProperties.length,
                    itemBuilder: (context, field) => customTextField(
                        controller: logInControllers[field],
                        keyboardType: logInTextFieldProperties[field]['type'],
                        inputFormatters: logInTextFieldProperties[field]
                            ['inputFormatters'],
                        prefixIcon: logInTextFieldProperties[field]['icon'],
                        hintText: logInTextFieldProperties[field]['hintText'],
                        errorText: logInErrorTexts[field],
                        obscureText: field == 1 ? isPasswordObscure : false,
                        suffixIcon: field == 1
                            ? InkWell(
                                onTap: () => setState(() =>
                                    isPasswordObscure = !isPasswordObscure),
                                child: Icon(
                                  isPasswordObscure
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  color: secondary20,
                                ),
                              )
                            : null),
                  ),
                ),
                Visibility(
                  visible: pageIndex == 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: customText(
                          textValue: 'Forgot Password?',
                          textStyle: subHeadline5.copyWith(color: primary90),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
      ),
    );
  }

  Column _buildButton(BuildContext context) {
    return Column(
      children: [
        customButton(
          buttonOnTap: () {
            switch (pageIndex) {
              case 0:
                pageController.animateToPage(2,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
                break;
              case 1:
                logInValidation();
                loginFunction();
                break;
              case 2:
                signUpValidation();
                signupFunction();
                break;
            }
          },
          buttonText: pageIndex == 0
              ? 'Get Started'
              : pageIndex == 1
                  ? 'Log in'
                  : 'Sign Up',
          buttonFirstGradientColor: pageIndex == 0
              ? primary80
              : pageIndex == 1 &&
                      !logInControllers
                          .every((element) => element.text.isNotEmpty)
                  ? secondary20
                  : (pageIndex == 2 &&
                          !signUpControllers
                              .every((element) => element.text.isNotEmpty))
                      ? secondary20
                      : primary80,
          buttonSecondGradientColor: pageIndex == 0
              ? primary90
              : pageIndex == 1 &&
                      !logInControllers
                          .every((element) => element.text.isNotEmpty)
                  ? secondary20
                  : (pageIndex == 2 &&
                          !signUpControllers
                              .every((element) => element.text.isNotEmpty))
                      ? secondary20
                      : primary90,
          buttonWidth: MediaQuery.of(context).size.width * 0.65,
        ),
        customSpaceVertical(16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customText(
              textValue: pageIndex == 1
                  ? 'Don\'t have an account?'
                  : 'Already have an account?',
              textStyle: bodyText2.copyWith(color: text),
            ),
            customSpaceHorizontal(4),
            InkWell(
              onTap: () {
                if (pageIndex == 1) {
                  pageController.animateToPage(2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                } else {
                  pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                }
              },
              child: customText(
                textValue: pageIndex == 1 ? 'Sign Up' : 'Log in',
                textStyle: subHeadline5.copyWith(color: primary100),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void loginFunction() async {
    if (logInErrorTexts.every((element) => element.isEmpty)) {
      try {
        showLoadingDialog(context);

        final user = await Repository().loginUser(
          emailOrUsername: logInControllers[0].text,
          password: logInControllers[1].text,
        );

        Navigator.pop(context);

        if (user != null) {
          showSuccessDialog(context,
              message: 'Login Success',
              onAction: () => Navigator.pushNamed(
                    context,
                    HomeScreen.routeName,
                    arguments: user.id,
                  ));
        } else {
          showErrorDialog(context, message: 'Account not found');
        }
      } catch (e) {
        showErrorDialog(context, message: e.toString());
      }
    }
  }

  void signupFunction() async {
    if (signUpErrorTexts.every((element) => element.isEmpty)) {
      try {
        customDialogWithButton(context,
            dialogTextValue: 'Are you sure want to create an account?',
            dialogAction: () async {
          Navigator.pop(context);
          showLoadingDialog(context);

          Navigator.pop(context);

          showSuccessDialog(context,
              message: 'Register Success',
              onAction: () => Navigator.pop(context));
        });
      } catch (e) {
        showErrorDialog(context, message: e.toString());
      }
    }
  }

  void logInValidation() {
    setState(() {
      for (int i = 0; i < logInControllers.length; i++) {
        switch (i) {
          case 0:
            if (logInControllers[i].text.isEmpty) {
              logInErrorTexts[i] = 'Email or Username is required';
            } else {
              logInErrorTexts[i] = '';
            }
            break;
          case 1:
            if (logInControllers[i].text.isEmpty) {
              logInErrorTexts[i] = 'Password is required';
            } else {
              logInErrorTexts[i] = '';
            }
            break;
        }
      }
    });
  }

  void signUpValidation() {
    setState(() {
      for (int i = 0; i < signUpControllers.length; i++) {
        switch (i) {
          case 0:
            String textWithoutSpaces =
                signUpControllers[i].text.replaceAll(' ', ''); // Remove spaces
            if (textWithoutSpaces.isEmpty) {
              signUpErrorTexts[i] = 'Full Name is required';
            } else if (textWithoutSpaces.length < 3 ||
                textWithoutSpaces.length > 50) {
              signUpErrorTexts[i] = 'Full Name must be 3 to 50 characters';
            } else if (textWithoutSpaces.contains(RegExp(r'[0-9]')) ||
                textWithoutSpaces.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
              signUpErrorTexts[i] = 'Full Name must be text only';
            } else {
              signUpErrorTexts[i] = '';
            }

            break;
          case 1:
            if (signUpControllers[i].text.isEmpty) {
              signUpErrorTexts[i] = 'Username is required';
            } else if (signUpControllers[i].text.length < 6 &&
                signUpControllers[i].text.length > 12) {
              signUpErrorTexts[i] = 'Username must be 6 to 12 characters';
            } else if (signUpControllers[i]
                .text
                .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
              signUpErrorTexts[i] = 'Username must be alphanumeric only';
            } else {
              signUpErrorTexts[i] = '';
            }
            break;
          case 2:
            if (signUpControllers[i].text.isEmpty) {
              signUpErrorTexts[i] = 'Email is required';
            } else if (!signUpControllers[i].text.contains('@') ||
                !signUpControllers[i].text.contains('.') ||
                signUpControllers[i].text.indexOf('@') >
                    signUpControllers[i].text.indexOf('.')) {
              signUpErrorTexts[i] = 'Check your format email';
            } else {
              signUpErrorTexts[i] = '';
            }
            break;
          case 3:
            if (signUpControllers[i].text.isEmpty) {
              signUpErrorTexts[i] = 'Password is required';
            } else if (signUpControllers[i]
                        .text
                        .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) &&
                    signUpControllers[i].text.contains(RegExp(r'[A-Z]')) ||
                signUpControllers[i].text.contains(RegExp(r'[a-z]')) &&
                    signUpControllers[i].text.contains(RegExp(r'[0-9]')) &&
                    signUpControllers[i].text.length > 8) {
              signUpErrorTexts[i] = '';
            } else {
              signUpErrorTexts[i] = 'Requirement must be fulfilled';
            }
            break;
          case 4:
            if (signUpControllers[i].text.isEmpty) {
              signUpErrorTexts[i] = 'Confirm Password is required';
            } else if (signUpControllers[i].text !=
                signUpControllers[i - 1].text) {
              signUpErrorTexts[i] = 'Password must be same';
            } else {
              signUpErrorTexts[i] = '';
            }
            break;
        }
      }
    });
  }
}
