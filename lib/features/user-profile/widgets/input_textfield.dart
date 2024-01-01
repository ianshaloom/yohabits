import 'package:flutter/material.dart';

class InputTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String errorText;
  final Icon? prefixIcon;
  final bool needsValidation;
  const InputTextFormField({
    Key? key,
    required this.controller,
    required this.needsValidation,
    required this.labelText,
    required this.hintText,
    required this.errorText,
    this.prefixIcon,
  }) : super(key: key);

  @override
  State<InputTextFormField> createState() => _InputTextFormFieldState();
}

class _InputTextFormFieldState extends State<InputTextFormField> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: widget.needsValidation
          ? (value) {
              if (value == null || value.isEmpty) {
                return widget.errorText;
              }
              return null;
            }
          : null,
    );
  }
}
