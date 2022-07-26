// IMPORTATION _____________________________________________
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:fluttertoast/fluttertoast.dart';

// MAIN _____________________________________________
void main() {
  runApp(Calculatrice());
}

// CALCULATRICE _____________________________________________
class Calculatrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculatrice",
      theme: ThemeData(
          primarySwatch: Colors.blue, fontFamily: 'Montserrat Medium'),
      home: SimpleCalculatrice(),
    );
  }
}

// SIMPLE CALCULATRICE _____________________________________________
class SimpleCalculatrice extends StatefulWidget {
  @override
  _SimpleCalculatriceState createState() => _SimpleCalculatriceState();
}

// SIMPLE CALCULATRICE STATE ________________________________________
class _SimpleCalculatriceState extends State<SimpleCalculatrice> {
  // Initialisation variables
  String calcul = ""; // Calcul de l'utilisateur
  String result = ""; // Résultat du calcul
  bool equalMode =
      false; // Savoir si la variable calcul contient un calcul ou un résultat

  // Action des boutons de la calculatrice
  ButtonPressed(String txt) {
    setState(() {
      switch (txt) {
        case "C":
          {
            calcul = "";
            result = "";
            equalMode = false;
          }
          break;

        case "DEL":
          {
            if (calcul.length > 1) {
              calcul = calcul.substring(0, calcul.length - 1);
            } else {
              calcul = "";
              result = "";
            }
            equalMode = false;
          }
          break;

        case "+":
          {
            if (calcul.isNotEmpty) {
              String lastCarac =
                  calcul.substring(calcul.length - 1, calcul.length);
              if (lastCarac != "+" && calcul != "0") {
                if (isOperator(lastCarac)) {
                  calcul = calcul.substring(0, calcul.length - 1) + txt;
                } else {
                  calcul += txt;
                }
              }
              equalMode = false;
            }
          }
          break;

        case "-":
          {
            if (calcul.isNotEmpty) {
              String lastCarac =
                  calcul.substring(calcul.length - 1, calcul.length);
              if (lastCarac != "-" && calcul != "0") {
                if (isOperator(lastCarac)) {
                  calcul = calcul.substring(0, calcul.length - 1) + txt;
                } else {
                  calcul += txt;
                }
              }
              equalMode = false;
            }
          }
          break;

        case "×":
          {
            if (calcul.isNotEmpty) {
              String lastCarac =
                  calcul.substring(calcul.length - 1, calcul.length);
              if (lastCarac != "×" && calcul != "0") {
                if (isOperator(lastCarac)) {
                  calcul = calcul.substring(0, calcul.length - 1) + txt;
                } else {
                  calcul += txt;
                }
              }
              equalMode = false;
            }
          }
          break;

        case "÷":
          {
            if (calcul.isNotEmpty) {
              String lastCarac =
                  calcul.substring(calcul.length - 1, calcul.length);
              if (lastCarac != "÷" && calcul != "0") {
                if (isOperator(lastCarac)) {
                  calcul = calcul.substring(0, calcul.length - 1) + txt;
                } else {
                  calcul += txt;
                }
              }
              equalMode = false;
            }
          }
          break;

        case "%":
          {
            if (calcul.isNotEmpty) {
              String lastCarac =
                  calcul.substring(calcul.length - 1, calcul.length);
              if (lastCarac != "%" && calcul != "0") {
                if (isOperator(lastCarac)) {
                  calcul = calcul.substring(0, calcul.length - 1) + txt;
                } else {
                  calcul += txt;
                }
              }
              equalMode = false;
            }
          }
          break;

        case ".":
          {
            if (calcul.isNotEmpty) {
              String lastCarac =
                  calcul.substring(calcul.length - 1, calcul.length);
              if (lastCarac != "." && !isOperator(lastCarac)) {
                calcul += txt;
              }
              equalMode = false;
            }
          }
          break;

        case "=":
          {
            if (!isOperator(calcul.substring(calcul.length - 1))) {
              if (calcul.contains('+') ||
                  calcul.contains('-') ||
                  calcul.contains('÷') ||
                  calcul.contains('%') ||
                  calcul.contains('×')) {
                calcul = result;
              }
              result = "";
              equalMode = true;
            } else {
              Fluttertoast.showToast(
                msg: "Erreur de syntaxe",
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: const Color.fromARGB(209, 186, 51, 210),
                textColor: Colors.black,
              );
            }
          }
          break;

        default:
          {
            if (calcul == "0") calcul = "";
            if (equalMode) {
              calcul = "";
              equalMode = false;
            }
          }
          calcul += txt;
          break;
      }

      if (calcul.isNotEmpty && !equalMode) {
        try {
          // Calcul du résultat
          Parser p = Parser();
          Expression exp =
              p.parse(calcul.replaceAll("÷", "/").replaceAll("×", "*"));
          ContextModel cm = ContextModel();

          // On affiche le résultat
          String rep =
              "${double.parse((exp.evaluate(EvaluationType.REAL, cm)).toStringAsFixed(10))}";

          // Si '.0' ou '.' à la fin, on supprime
          if (rep.substring(rep.length - 2, rep.length) == ".0") {
            result = rep.substring(0, rep.length - 2);
          } else {
            if (rep.substring(rep.length - 1, rep.length) == ".") {
              result = rep.substring(0, rep.length - 1);
            } else {
              result = rep;
            }
          }
        } catch (e) {}
      }
    });
  }

