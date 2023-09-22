import 'package:flutter/material.dart';
import 'package:newtronic_banking/presentation/widget/components.dart';
import 'package:newtronic_banking/styles/pallet.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});
  static const routeName = '/authentication';

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('lib/assets/images/logo.png'),
              Expanded(
                flex: 8,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: 3,
                  itemBuilder: (context, pageIndex) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: pageIndex == 0
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('lib/assets/images/welcome.png'),
                      customButton(
                        buttonOnTap: () {
                          if (pageIndex == 2) {
                            Navigator.pushNamed(context, '/home');
                          } else {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        buttonText: pageIndex == 0
                            ? 'Get Started'
                            : pageIndex == 1
                                ? 'Log in'
                                : 'Sign Up',
                        buttonFirstGradientColor: primary80,
                        buttonSecondGradientColor: primary90,
                        buttonWidth: MediaQuery.of(context).size.width * 0.65,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
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
                        color: index == 0
                            ? primary90
                            : index == 1
                                ? primary70
                                : primary80,
                        borderRadius: BorderRadius.circular(4),
                      ),
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
}
