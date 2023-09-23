import 'package:flutter/material.dart';
import 'package:newtronic_banking/styles/pallet.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});
  static const routeName = '/transaction';

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
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
      body: Container(),
    );
  }
}
