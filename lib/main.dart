import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyCalculator());
  }
}

class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key}) : super(key: key);
  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  double num1 = 0.0;
  double num2 = 0.0;
  var input = "";
  var output = "";
  var operation = "";
  onbuttonclick(value) {
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userinput = input;
        userinput = input.replaceAll("X", "*");
        Parser p = Parser();
        Expression expression = p.parse(userinput);
        ContextModel cm = ContextModel();
        var finalval = expression.evaluate(EvaluationType.REAL, cm);
        output = finalval.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
      }
    } else {
      input = input + value;
    }
    setState(() {});
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            color: Colors.black,
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ]),
          )),
          Row(children: [Button("AC"), Button("<"), Button(""), Button("/")]),
          Row(children: [Button("7"), Button("8"), Button("9"), Button("X")]),
          Row(children: [Button("4"), Button("5"), Button("6"), Button("-")]),
          Row(children: [Button("1"), Button("2"), Button("3"), Button("+")]),
          Row(children: [Button("%"), Button("0"), Button("."), Button("=")]),
        ],
      ),
    );
  }

  Widget Button(text) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(8),
      child: Expanded(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(22),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                primary: Colors.grey.withOpacity(0.5)),
            onPressed: () {
              onbuttonclick(text);
            },
            child: Text(
              "$text",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
      ),
    ));
  }
}
