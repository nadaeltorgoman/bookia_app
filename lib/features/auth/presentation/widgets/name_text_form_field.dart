import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameTextFormField extends StatelessWidget {
  const NameTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText,
    // this.filter,
    // this.length,
  });
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool? obscureText;
  // final TextInputFormatter? filter;
  // final int? length;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType ?? TextInputType.name,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      // inputFormatters: [
      //   filter ?? FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9@._-]+$')),
      //   LengthLimitingTextInputFormatter(length ?? 10),
      // ],
      decoration: InputDecoration(
        hintText: hintText ?? 'Enter your email',
        suffixIconConstraints: const BoxConstraints(minWidth: 50),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
