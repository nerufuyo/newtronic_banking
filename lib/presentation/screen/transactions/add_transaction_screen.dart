import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:newtronic_banking/common/constants.dart';
import 'package:newtronic_banking/data/repository/repository.dart';
import 'package:newtronic_banking/presentation/screen/transactions/status_transaction_screen.dart';
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
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController bankNumberController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController transferController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final List<Map<String, String>> banks = [];
  final List<Map<String, String>> balances = [];
  final List<Map<String, String>> tempBank = [];
  final List<Map<String, String>> tempBalance = [];

  late TabController tabController;
  int pageIndex = 0;
  String errorText = '';
  String transferErrorText = '';
  String typeErrorText = '';
  String noteErrorText = '';
  String accountName = '';
  String accountNumber = '';
  String accountBalance = '';

  void initializeTabController() {
    tabController =
        TabController(length: addTransactionScreenTabbar.length, vsync: this);
  }

  void fetchData() async {
    final bank = await Repository().getBanks();
    final balance = await Repository().getBalances();

    for (var i = 0; i < balance.length; i++) {
      setState(
        () => balances.add({
          'id': balance[i].id.toString(),
          'name': balance[i].cardName,
          'number': balance[i].cardNumber,
          'balance': balance[i].balance,
        }),
      );
    }

    for (var i = 0; i < bank.length; i++) {
      setState(
        () => banks.add({
          'id': bank[i].id.toString(),
          'name': bank[i].name,
          'number': bank[i].number,
          'image': bank[i].image,
        }),
      );
    }

    setState(() {
      accountName = balances[0]['name']!;
      accountNumber = balances[0]['number']!;
      accountBalance = balances[0]['balance']!;
      typeController.text = 'BI-FAST';
    });
  }

  @override
  void initState() {
    fetchData();
    initializeTabController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    bankNameController.dispose();
    bankNumberController.dispose();
    searchController.dispose();
    tabController.dispose();
    super.dispose();
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
              _buildHeader(context),
              customSpaceVertical(16),
              _buildContent(),
              _buildButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (pageIndex == 1) {
              pageController.animateToPage(0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn);
            } else {
              Navigator.pop(context);
            }
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 24,
            color: primary90,
          ),
        ),
        customSpaceVertical(16),
        customText(textValue: 'New Transfer', textStyle: headline1),
      ],
    );
  }

  Expanded _buildContent() {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        onPageChanged: (value) => setState(() => pageIndex = value),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, pageIndex) {
          switch (pageIndex) {
            case 0:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildTabBar(),
                  customSpaceVertical(16),
                  _buildTabBarView(context),
                ],
              );
            case 1:
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildWalletTiles(),
                    customSpaceVertical(66),
                    TextField(
                      controller: transferController,
                      style: headline5.copyWith(color: text),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(
                              () => transferErrorText = 'Transfer is empty');
                        } else {
                          final numericValue = int.tryParse(value);
                          if (numericValue == null) {
                            setState(() => transferErrorText = 'Invalid input');
                          } else if (numericValue < 10000 ||
                              numericValue > 500000000) {
                            setState(() => transferErrorText =
                                'Transfer must be between Rp 10.000 and Rp 500.000.000');
                          } else {
                            setState(() => transferErrorText = '');
                          }
                        }
                      },
                      decoration: InputDecoration(
                        errorText: transferErrorText.isEmpty
                            ? null
                            : transferErrorText,
                        hintText: 'Nominal Transfer',
                        hintStyle: bodyText2.copyWith(color: text),
                        prefix: customText(
                          textValue: 'Rp. ',
                          textStyle: headline5.copyWith(color: text),
                        ),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: secondary20),
                        ),
                      ),
                    ),
                    customSpaceVertical(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          textValue: 'Saldo $accountName',
                          textStyle: subHeadline5.copyWith(
                              color: text.withOpacity(.5)),
                        ),
                        customText(
                          textValue: 'Rp. $accountBalance',
                          textStyle: subHeadline5.copyWith(
                              color: text.withOpacity(.5)),
                        ),
                      ],
                    ),
                    customSpaceVertical(16),
                    TextField(
                      controller: typeController,
                      style: headline5.copyWith(color: text),
                      onChanged: (value) {
                        if (value.length > 20) {
                          setState(() => typeErrorText =
                              'Notes maximum length is 20 characters');
                        } else {
                          setState(() => typeErrorText = '');
                        }
                      },
                      decoration: InputDecoration(
                        enabled: false,
                        suffixText: 'Rp. 2.500',
                        suffixStyle: bodyText2.copyWith(color: Colors.green),
                        label: customText(
                          textValue: 'Transaction Type',
                          textStyle: bodyText2.copyWith(color: text),
                        ),
                        errorText: typeErrorText.isEmpty ? null : typeErrorText,
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: secondary20),
                        ),
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: secondary20),
                        ),
                      ),
                    ),
                    customSpaceVertical(16),
                    TextField(
                      controller: noteController,
                      style: headline5.copyWith(color: text),
                      onChanged: (value) {
                        if (value.length > 20) {
                          setState(() => noteErrorText =
                              'Notes maximum length is 20 characters');
                        } else {
                          setState(() => noteErrorText = '');
                        }
                      },
                      decoration: InputDecoration(
                        errorText: noteErrorText.isEmpty ? null : noteErrorText,
                        hintText: 'Note (Optional)',
                        hintStyle: bodyText2.copyWith(color: text),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: secondary20),
                        ),
                      ),
                    ),
                  ],
                ),
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
    );
  }

  ListView _buildWalletTiles() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) => customSpaceVertical(8),
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, tileIndex) => InkWell(
        onTap: () {
          if (tileIndex == 0) {
            customShowAccountLists(context);
          }
        },
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: tileIndex == 0
                ? Image.asset(
                    'lib/assets/images/newtronic.png',
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    imageUrl: tempBank[0]['image']!,
                    placeholder: (context, url) => Image.asset(
                      'lib/assets/images/profile.jpg',
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
          ),
          title: customText(
            textValue: tileIndex == 0 ? accountName : 'Rafeh Qazi',
            textStyle: headline5,
          ),
          subtitle: customText(
            textValue: tileIndex == 0
                ? accountNumber
                : '${bankNameController.text}\n${bankNumberController.text.substring(0, 4)} **** **** ${bankNumberController.text.substring(8, 12)}',
            textStyle: bodyText2.copyWith(color: text),
          ),
          trailing: tileIndex == 0
              ? const Icon(Icons.keyboard_arrow_down_rounded)
              : null,
        ),
      ),
    );
  }

  Container _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: secondary10.withOpacity(.5),
      ),
      padding: const EdgeInsets.all(4),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: secondary0),
        labelColor: text,
        unselectedLabelColor: text.withOpacity(.25),
        tabs: List.generate(
          addTransactionScreenTabbar.length,
          (index) => Tab(text: addTransactionScreenTabbar[index]),
        ),
      ),
    );
  }

  Expanded _buildTabBarView(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: List.generate(
          tabController.length,
          (index) {
            switch (index) {
              case 0:
                return Column(
                  children: [
                    InkWell(
                      onTap: () => customDraggableModalBottomSheet(context),
                      child: TextField(
                        controller: bankNameController,
                        style: subHeadline5.copyWith(color: text),
                        decoration: InputDecoration(
                          enabled: false,
                          hintText: 'Bank Name',
                          hintStyle: bodyText2.copyWith(color: text),
                          suffixIcon:
                              const Icon(Icons.keyboard_arrow_down_rounded),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: secondary20),
                          ),
                          disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: secondary20),
                          ),
                        ),
                      ),
                    ),
                    customSpaceVertical(16),
                    TextField(
                      controller: bankNumberController,
                      style: subHeadline5.copyWith(color: text),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        if (value.length < 12 || value.length > 12) {
                          setState(
                              () => errorText = 'Account number must be 12');
                        } else {
                          setState(() => errorText = '');
                        }
                      },
                      decoration: InputDecoration(
                        errorText: errorText.isEmpty ? null : errorText,
                        hintText: 'Account Number',
                        hintStyle: bodyText2.copyWith(color: text),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: secondary20),
                        ),
                      ),
                    ),
                  ],
                );
              default:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(
                        'lib/assets/lotties/lottieAsk.json',
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                      customSpaceVertical(16),
                      customText(
                        textValue:
                            'You don\'t have any favorite transactions yet',
                        textStyle: subHeadline4.copyWith(
                          color: text.withOpacity(.5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  InkWell _buildButton(BuildContext context) {
    return customButton(
      buttonOnTap: () {
        switch (pageIndex) {
          case 0:
            if (bankNameController.text.isNotEmpty &&
                bankNumberController.text.isNotEmpty &&
                errorText.isEmpty) {
              pageController.animateToPage(1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn);
            }
            break;
          case 1:
            if (transferController.text.isNotEmpty &&
                transferErrorText.isEmpty &&
                typeErrorText.isEmpty &&
                noteErrorText.isEmpty) {
              customDialogWithButton(
                context,
                dialogTextValue: 'Are you sure want to transfer?',
                dialogAction: () {
                  final List<Map<String, String>> transactionStatus = [
                    {
                      'nominal': transferController.text,
                      'bank': bankNameController.text,
                      'number': bankNumberController.text,
                      'image': tempBank[0]['image']!,
                      'type': typeController.text,
                      'ref': '1696 2200 4022 5002',
                      'admin': 'Rp. 2.500',
                      'total':
                          'Rp. ${int.parse(transferController.text) + 2500}',
                    }
                  ];
                  Navigator.pop(context);
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pop(context);
                  }).then((value) => Navigator.pushNamed(
                      context, StatusTransactionScreen.routeName,
                      arguments: transactionStatus));
                  customDialog(
                    context,
                    animationIcon: 'lib/assets/lotties/lottieSuccess.json',
                    textDialog: 'Transfer Success',
                  );
                },
              );
            }
            break;
        }
      },
      buttonText: pageIndex == 0 ? 'Next' : 'Confirm',
      buttonWidth: MediaQuery.of(context).size.width,
      buttonFirstGradientColor: pageIndex == 0 &&
              bankNameController.text.isNotEmpty &&
              bankNumberController.text.isNotEmpty &&
              errorText.isEmpty
          ? primary80
          : (pageIndex == 1 &&
                  transferController.text.isNotEmpty &&
                  transferErrorText.isEmpty &&
                  typeErrorText.isEmpty &&
                  noteErrorText.isEmpty)
              ? primary80
              : secondary20,
      buttonSecondGradientColor: pageIndex == 0 &&
              bankNameController.text.isNotEmpty &&
              bankNumberController.text.isNotEmpty &&
              errorText.isEmpty
          ? primary90
          : (pageIndex == 1 &&
                  transferController.text.isNotEmpty &&
                  transferErrorText.isEmpty &&
                  typeErrorText.isEmpty &&
                  noteErrorText.isEmpty)
              ? primary90
              : secondary20,
    );
  }

  Future<dynamic> customShowAccountLists(BuildContext context) {
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
                  textValue: 'Select Bank',
                  textStyle: headline5,
                ),
                customSpaceVertical(16),
                customTextField(
                  controller: searchController,
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
                      itemCount: banks.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          setState(() {
                            if (tempBalance.isNotEmpty) {
                              tempBalance.clear();
                              accountName = balances[index]['name']!;
                              accountNumber = balances[index]['number']!;
                            }
                          });
                          Navigator.pop(context);
                        },
                        child: ListTile(
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.asset(
                                  'lib/assets/images/newtronic.png')),
                          title: customText(
                            textValue: balances[index]['name']!,
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

  Future<dynamic> customDraggableModalBottomSheet(BuildContext context) {
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
                  textValue: 'Select Bank',
                  textStyle: headline5,
                ),
                customSpaceVertical(16),
                customTextField(
                  controller: searchController,
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
                      itemCount: banks.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          setState(() {
                            if (tempBank.isNotEmpty) tempBank.clear();
                            bankNameController.text = banks[index]['name']!;
                            tempBank.add({
                              'id': banks[index]['id']!,
                              'name': banks[index]['name']!,
                              'number': banks[index]['number']!,
                              'image': banks[index]['image']!,
                            });
                          });
                          Navigator.pop(context);
                        },
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: CachedNetworkImage(
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
                              imageUrl: banks[index]['image']!,
                              placeholder: (context, url) => Image.asset(
                                'lib/assets/images/profile.jpg',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          title: customText(
                            textValue: banks[index]['name']!,
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
}
