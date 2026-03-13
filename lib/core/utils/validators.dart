class Validators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? number(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    if (double.tryParse(value) == null) {
      return 'Enter a valid number';
    }
    return null;
  }

  static String? positiveNumber(String? value) {
    final numError = number(value);
    if (numError != null) return numError;
    if (double.parse(value!) <= 0) {
      return 'Value must be greater than zero';
    }
    return null;
  }
}
