import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habot/shared/widgets/app_text_field.dart';

class VerificationFieldByt extends StatelessWidget {
  const VerificationFieldByt({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.onInteraction,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.enabled = true,
    this.maxLength,
    this.inputFormatters,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final VoidCallback? onInteraction;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final bool enabled;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        if (focused) {
          onInteraction?.call();
        }
      },
      child: AppTextField(
        label: label,
        hint: hint,
        controller: controller,
        validator: validator,
        enabled: enabled,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        onChanged: (_) => onInteraction?.call(),
        onTap: onInteraction,
      ),
    );
  }
}
