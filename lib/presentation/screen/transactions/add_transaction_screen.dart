import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newtronic_banking/common/constants.dart';
import 'package:newtronic_banking/presentation/widget/components.dart';
import 'package:newtronic_banking/styles/pallet.dart';
import 'package:newtronic_banking/styles/typography.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});
  static const routeName = '/add-transaction';

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen>
    with SingleTickerProviderStateMixin {
  final PageController pageController = PageController();
  late TabController tabController;

  @override
  void initState() {
    tabController =
        TabController(length: addTransactionScreenTabbar.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 24,
                      color: primary90,
                    ),
                  ),
                  customSpaceVertical(16),
                  customText(textValue: 'New Transfer', textStyle: headline1),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: 2,
                  itemBuilder: (context, pageIndex) {
                    switch (pageIndex) {
                      case 0:
                        return Center(
                          child: customText(
                              textValue: 'Top Up', textStyle: headline1),
                        );
                      case 1:
                        return Center(
                          child: customText(
                              textValue: 'Continued', textStyle: headline1),
                        );
                      default:
                        return Center(
                          child: LottieBuilder.asset(
                            'lib/assets/lotties/lottieLoading.json',
                            height: 140,
                          ),
                        );
                    }
                  },
                ),
              ),
              customButton(
                buttonOnTap: () {},
                buttonText: 'Continue',
                buttonWidth: MediaQuery.of(context).size.width,
                buttonFirstGradientColor: primary80,
                buttonSecondGradientColor: primary90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
