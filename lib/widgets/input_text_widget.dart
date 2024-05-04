import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final IconData? prefixIcon;
  final String? assetRefrence;
  final String lableText;
  final bool isObscure;
  const InputTextWidget({
    Key? key,
    required this.textEditingController,
    this.prefixIcon,
    this.assetRefrence,
    required this.lableText,
    required this.isObscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: lableText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon)
            : Padding(
                padding: EdgeInsets.all(8),
                child: Image.asset(
                  assetRefrence!,
                  width: 10,
                ),
              ),
        labelStyle: const TextStyle(fontSize: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      obscureText: isObscure,
    );
  }
}
