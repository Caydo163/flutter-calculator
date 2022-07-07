import 'package:flutter/material.dart';

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
  Widget calculatriceButton(
      String txt, Color couleurText, Color couleurBouton) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      color: couleurBouton,
      child: MaterialButton(
        padding: EdgeInsets.all(16),
        onPressed: null,
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
              "0",
              style: TextStyle(fontSize: 35),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Text(
              "0",
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
