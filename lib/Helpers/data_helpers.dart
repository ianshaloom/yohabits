import 'dart:math';

class DataHelpers {
  static String generateCode(int length) {
    const String charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    String code = '';

    for (int i = 0; i < length; i++) {
      int randomIndex = random.nextInt(charset.length);
      code += charset[randomIndex];
    }

    return code;
  }

  static String getGreetings() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
