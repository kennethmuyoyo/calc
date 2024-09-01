import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/registration_validation.dart';
import '../../../../core/utils/calculate_derivative.dart';
import '../../domain/entiities/user_registration.dart';
import '../bloc/user_registration_bloc.dart';
import '../bloc/user_registration_event.dart';
import '../bloc/user_registration_state.dart';
import '../pages/registration_success.dart';
import 'animated_text.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm>
    with SingleTickerProviderStateMixin {
  bool _isLoginValid = false;
  bool _isPasswordValid = false;
  bool _isPolynomialValid = false;
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _polynomialController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    _polynomialController.dispose();
    super.dispose();
  }

  void _updateLoginValidity(String value) {
    setState(() {
      _isLoginValid = RegistrationValidation.validateLogin(value) == null;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _updatePasswordValidity(String value) {
    setState(() {
      _isPasswordValid = RegistrationValidation.validatePassword(value) == null;
    });
  }

  void _updatePolynomialValidity(String value) {
    setState(() {
      _isPolynomialValid =
          RegistrationValidation.validatePolynomial(value) == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: BlocConsumer<UserRegistrationBloc, UserRegistrationState>(
        listener: (context, state) {
          if (state is UserRegistrationSuccess) {
            final derivative =
            CalculateDerivative.calculate(_polynomialController.text);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    RegistrationSuccessPage(derivative: derivative),
              ),
            );
          } else if (state is UserRegistrationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedTextField(
                  controller: _loginController,
                  label: 'Login',
                  icon: Icons.person,
                  isValid: _isLoginValid,
                  validator: RegistrationValidation.validateLogin,
                  onChanged: _updateLoginValidity,
                ),
                const SizedBox(height: 24),
                AnimatedTextField(
                  controller: _passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  isValid: _isPasswordValid,
                  validator: RegistrationValidation.validatePassword,
                  onChanged: _updatePasswordValidity,
                  isPassword: true,
                  isPasswordVisible: _isPasswordVisible,
                  onToggleVisibility: _togglePasswordVisibility,
                ),
                const SizedBox(height: 24),
                AnimatedTextField(
                  controller: _polynomialController,
                  label: 'Polynomial (3x^2 + 2x + 1)',
                  icon: Icons.functions,
                  isValid: _isPolynomialValid,
                  validator: RegistrationValidation.validatePolynomial,
                  onChanged: _updatePolynomialValidity,
                ),
                SizedBox(height: 24),
                _buildSubmitButton(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubmitButton(UserRegistrationState state) {
    final isLoading = state is UserRegistrationLoading;
    return SizedBox(
      height: 50,
      width: isLoading ? 50 : double.infinity,
      child: ElevatedButton(
        onPressed: (state is! UserRegistrationLoading &&
            _isLoginValid &&
            _isPasswordValid &&
            _isPolynomialValid)
            ? () {
          final derivative = CalculateDerivative.calculate(_polynomialController.text);
          context.read<UserRegistrationBloc>().add(
            SubmitRegistrationEvent(
              UserRegistration(
                login: _loginController.text,
                password: _passwordController.text,
                polynomial: _polynomialController.text,
                derivative: derivative,
              ),
            ),
          );
        }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : const Text(
          'Submit',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}