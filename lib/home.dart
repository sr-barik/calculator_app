import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class HomeScreen extends StatelessWidget {
  final CalculatorController calcController = Get.put(CalculatorController());

  Widget buildButton(String buttonText, Color buttonColor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            padding: EdgeInsets.all(22.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () => calcController.buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final numberButtonColor = isDarkMode ? Colors.black54 : Colors.black54;
    final operatorButtonColor = isDarkMode ? Colors.blue : Colors.blue;
    final equalsButtonColor = isDarkMode ? Colors.redAccent : Colors.redAccent;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final iconColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10.0),
              child: Obx(
                () => IconButton(
                  icon: Icon(calcController.isDarkMode.value
                      ? Icons.wb_sunny
                      : Icons.nights_stay),
                  color: iconColor,
                  onPressed: () {
                    calcController.toggleTheme();
                  },
                ),
              ),
            ),
          ),
          Obx(
            () => Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                calcController.equation.value,
                style: TextStyle(
                    fontSize: calcController.equationFontSize.value,
                    color: textColor),
              ),
            ),
          ),
          Obx(
            () => Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                calcController.result.value,
                style: TextStyle(
                    fontSize: calcController.resultFontSize.value,
                    color: textColor),
              ),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildButton("AC", operatorButtonColor),
                  buildButton("⌫", operatorButtonColor),
                  buildButton("%", operatorButtonColor),
                  buildButton("÷", operatorButtonColor),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildButton("7", numberButtonColor),
                  buildButton("8", numberButtonColor),
                  buildButton("9", numberButtonColor),
                  buildButton("×", operatorButtonColor),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildButton("4", numberButtonColor),
                  buildButton("5", numberButtonColor),
                  buildButton("6", numberButtonColor),
                  buildButton("-", operatorButtonColor),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildButton("1", numberButtonColor),
                  buildButton("2", numberButtonColor),
                  buildButton("3", numberButtonColor),
                  buildButton("+", operatorButtonColor),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildButton("0", numberButtonColor),
                  buildButton(".", numberButtonColor),
                  buildButton("=", equalsButtonColor),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
