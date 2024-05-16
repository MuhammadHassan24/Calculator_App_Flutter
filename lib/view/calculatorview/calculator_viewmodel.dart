import 'package:calculator/constant/app_string.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CalculatorViewModel extends BaseViewModel {
  String number1 = "";
  String operator = "";
  String number2 = "";
  void onBtnTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
      return;
    }

    if (value == Btn.per) {
      convertToPercentage();
      return;
    }

    if (value == Btn.calculate) {
      calculate();
      return;
    }

    appendValue(value);
    rebuildUi();
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap: () {
            onBtnTap(value);
          },
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void calculate() {
    if (number1.isEmpty) return;
    if (operator.isEmpty) return;
    if (number2.isEmpty) return;

    final double num1 = double.parse(number1);
    final double num2 = double.parse(number2);

    num result = 0;
    switch (operator) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
      case Btn.per:
        result = num1 % num2;
        break;
      default:
    }

    number1 = result.toStringAsFixed(2);

    operator = "";
    number2 = "";
    rebuildUi();
  }

  // ##############
  // converts output to %
  dynamic convertToPercentage() {
    // ex: 434+324

    if (operator.isNotEmpty) {
      // cannot be converted
      return;
    }

    final number = double.parse(number1);

    number1 = "${(number / 100)}";
    operator = "";
    number2 = "";
  }

  // ##############
  // clears all output
  void clearAll() {
    number1 = "";
    operator = "";
    number2 = "";
    rebuildUi();
  }

  // ##############
  // delete one from the end
  void delete() {
    if (number2.isNotEmpty) {
      // 12323 => 1232
      number2 = number2.substring(0, number2.length - 1);
    } else if (operator.isNotEmpty) {
      operator = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }
    rebuildUi();
  }

  // #############
  // appends value to the end
  void appendValue(String value) {
    // number1 opernad number2
    // 234       +      5343

    // if is operator and not "."
    if (value != Btn.dot && int.tryParse(value) == null) {
      // operator pressed
      if (operator.isNotEmpty && number2.isNotEmpty) {
        // TODO calculate the equation before assigning new operator
        calculate();
      }
      operator = value;
    }
    // assign value to number1 variable
    else if (number1.isEmpty || operator.isEmpty) {
      // check if value is "." | ex: number1 = "1.2"
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
        // ex: number1 = "" | "0"
        value = "0.";
      }
      number1 += value;
      rebuildUi();
    }
    // assign value to number2 variable
    else if (number2.isEmpty || operator.isNotEmpty) {
      // check if value is "." | ex: number1 = "1.2"
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
        // number1 = "" | "0"
        value = "0.";
      }
      number2 += value;
      rebuildUi();
    }
  }

  Color getBtnColor(value) {
    return [Btn.del, Btn.clr].contains(value)
        ? Colors.blueGrey
        : [
            Btn.per,
            Btn.multiply,
            Btn.add,
            Btn.subtract,
            Btn.divide,
            Btn.calculate,
          ].contains(value)
            ? Colors.orange
            : Colors.black87;
  }
}
