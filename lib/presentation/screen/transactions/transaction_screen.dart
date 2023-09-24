import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:newtronic_banking/common/constants.dart';
import 'package:newtronic_banking/presentation/screen/transactions/add_transaction_screen.dart';
import 'package:newtronic_banking/presentation/widget/components.dart';
import 'package:newtronic_banking/styles/pallet.dart';
import 'package:newtronic_banking/styles/typography.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});
  static const routeName = '/transaction';

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  late TabController tabController;
  bool isLoading = true;

  String? errorText;

  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 2), () => setState(() => isLoading = false));
    tabController =
        TabController(length: transactionScreenTabbar.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary0,
        elevation: 0,
        leadingWidth: 72,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          splashRadius: 20,
          icon: const Icon(Icons.arrow_back_ios),
          color: primary90,
        ),
      ),
      body: isLoading
          ? Center(
              child: LottieBuilder.asset(
                'lib/assets/lotties/lottieLoading.json',
                width: MediaQuery.of(context).size.width * .5,
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customText(textValue: 'Transaction', textStyle: headline1),
                  customSpaceVertical(16),
                  customTextField(
                    controller: searchController,
                    hintText: 'Search',
                    errorText: '',
                    prefixIcon: Icons.search_rounded,
                    isFilled: true,
                  ),
                  customSpaceVertical(16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: secondary10.withOpacity(.5),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: TabBar(
                      controller: tabController,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: secondary0),
                      labelColor: text,
                      unselectedLabelColor: text.withOpacity(.25),
                      tabs: List.generate(
                        transactionScreenTabbar.length,
                        (index) => Tab(
                          text: transactionScreenTabbar[index],
                        ),
                      ),
                    ),
                  ),
                  customSpaceVertical(16),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: List.generate(
                        transactionScreenTabbar.length,
                        (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: primary90,
                                        shape: BoxShape.circle),
                                    padding: const EdgeInsets.all(8),
                                    child: const Icon(
                                      Icons.people_rounded,
                                      color: secondary0,
                                    ),
                                  ),
                                  customSpaceHorizontal(8),
                                  customText(
                                    textValue: 'Multiple Transaction',
                                    textStyle: subHeadline4,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 80),
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                      'lib/assets/images/search.svg'),
                                  customSpaceVertical(16),
                                  customText(
                                    textValue:
                                        'Transaction now! There is an interesting promo for you',
                                    textStyle: bodyText2.copyWith(
                                        color: text.withOpacity(.5)),
                                    textAlign: TextAlign.center,
                                  ),
                                  customSpaceVertical(40),
                                  customButton(
                                    buttonOnTap: () => Navigator.pushNamed(
                                        context,
                                        AddTransactionScreen.routeName),
                                    buttonText: 'New Transaction',
                                    buttonWidth:
                                        MediaQuery.of(context).size.width * .6,
                                    buttonFirstGradientColor: primary90,
                                    buttonSecondGradientColor: primary90,
                                    buttonBorderRadius:
                                        BorderRadius.circular(40),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
