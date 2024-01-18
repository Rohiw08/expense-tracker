import 'package:flutter/material.dart';

class TextInputCard extends StatelessWidget {
  const TextInputCard(
      {super.key,
      required TextEditingController titleController,
      required this.hintText,
      required this.keyBoardType})
      : _controller = titleController;

  final TextEditingController _controller;
  final String hintText;
  final TextInputType keyBoardType;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _controller,
          keyboardType: keyBoardType,
          maxLength: 50,
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            contentPadding: const EdgeInsets.only(top: 20, left: 12),
          ),
        ),
      ),
    );
  }
}
