import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/utils/check_arabic_text.dart';
import 'package:khlfan_shtain/viewmodel/textfield_viewmodel.dart';

import '../providers/textfield_provider.dart';


class TextFieldWidget extends ConsumerWidget {
  const TextFieldWidget({
    required this.controller,
    required this.hint,
    required this.keyboardType,
    this.isPassword,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final bool? isPassword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(textFieldProvider);
    final textDirectionProvider = Provider<TextDirection>((ref) {
      final text =controller.text;
      return text.isArabic ? TextDirection.rtl : TextDirection.ltr;
    });

    return Consumer(builder: (context, ref, child) {
      final textDirection = ref.watch(textDirectionProvider);

      return TextFormField(
        controller: controller,
        onChanged: (value) {
          provider.changeTextDirection(value);
          // ref.watch(textFieldProvider.notifier).changeTextDirection(value);
        },
        textDirection: textDirection, // Use the retrieved text direction here
        keyboardType: keyboardType,
        obscureText: isPassword == true ? provider.obscureTextValue : false,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          suffixIcon: isPassword == true
              ? IconButton(
            icon: Icon(provider.obscureTextValue == true
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: () {
              provider.obscureText();
            },
          )
              : null,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          hintStyle: TextStyle(
            color:
            Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            fontWeight: FontWeight.w200,
            fontSize: 17,
          ),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
      );
    });
  }
}
