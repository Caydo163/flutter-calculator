import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculatrice());
}

class Calculatrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculatrice",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculatrice(),
    );
  }
}

class SimpleCalculatrice extends StatefulWidget {
  @override
  _SimpleCalculatriceState createState() => _SimpleCalculatriceState();
}

class _SimpleCalculatriceState extends State<SimpleCalculatrice> {
  String calcul = "";
  String result = "";
  String expression = "";

  ButtonPressed(String txt) {
    setState(() {
      switch (txt) {
        case "C":
          {
            calcul = "";
            result = "";
          }
          break;

        case "DEL":
          {
            if (calcul.length > 1) {
              calcul = calcul.substring(0, calcul.length - 1);
            } else {
              calcul = "";
            }
          }
          break;

        case "+":
          {
            if (calcul.isNotEmpty) {
              String lastCarac =
                  calcul.substring(calcul.length - 1, calcul.length);
              if (lastCarac != "+" && calcul != "0") {
                if (lastCarac == "×" ||
                    lastCarac == "÷" ||
                    lastCarac == "-" ||
                    lastCarac == "%") {
                  calcul = calcul.substring(0, calcul.length - 1) + txt;
                } else {
                  calcul += txt;
                }
              }
            }
          }
          break;

        case "-":
          {
            if (calcul.isNotEmpty) {
              String lastCarac =
                  calcul.substring(calcul.length - 1, calcul.length);
              if (lastCarac != "-" && calcul != "0") {
                if (lastCarac == "×" ||
                    lastCarac == "÷" ||
                    lastCarac == "+" ||
                    lastCarac == "%") {
                  calcul = calcul.substring(0, calcul.length - 1) + txt;
                } else {
                  calcul += txt;
                }
              }
            }
          }
          break;

        case "×":
          {
            if (calcul.isNotEmpty) {
              String lastCarac =
                  calcul.substring(calcul.length - 1, calcul.length);
              if (lastCarac != "×" && calcul != "0") {
                if (lastCarac == "+" ||
                    lastCarac == "÷" ||
                    lastCarac == "-" ||
                    lastCarac == "%") {
                  calcul = calcul.substring(0, calcul.length - 1) + txt;
                } else {
                  calcul += txt;
                }
              }
            }
          }
          break;

        case "÷":
          {
            if (calcul.isNotEmpty) {
              String lastCarac =
                  calcul.substring(calcul.length - 1, calcul.length);
              if (lastCarac != "÷" && calcul != "0") {
                if (lastCarac == "×" ||
                    lastCarac == "+" ||
                    lastCarac == "-" ||
                    lastCarac == "%") {
                  calcul = calcul.substring(0, calcul.length - 1) + txt;
                } else {
                  calcul += txt;
                }
              }
            }
          }
          break;

        case "%":
          {
            if (calcul.isNotEmpty) {
              String lastCarac =
                  calcul.substring(calcul.length - 1, calcul.length);
              if (lastCarac != "%" && calcul != "0") {
                if (lastCarac == "×" ||
                    lastCarac == "÷" ||
                    lastCarac == "-" ||
                    lastCarac == "+") {
                  calcul = calcul.substring(0, calcul.length - 1) + txt;
                } else {
                  calcul += txt;
                }
              }
            }
          }
          break;

        case ".":
          {
            if (calcul.isNotEmpty) {
              String lastCarac =
                  calcul.substring(calcul.length - 1, calcul.length);
              if (lastCarac != "." &&
                  lastCarac != "%" &&
                  lastCarac != "×" &&
                  lastCarac != "÷" &&
                  lastCarac != "-" &&
                  lastCarac != "+") {
                calcul += txt;
              }
            }
          }
          break;

        case "=":
          {
            if (calcul.isNotEmpty) {
              expression = calcul.replaceAll("÷", "/").replaceAll("×", "*");
              try {
                Parser p = Parser();
                Expression exp = p.parse(expression);
                ContextModel cm = ContextModel();

                result = "${exp.evaluate(EvaluationType.REAL, cm)}";
              } catch (e) {
                result = "Erreur";
              }
            }
          }
          break;
        default:
          {
            if (calcul == "0") calcul = "";
            calcul += txt;
          }
          break;
      }
    });
  }

  Widget calculatriceButton(
      String txt, Color couleurText, Color couleurBouton) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      color: couleurBouton,
      child: MaterialButton(
        padding: EdgeInsets.all(16),
        onPressed: () => ButtonPressed(txt),
        child: Text(
          txt,
          style: TextStyle(
              color: couleurText, fontSize: 30, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculatrice"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Text(
              calcul,
              style: TextStyle(fontSize: 35),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: 25, color: Colors.grey[600]),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Table(
                  children: [
                    TableRow(children: [
                      calculatriceButton("C", Colors.redAccent, Colors.white),
                      calculatriceButton("DEL", Colors.blue, Colors.white),
                      calculatriceButton("%", Colors.blue, Colors.white),
                      calculatriceButton("÷", Colors.blue, Colors.white),
                    ]),
                    TableRow(children: [
                      calculatriceButton("7", Colors.blue, Colors.white),
                      calculatriceButton("8", Colors.blue, Colors.white),
                      calculatriceButton("9", Colors.blue, Colors.white),
                      calculatriceButton("×", Colors.blue, Colors.white),
                    ]),
                    TableRow(children: [
                      calculatriceButton("4", Colors.blue, Colors.white),
                      calculatriceButton("5", Colors.blue, Colors.white),
                      calculatriceButton("6", Colors.blue, Colors.white),
                      calculatriceButton("-", Colors.blue, Colors.white),
                    ]),
                    TableRow(children: [
                      calculatriceButton("1", Colors.blue, Colors.white),
                      calculatriceButton("2", Colors.blue, Colors.white),
                      calculatriceButton("3", Colors.blue, Colors.white),
                      calculatriceButton("+", Colors.blue, Colors.white),
                    ]),
                    TableRow(children: [
                      calculatriceButton(".", Colors.blue, Colors.white),
                      calculatriceButton("0", Colors.blue, Colors.white),
                      calculatriceButton("00", Colors.blue, Colors.white),
                      calculatriceButton("=", Colors.white, Colors.blue),
                    ]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
