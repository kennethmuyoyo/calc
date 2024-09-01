import 'package:flutter_test/flutter_test.dart';
import 'package:polynomial_calculator/core/utils/registration_validation.dart';

void main() {
  group('RegistrationValidation', () {
    test('validateLogin returns error for empty input', () {
      expect(RegistrationValidation.validateLogin(''), isNotNull);
    });

    test('validateLogin returns error for short input', () {
      expect(RegistrationValidation.validateLogin('ab'), isNotNull);
    });

    test('validateLogin returns null for valid input', () {
      expect(RegistrationValidation.validateLogin('validlogin'), isNull);
    });

    test('validatePassword returns error for empty input', () {
      expect(RegistrationValidation.validatePassword(''), isNotNull);
    });

    test('validatePassword returns error for short input', () {
      expect(RegistrationValidation.validatePassword('short'), isNotNull);
    });

    test('validatePassword returns error for input without uppercase', () {
      expect(RegistrationValidation.validatePassword('password123'), isNotNull);
    });

    test('validatePassword returns error for input without number', () {
      expect(RegistrationValidation.validatePassword('Password'), isNotNull);
    });

    test('validatePassword returns null for valid input', () {
      expect(RegistrationValidation.validatePassword('ValidPassword123'), isNull);
    });

    test('validatePolynomial returns error for empty input', () {
      expect(RegistrationValidation.validatePolynomial(''), isNotNull);
    });

    test('validatePolynomial returns error for invalid input', () {
      expect(RegistrationValidation.validatePolynomial('not a polynomial'), isNotNull);
    });

    test('validatePolynomial returns null for valid input', () {
      expect(RegistrationValidation.validatePolynomial('3x^2+2x+1'), isNull);
    });
  });
}