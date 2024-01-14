import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: GestureDetector(
        onTap: () {},
        child: Center(
            child: Container(
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color.fromARGB(255, 95, 150, 244)),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        )),
      ),
    );
  }
}
