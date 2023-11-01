import 'dart:math'; // Import math library for sqrt (akar kuadrat) function

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _output = "0";
  String _currentInput = "";
  String _currentOperator = "";
  double _firstOperand = 0;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentInput = "";
        _currentOperator = "";
        _firstOperand = 0;
      } else if (buttonText == "+/-") {
        // Toggle the sign of the current input
        _currentInput = (double.parse(_currentInput) * -1).toString();
        _output = _currentInput;
      } else if (buttonText == "%") {
        // Calculate percentage of the current input
        double percentage = double.parse(_currentInput) / 100;
        _currentInput = percentage.toString();
        _output = _currentInput;
      } else if (buttonText == "=") {
        if (_currentInput.isNotEmpty && _currentOperator.isNotEmpty) {
          // Calculate the result
          double secondOperand = double.parse(_currentInput);
          if (_currentOperator == "+") {
            _currentInput = (_firstOperand + secondOperand).toString();
          } else if (_currentOperator == "-") {
            _currentInput = (_firstOperand - secondOperand).toString();
          } else if (_currentOperator == "x") {
            _currentInput = (_firstOperand * secondOperand).toString();
          } else if (_currentOperator == "/") {
            if (secondOperand != 0) {
              _currentInput = (_firstOperand / secondOperand).toString();
            } else {
              _output = "Error";
              return;
            }
          } else if (_currentOperator == "^") {
            _currentInput = pow(_firstOperand, secondOperand).toString();
          }
          _output = _currentInput;
          _currentOperator = "";
        }
      } else if ("+-x/".contains(buttonText)) {
        if (_currentInput.isNotEmpty && _currentOperator.isEmpty) {
          _firstOperand = double.parse(_currentInput);
          _currentOperator = buttonText;
          _currentInput = "";
        }
      } else if (buttonText == "^") {
        if (_currentInput.isEmpty) return;
        _firstOperand = double.parse(_currentInput);
        _currentOperator = buttonText;
        _currentInput = "";
      } else if (buttonText == "√") {
        if (_currentInput.isEmpty) return;
        double input = double.parse(_currentInput);
        _currentInput = sqrt(input).toString();
        _output = _currentInput;
      } else {
        _currentInput += buttonText;
        _output = _currentInput;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kalkulator'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            // ...widget buttons
            // Tombol-tombol kalkulator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildButton("7"),
                _buildButton("8"),
                _buildButton("9"),
                _buildButton("/"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildButton("4"),
                _buildButton("5"),
                _buildButton("6"),
                _buildButton("x"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildButton("1"),
                _buildButton("2"),
                _buildButton("3"),
                _buildButton("-"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildButton("C"),
                _buildButton("0"),
                _buildButton("+/-"),
                _buildButton("+"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildButton("%"),
                _buildButton("="),
                _buildButton("^"),
                _buildButton("√"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
