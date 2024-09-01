import 'package:flutter_test/flutter_test.dart';
import 'package:polynomial_calculator/core/utils/calculate_derivative.dart';

void main() {
  group('CalculateDerivative', () {
    test('calculate correctly derives simple polynomial', () {
      expect(CalculateDerivative.calculate('3x^2+2x+1'), '6x + 2');
    });

    test('calculate correctly derives polynomial with higher powers', () {
      expect(CalculateDerivative.calculate('x^3+x^2+x'), '3x^2 + 2x + 1');
    });

    test('calculate correctly derives polynomial with only x term', () {
      expect(CalculateDerivative.calculate('5x'), '5');
    });

    test('calculate correctly derives polynomial with only constant term', () {
      expect(CalculateDerivative.calculate('7'), '');
    });

    test('calculate correctly handles coefficient of 1', () {
      expect(CalculateDerivative.calculate('x^2+x'), '2x + 1');
    });
  });
}