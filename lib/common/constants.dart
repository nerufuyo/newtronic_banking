import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final List signUpTextFieldProperties = [
  {
    'hintText': 'Full Name',
    'icon': Icons.person_2_rounded,
    'type': TextInputType.name,
    'suffixIcon': false,
    'inputFormatters': <TextInputFormatter>[],
  },
  {
    'hintText': 'Username',
    'icon': Icons.verified_user_rounded,
    'type': TextInputType.name,
    'suffixIcon': false,
    'inputFormatters': <TextInputFormatter>[
      FilteringTextInputFormatter.deny(RegExp(r'\s'))
    ],
  },
  {
    'hintText': 'Email',
    'icon': Icons.email_rounded,
    'type': TextInputType.emailAddress,
    'suffixIcon': false,
    'inputFormatters': <TextInputFormatter>[
      FilteringTextInputFormatter.deny(RegExp(r'\s'))
    ],
  },
  {
    'hintText': 'Password',
    'icon': Icons.lock_rounded,
    'type': TextInputType.visiblePassword,
    'suffixIcon': true,
    'inputFormatters': <TextInputFormatter>[],
  },
  {
    'hintText': 'Confirm Password',
    'icon': Icons.lock_rounded,
    'type': TextInputType.visiblePassword,
    'suffixIcon': true,
    'inputFormatters': <TextInputFormatter>[],
  },
];

final List logInTextFieldProperties = [
  {
    'hintText': 'Email or Username',
    'icon': Icons.email_rounded,
    'type': TextInputType.name,
    'suffixIcon': false,
    'inputFormatters': <TextInputFormatter>[
      FilteringTextInputFormatter.deny(RegExp(r'\s'))
    ],
  },
  {
    'hintText': 'Password',
    'icon': Icons.lock_rounded,
    'type': TextInputType.visiblePassword,
    'suffixIcon': true,
    'inputFormatters': <TextInputFormatter>[],
  },
];

final List homeScreenTabbar = [
  {'name': 'Tracker', 'icon': Icons.pie_chart},
  {'name': 'Home', 'icon': Icons.home_rounded},
  {'name': 'Porto', 'icon': Icons.badge_rounded},
];

final homeScreenContentTabbar = ['Account', 'Card'];

final List transactionScreenTabbar = ['Accounts', 'Favorites', 'Autodebit'];
final List addTransactionScreenTabbar = ['Accounts', 'Favorites'];
