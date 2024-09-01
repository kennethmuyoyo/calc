import 'package:flutter/material.dart';

class AnimatedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isValid;
  final String? Function(String?) validator;
  final Function(String) onChanged;
  final bool isPassword;
  final VoidCallback? onToggleVisibility;
  final bool isPasswordVisible;

  const AnimatedTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.isValid,
    required this.validator,
    required this.onChanged,
    this.isPassword = false,
    this.onToggleVisibility,
    this.isPasswordVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isValid ? 60 : 80,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(icon),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: onToggleVisibility,
          )
              : null,
          errorText: isValid ? null : validator(controller.text),
        ),
        obscureText: isPassword && !isPasswordVisible,
        onChanged: onChanged,
      ),
    );
  }
}