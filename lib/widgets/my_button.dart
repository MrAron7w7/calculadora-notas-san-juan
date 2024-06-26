import 'package:calcular_nota_sjb/themes/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        // .withOpacity(.7)
        //const Color(0xffE51821)
        style: ElevatedButton.styleFrom(
          backgroundColor: themeChanger.isDarkMode
              ? const Color(0xffE51821).withOpacity(.7)
              : const Color(0xffE51821),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