  // Bouton de la calculatrice
  Widget calculatriceButton(
      String txt, Color couleurText, Color couleurBouton) {
    return Bounce(
      onPressed: () {
        ButtonPressed(txt);
      },
      duration: const Duration(milliseconds: 180),
      child: Container(
        margin: const EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            // color: Colors.blue,
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 5),
          )
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: couleurBouton,
            padding: const EdgeInsets.all(7),
            alignment: Alignment.center,
            child: Text(
              txt,
              style: TextStyle(
                  color: couleurText,
                  fontSize: 25,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }

  // Page de l'application
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepPurple[100],
      // appBar: AppBar(
      //   title: Text("Calculatrice"),
      //   centerTitle: true,
      // ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 226, 168, 236),
              Color.fromARGB(255, 181, 163, 184),
            ])),
        child: Column(
          children: [
            // Zone d'écriture (calcul et résultat)
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(20, 80, 10, 0),
                      child: Text(
                        calcul,
                        style: const TextStyle(
                            fontSize: 40, color: Colors.deepPurple),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.fromLTRB(20, 40, 10, 0),
                      child: Text(
                        result,
                        style: TextStyle(
                            fontSize: 30, color: Colors.deepPurple[300]),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Séparateur
            Divider(
              color: Colors.purple[200],
              indent: 15,
              endIndent: 15,
            ),

            // Zone de boutons
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
                        calculatriceButton("÷", Colors.white,
                            const Color.fromARGB(255, 156, 39, 176)),
                      ]),
                      TableRow(children: [
                        calculatriceButton(
                            "7", Colors.deepPurple.shade300, Colors.white),
                        calculatriceButton(
                            "8", Colors.deepPurple.shade300, Colors.white),
                        calculatriceButton(
                            "9", Colors.deepPurple.shade300, Colors.white),
                        calculatriceButton("×", Colors.white,
                            const Color.fromARGB(255, 156, 39, 176)),
                      ]),
                      TableRow(children: [
                        calculatriceButton(
                            "4", Colors.deepPurple.shade300, Colors.white),
                        calculatriceButton(
                            "5", Colors.deepPurple.shade300, Colors.white),
                        calculatriceButton(
                            "6", Colors.deepPurple.shade300, Colors.white),
                        calculatriceButton("-", Colors.white,
                            const Color.fromARGB(255, 156, 39, 176)),
                      ]),
                      TableRow(children: [
                        calculatriceButton(
                            "1", Colors.deepPurple.shade300, Colors.white),
                        calculatriceButton(
                            "2", Colors.deepPurple.shade300, Colors.white),
                        calculatriceButton(
                            "3", Colors.deepPurple.shade300, Colors.white),
                        calculatriceButton("+", Colors.white,
                            const Color.fromARGB(255, 156, 39, 176)),
                      ]),
                      TableRow(children: [
                        calculatriceButton(
                            ".", Colors.deepPurple.shade300, Colors.white),
                        calculatriceButton(
                            "0", Colors.deepPurple.shade300, Colors.white),
                        calculatriceButton(
                            "00", Colors.deepPurple.shade300, Colors.white),
                        calculatriceButton("=", Colors.white,
                            const Color.fromARGB(255, 57, 9, 74)),
                      ]),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// Vérifie si le caractère est un opérateur
/// Renvoie true si le caractère c est un opérateur
bool isOperator(String c) {
  return c == "%" || c == "-" || c == "+" || c == "×" || c == "÷";
}
