import 'package:calculator/constant/app_string.dart';
import 'package:calculator/view/calculatorview/calculator_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => CalculatorViewModel(),
        builder: (context, viewModel, child) {
          return SafeArea(
            bottom: false,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Container(
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  "${viewModel.number1}${viewModel.operator}${viewModel.number2}"
                                          .isEmpty
                                      ? "0"
                                      : "${viewModel.number1}${viewModel.operator}${viewModel.number2}",
                                  style: TextStyle(fontSize: 50),
                                ),
                              )),
                        ),
                      ),
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: Btn.buttonValues
                          .map(
                            (value) => Container(
                              width: value == Btn.n0
                                  ? screenSize.width / 2.2
                                  : (screenSize.width / 4.4),
                              height: screenSize.width / 4.5,
                              child: viewModel.buildButton(value),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
