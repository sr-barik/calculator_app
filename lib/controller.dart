import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:get_storage/get_storage.dart';

class CalculatorController extends GetxController {
  var equation = "0".obs;
  var result = "0".obs;
  var equationFontSize = 38.0.obs;
  var resultFontSize = 48.0.obs;
  var isDarkMode = true.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = box.read('isDarkMode') ?? true;
  }

  buttonPressed(String buttonText) {
    if (buttonText == "AC") {
      equation.value = "0";
      result.value = "0";
      equationFontSize.value = 38.0;
      resultFontSize.value = 48.0;
    } else if (buttonText == "⌫") {
      equationFontSize.value = 48.0;
      resultFontSize.value = 38.0;
      equation.value = equation.value.substring(0, equation.value.length - 1);
      if (equation.value == "") {
        equation.value = "0";
      }
    } else if (buttonText == "=") {
      equationFontSize.value = 38.0;
      resultFontSize.value = 48.0;

      String expression = equation.value;
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');

      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        result.value = '${exp.evaluate(EvaluationType.REAL, cm)}';
      } catch (e) {
        result.value = "Error";
      }
    } else {
      equationFontSize.value = 48.0;
      resultFontSize.value = 38.0;
      if (equation.value == "0") {
        equation.value = buttonText;
      } else {
        equation.value = equation.value + buttonText;
      }
    }
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    box.write('isDarkMode', isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
