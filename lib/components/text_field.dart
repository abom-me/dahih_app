import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/utils/check_arabic_text.dart';
import 'package:khlfan_shtain/viewmodel/textfield_viewmodel.dart';

import '../providers/textfield_provider.dart';

class TextFieldWidget extends ConsumerStatefulWidget {
  const TextFieldWidget({
    required this.controller,
    required this.hint,
    required this.keyboardType,
    this.isPassword,
    this.inputFormatters,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final bool? isPassword;
final List<TextInputFormatter>? inputFormatters;
  @override
  ConsumerState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends ConsumerState<TextFieldWidget> {
  bool obscureTextValue = true;

  @override
  Widget build(BuildContext context) {


    return TextFormField(
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      onChanged: (value) {
        setState(() {});
      },
      textDirection: widget.controller.text.isArabic
          ? TextDirection.rtl
          : TextDirection.ltr,

      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword == true ? obscureTextValue : false,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
      decoration: InputDecoration(
        suffixIcon: widget.isPassword == true
            ? IconButton(
                icon: Icon(obscureTextValue == true
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    obscureTextValue = !obscureTextValue;
                  });
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
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          fontWeight: FontWeight.w200,
          fontSize: 17,
        ),
        hintText: widget.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
    );
  }
}
