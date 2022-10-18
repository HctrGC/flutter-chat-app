import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  
  final void Function() onPressed;
  final String text;
  
  const BlueButton({
    super.key, 
    required this.onPressed,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        )
      ),
      onPressed: onPressed, 
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 17)
          )
        )
      )
    );
  }
}