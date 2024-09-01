class CalculateDerivative {
  static String calculate(String polynomial) {
    List<String> terms = polynomial.replaceAll(' ', '').split('+');
    List<String> derivativeTerms = [];

    for (String term in terms) {
      if (!term.contains('x')) continue;

      if (term.contains('^')) {
        List<String> parts = term.split('^');
        int exponent = int.parse(parts[1]);
        String coefficient = parts[0].replaceAll('x', '');

        if (coefficient.isEmpty) coefficient = '1';
        int newCoefficient = int.parse(coefficient) * exponent;
        int newExponent = exponent - 1;

        if (newExponent > 1) {
          derivativeTerms.add('${newCoefficient}x^$newExponent');
        } else if (newExponent == 1) {
          derivativeTerms.add('${newCoefficient}x');
        } else {
          derivativeTerms.add('$newCoefficient');
        }
      } else {
        String coefficient = term.replaceAll('x', '');
        if (coefficient.isEmpty) coefficient = '1';
        derivativeTerms.add(coefficient);
      }
    }

    return derivativeTerms.join(' + ');
  }
}