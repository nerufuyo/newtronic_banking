import 'package:flutter/material.dart';
import 'package:newtronic_banking/common/constants.dart';
import 'package:newtronic_banking/presentation/widget/components.dart';
import 'package:newtronic_banking/styles/pallet.dart';
import 'package:newtronic_banking/styles/typography.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.id});
  static const routeName = '/home-screen';
  final int id;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary80,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              _buildTaBar(),
              customSpaceVertical(16),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  color: secondary0,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Container(
                      child: Center(
                        child: customText(
                          textValue: 'Tab 1',
                          textStyle: headline1,
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: customText(
                          textValue: 'Tab 2',
                          textStyle: headline1,
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: customText(
                          textValue: 'Tab 3',
                          textStyle: headline1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TabBar _buildTaBar() {
    return TabBar(
      controller: tabController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: secondary0,
      ),
      labelColor: primary80,
      unselectedLabelColor: secondary0,
      tabs: List.generate(
        homeScreenTabbar.length,
        (index) => Tab(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(homeScreenTabbar[index]['icon']),
              customSpaceHorizontal(4),
              customText(
                textValue: homeScreenTabbar[index]['name'].toString(),
                textStyle: subHeadline5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
