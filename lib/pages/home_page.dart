import 'package:calcular_nota_sjb/themes/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '/datas/calculate.dart';
import '/widgets/my_button.dart';
import '/widgets/my_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool darkMode = false;
  double total = 0.0;
  final double promedio = 0;
  final TextEditingController _pc1 = TextEditingController();
  final TextEditingController _pc2 = TextEditingController();
  final TextEditingController _pc3 = TextEditingController();
  final TextEditingController _pc4 = TextEditingController();
  final TextEditingController _final = TextEditingController();
  final TextEditingController _parcial = TextEditingController();

  @override
  void dispose() {
    _pc1.dispose();
    _pc2.dispose();
    _pc3.dispose();
    _pc4.dispose();
    _final.dispose();
    _parcial.dispose();
    super.dispose();
  }

  // Validamos que todos los inputs contenga algun valor
  bool _validateInputs() {
    return double.tryParse(_pc1.text) != null &&
        double.tryParse(_pc2.text) != null &&
        double.tryParse(_pc3.text) != null &&
        double.tryParse(_pc4.text) != null &&
        double.tryParse(_final.text) != null &&
        double.tryParse(_parcial.text) != null;
  }

  // Calculamos la nota final con la logica
  double _calculateFinalGrade() {
    double porcentaje15 = 0.15;
    double porcentaje20 = 0.2;
    return (double.parse(_pc1.text) * porcentaje15) +
        (double.parse(_pc2.text) * porcentaje15) +
        (double.parse(_pc3.text) * porcentaje15) +
        (double.parse(_pc4.text) * porcentaje15) +
        (double.parse(_parcial.text) * porcentaje20) +
        (double.parse(_final.text) * porcentaje20);
  }

  // Calculamos las notas ya con los modales
  void _calculateNotes() {
    if (!_validateInputs()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              '¡Error!',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'Por favor, rellena todos los campos',
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Aceptar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    double totalPromedio = _calculateFinalGrade();
    double notaAprobatoria = 10.5;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            alignment: Alignment.center,
            child: totalPromedio >= notaAprobatoria
                ? Lottie.asset(
                    'assets/lottie/check.json',
                    fit: BoxFit.fitHeight,
                    height: 200,
                    width: 200,
                  )
                : Lottie.asset(
                    'assets/lottie/wrong.json',
                    fit: BoxFit.fitHeight,
                    height: 200,
                    width: 200,
                  ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              totalPromedio >= notaAprobatoria
                  ? Text(
                      'Aprobaste',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.withAlpha(200)),
                    )
                  : Text(
                      'Desaprobaste',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.withAlpha(200)),
                    ),
              Text(
                totalPromedio.toStringAsFixed(2),
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );

    total = totalPromedio;
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _clearNotes() {
    _pc1.clear();
    _pc2.clear();
    _pc3.clear();
    _pc4.clear();
    _final.clear();
    _parcial.clear();
    setState(() {
      total = 0.0;
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void showModal({String? textPc}) {
    double height = MediaQuery.of(context).size.height * 0.5;
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: 50,
                height: 5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Text(
                'Notas $textPc',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeChanger = Provider.of<ThemeChanger>(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'MIS NOTAS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  darkMode = !darkMode;
                  themeChanger.toggleTheme();
                });
              },
              icon: darkMode
                  ? const Iconify(
                      MaterialSymbols.wb_sunny_rounded,
                      color: Color(0xffF4FCFE),
                    )
                  : const Iconify(MaterialSymbols.dark_mode),
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(12),
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                MyInput(
                  textPc: 'PC1',
                  controller: _pc1,
                  onPressed: () {
                    showModal(
                      textPc: 'PC1',
                    );
                  },
                ),
                const Gap(10),
                MyInput(
                  textPc: 'PC2',
                  controller: _pc2,
                  onPressed: () {
                    showModal(
                      textPc: 'PC2',
                    );
                  },
                ),
                const Gap(10),
                MyInput(
                  textPc: 'PC3',
                  controller: _pc3,
                  onPressed: () {
                    showModal(
                      textPc: 'PC3',
                    );
                  },
                ),
                const Gap(10),
                MyInput(
                  textPc: 'PC4',
                  controller: _pc4,
                  onPressed: () {
                    showModal(
                      textPc: 'PC4',
                    );
                  },
                ),
                const Gap(10),
                MyInput(
                  isVisible: false,
                  textPc: 'Parcial',
                  textPor: '20%',
                  controller: _parcial,
                ),
                const Gap(10),
                MyInput(
                  isVisible: false,
                  textPc: 'Final',
                  textPor: '20%',
                  controller: _final,
                ),
                const Gap(30),
                SizedBox(
                  width: size.width,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runSpacing: 10,
                    children: [
                      MyButton(
                        text: 'Calcular',
                        onPressed: _calculateNotes,
                      ),
                      MyButton(
                        text: 'Nuevo',
                        onPressed: _clearNotes,
                      ),
                      MyButton(
                        text: 'Notas faltantes',
                        onPressed: () {
                          Calculate calculate = Calculate();
                          double finalGrade = calculate.calculateNote(
                            double.tryParse(_pc1.text) ?? 0.0,
                            double.tryParse(_pc2.text) ?? 0.0,
                            double.tryParse(_pc3.text) ?? 0.0,
                            double.tryParse(_pc4.text) ?? 0.0,
                            double.tryParse(_final.text) ?? 0.0,
                            double.tryParse(_parcial.text) ?? 0.0,
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Resultado'),
                                content: Text('La nota final es: $finalGrade'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cerrar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
