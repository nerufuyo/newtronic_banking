String greetingsFunction() {
  final time = DateTime.now().hour;

  if (time < 12) {
    return 'Good Morning';
  } else if (time < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}
