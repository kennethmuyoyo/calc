class RegistrationValidation {
  static String? validateLogin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a login';
    }
    if (value.length < 3) {
      return 'Login must be at least 3 characters long';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  static String? validatePolynomial(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a polynomial';
    }
    String cleanedValue = value.replaceAll(' ', '');
    if (!RegExp(r'^(-?\d*x(\^-?\d+)?)?([+-]\d*x(\^-?\d+)?)*([+-]\d+)?$')
        .hasMatch(cleanedValue)) {
      return 'Invalid polynomial format';
    }
    return null;
  }
}
