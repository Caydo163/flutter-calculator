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
            calcul = result;
          }
          break;

        default:
          {
            if (calcul == "0") calcul = "";
            calcul += txt;
          }
          break;
      }

      if (calcul.isNotEmpty) {
        expression = calcul.replaceAll("÷", "/").replaceAll("×", "*");
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          // String resultat = exp.evaluate(EvaluationType.REAL, cm);
          // if(resultat%1)

          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
          if (result.substring(result.length - 2, result.length) == ".0") {
            result = result.substring(0, result.length - 2);
          }
        } catch (e) {}
      }
    });
  }

  Widget calculatriceButton(
      String txt, Color couleurText, Color couleurBouton) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height * 0.1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: MaterialButton(
          color: couleurBouton,
          padding: EdgeInsets.all(7),
          onPressed: () => ButtonPressed(txt),
          child: Text(
            txt,
            style: TextStyle(
                color: couleurText,
                fontSize: 25,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      // appBar: AppBar(
      //   title: Text("Calculatrice"),
      //   centerTitle: true,
      // ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(20, 80, 10, 0),
            child: Text(
              calcul,
              style: TextStyle(fontSize: 40, color: Colors.deepPurple),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(20, 40, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: 30, color: Colors.deepPurple[300]),
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
                      calculatriceButton("C", Colors.white, Colors.green),
                      calculatriceButton("DEL", Colors.white, Colors.red),
                      calculatriceButton("%", Colors.white, Colors.purple),
                      calculatriceButton("÷", Colors.white, Colors.purple),
                    ]),
                    TableRow(children: [
                      calculatriceButton(
                          "7", Colors.deepPurple.shade300, Colors.white),
                      calculatriceButton(
                          "8", Colors.deepPurple.shade300, Colors.white),
                      calculatriceButton(
                          "9", Colors.deepPurple.shade300, Colors.white),
                      calculatriceButton("×", Colors.white, Colors.purple),
                    ]),
                    TableRow(children: [
                      calculatriceButton(
                          "4", Colors.deepPurple.shade300, Colors.white),
                      calculatriceButton(
                          "5", Colors.deepPurple.shade300, Colors.white),
                      calculatriceButton(
                          "6", Colors.deepPurple.shade300, Colors.white),
                      calculatriceButton("-", Colors.white, Colors.purple),
                    ]),
                    TableRow(children: [
                      calculatriceButton(
                          "1", Colors.deepPurple.shade300, Colors.white),
                      calculatriceButton(
                          "2", Colors.deepPurple.shade300, Colors.white),
                      calculatriceButton(
                          "3", Colors.deepPurple.shade300, Colors.white),
                      calculatriceButton("+", Colors.white, Colors.purple),
                    ]),
                    TableRow(children: [
                      calculatriceButton(
                          ".", Colors.deepPurple.shade300, Colors.white),
                      calculatriceButton(
                          "0", Colors.deepPurple.shade300, Colors.white),
                      calculatriceButton(
                          "00", Colors.deepPurple.shade300, Colors.white),
                      calculatriceButton(
                          "=", Colors.white, Colors.purple.shade700),
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
