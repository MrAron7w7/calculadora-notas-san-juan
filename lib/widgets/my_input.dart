import 'package:calcular_nota_sjb/themes/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/gg.dart';
import 'package:provider/provider.dart';

class MyInput extends StatefulWidget {
  final String textPc;
  final bool? isVisible;
  final String? textPor;

  final TextEditingController? controller;
  final void Function()? onPressed;
  const MyInput({
    super.key,
    required this.textPc,
    this.textPor = '15%',
    this.controller,
    this.onPressed,
    this.isVisible,
  });

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  Color _textColor = Colors.green;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_updateColor);
  }

  void _updateColor() {
    final textValue = widget.controller?.text ?? '';
    final number = double.tryParse(textValue);

    setState(() {
      if (number != null) {
        _textColor = number >= 10 ? Colors.green : Colors.red;
      } else {
        _textColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      //color: Colors.blue[100],
      width: size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: widget.controller,
              style: TextStyle(
                color: _textColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                floatingLabelAlignment: FloatingLabelAlignment.center,
                alignLabelWithHint: true,
                labelText: widget.textPc,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Configuracion de las notas del pc con el porcentaje de cada pc
          Row(
            children: [
              Visibility(
                visible: widget.isVisible ?? true,
                child: IconButton(
                  onPressed: widget.onPressed,
                  icon: Iconify(
                    Gg.options,
                    color:
                        themeChanger.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              Text(
                widget.textPor ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
