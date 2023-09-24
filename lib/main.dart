import 'package:flutter/material.dart';
import 'package:newtronic_banking/presentation/screen/auth/authentication_screen.dart';
import 'package:newtronic_banking/presentation/screen/main/home_screen.dart';
import 'package:newtronic_banking/presentation/screen/splash_screen.dart';
import 'package:newtronic_banking/presentation/screen/transactions/add_transaction_screen.dart';
import 'package:newtronic_banking/presentation/screen/transactions/status_transaction_screen.dart';
import 'package:newtronic_banking/presentation/screen/transactions/transaction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Newtronic Banking',
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case SplashScreen.routeName:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case AuthenticationScreen.routeName:
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const AuthenticationScreen(),
              transitionDuration: const Duration(milliseconds: 400),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          case HomeScreen.routeName:
            final args = settings.arguments;
            final id = args as int;
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => HomeScreen(id: id),
              transitionDuration: const Duration(milliseconds: 400),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          case TransactionScreen.routeName:
            return MaterialPageRoute(builder: (_) => const TransactionScreen());
          case AddTransactionScreen.routeName:
            return MaterialPageRoute(
                builder: (_) => const AddTransactionScreen());
          case StatusTransactionScreen.routeName:
            final transactionStatus =
                settings.arguments as List<Map<String, String>>;
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) =>
                  StatusTransactionScreen(transactionStatus: transactionStatus),
              transitionDuration: const Duration(milliseconds: 400),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );

          default:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
        }
      },
    );
  }
}
