import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newtronic_banking/presentation/screen/main/home_screen.dart';
import 'package:newtronic_banking/presentation/widget/components.dart';
import 'package:newtronic_banking/styles/pallet.dart';
import 'package:newtronic_banking/styles/typography.dart';

class StatusTransactionScreen extends StatefulWidget {
  const StatusTransactionScreen({super.key, required this.transactionStatus});
  static const routeName = '/status-transaction';
  final List<Map<String, String>> transactionStatus;

  @override
  State<StatusTransactionScreen> createState() =>
      _StatusTransactionScreenState();
}

class _StatusTransactionScreenState extends State<StatusTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: primary90,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('lib/assets/images/success.svg'),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: secondary0,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      customText(
                        textValue: 'Transaction Nominal',
                        textStyle: headline4,
                      ),
                      customSpaceVertical(4),
                      customText(
                        textValue:
                            'Rp. ${widget.transactionStatus[0]['nominal']!}',
                        textStyle: headline3,
                      ),
                      customSpaceVertical(16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: CachedNetworkImage(
                              imageUrl: widget.transactionStatus[0]['image']!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          customSpaceHorizontal(8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              customText(
                                textValue: 'Rafeh  Qazi',
                                textStyle: subHeadline4,
                              ),
                              customText(
                                textValue:
                                    '${widget.transactionStatus[0]['bank']!} - ${widget.transactionStatus[0]['number']!}',
                                textStyle: bodyText2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      customSpaceVertical(10),
                      Divider(thickness: 2, color: text.withOpacity(.25)),
                      customSpaceVertical(10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                            textValue: 'Transaction Type',
                            textStyle: bodyText2,
                          ),
                          customText(
                            textValue: widget.transactionStatus[0]['type']!,
                            textStyle: subHeadline5,
                          ),
                        ],
                      ),
                      customSpaceVertical(10),
                      Divider(thickness: 2, color: text.withOpacity(.25)),
                      customSpaceVertical(10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                            textValue: 'Ref Number',
                            textStyle: bodyText2,
                          ),
                          customText(
                            textValue: widget.transactionStatus[0]['ref']!,
                            textStyle: subHeadline5,
                          ),
                        ],
                      ),
                      customSpaceVertical(10),
                      ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        title: customText(
                          textValue: 'Detail',
                          textStyle: subHeadline5,
                        ),
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText(
                                textValue: 'Transaction Nominal',
                                textStyle: bodyText2,
                              ),
                              customText(
                                textValue: widget.transactionStatus[0]
                                    ['nominal']!,
                                textStyle: subHeadline5,
                              ),
                            ],
                          ),
                          customSpaceVertical(10),
                          Divider(thickness: 2, color: text.withOpacity(.25)),
                          customSpaceVertical(10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText(
                                textValue: 'Admin',
                                textStyle: bodyText2,
                              ),
                              customText(
                                textValue: widget.transactionStatus[0]
                                    ['admin']!,
                                textStyle: subHeadline5,
                              ),
                            ],
                          ),
                          customSpaceVertical(10),
                          Divider(thickness: 2, color: text.withOpacity(.25)),
                          customSpaceVertical(10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText(
                                textValue: 'Total',
                                textStyle: subHeadline5,
                              ),
                              customText(
                                textValue: widget.transactionStatus[0]
                                    ['total']!,
                                textStyle: subHeadline5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                customButton(
                  buttonOnTap: () {
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushReplacementNamed(
                        context,
                        HomeScreen.routeName,
                        arguments: 5,
                      );
                    });
                    customDialog(
                      context,
                      animationIcon: 'lib/assets/lotties/lottieSuccess.json',
                      textDialog: 'Success Saving Transaction',
                    );
                  },
                  buttonText: 'Save as Favorite',
                  textColor: primary90,
                  buttonFirstGradientColor: secondary0,
                  buttonSecondGradientColor: secondary0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
