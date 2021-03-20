import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  String _output = "0";
  double num1 = 0.0,num2 = 0.0, total = 0.0;
  String operand = "";
  String lastPressed;

  add(double num1, double num2){
    if(num2!=null){
      return num1 + num2;
    }else{
      return num1 + num1;
    }
  }
  subtract(double num1, double num2){
    if(num2!=null){
      return num1 - num2;
    }else{
      return 0;
    }
  }
  multiply(double num1, double num2){
    if(num2!=null){
      return num1 * num2;
    }else{
      return num1 * num1;
    }
  }
  divide(double num1, double num2){
    if(num2!=null){
      return num1 / num2;
    }else{
      return 1;
    }
  }

  double makeCalculation(String text, double num1, double num2) {
    switch (text) {
      case "+":
        return add(num1, num2);
      case "-":
        return subtract(num1, num2);
      case "/":
        return divide(num1, num2);
      case "*":
        return multiply(num1, num2);
    }
  }

  setOutput(String output){
    double decimal = double.parse(output);
    setState(() {
      if(decimal %1 ==0){
        var split = output.split(".");
        _output = split[0];
      }else{
        output.replaceAll(".", ",");
        _output = output;
      }

    });
  }
  buttonPressed(String text) {
    if(text=="C"){

      num1 = 0.0;
      num2 = 0.0;
      total = 0.0;
      operand = "";
      lastPressed = "";

      setState(() {
        _output = "0";
      });
    }else if(text=="/" || text=="*" ||text=="+" ||text=="-"){
        if(!_output.startsWith("0")){
          if(num1==0.0){
            // print("1( num1 ): "+num1.toString());
            String replace = _output.replaceAll(",", ".");
            num1 = double.parse(replace);
          }
          else if(num1 != 0.0){
            String replace = _output.replaceAll(",", ".");
            num2 = double.parse(replace);
            double result = makeCalculation(text, num1, num2);
            num1 = result;
            num2 = 0.0;
            setOutput(num1.toString());
            // setState(() {
            //   _output = num1.toString();
            // });
            // print("2( num1 ): "+num1.toString());
          }

          operand = text;
          // _output = "0";
        }

    } else if(text == ","){
      if(!_output.contains(",")){
        setState(() {
          _output = _output + text;
        });
      }

    }
    else if(text=="00"){
      if(_output!="0"){
        setState(() {
          _output = _output + text;
        });

      }

    }
    else if(text == "+/-"){
        setState(() {
          if(_output.startsWith("-")){
            _output = _output.substring(1,_output.length);
          }else{
            _output = "-"+ _output;
          }

        });
    }
    else if(text == "%"){
      double result = double.parse(_output)/100;
      setState(() {
        _output = result.toString();
      });
    }
    else if(text == "="){
      // print("num1: "+num1.toString()+ "  output: "+_output);
    // print("num1: "+num1.toString()+"  last Pressed: "+operand+" _output: "+_output);
    if(num1 == 0.0 && isOperand(operand) && !_output.startsWith("0")){
      double result = makeCalculation(operand, double.parse(_output), null);
      // print("Result: "+result.toString());
      setOutput(result.toString());
    }
    else if(num1==double.parse(_output)){
          // print("num1: "+num1.toString()+"  num2: null");
          double result = makeCalculation(operand, num1, null);
          num1 = 0.0;
          num2 = 0.0;
          setOutput(result.toString());
          // setState(() {
          //   _output = num1.toString();
          // });
        }else{
          String replace = _output.replaceAll(",", ".");
          num2 = double.parse(replace);
          // print("num1: "+num1.toString()+"  num2: "+num2.toString());
          double result = makeCalculation(operand, num1, num2);
          num1 = 0.0;
          num2 = 0.0;
          setOutput(result.toString());
          // setState(() {
          //   _output = num1.toString();
          // });
        }
    }
    else if(isNumeric(text)){
      if(_output=="0" || _output=="0.0" || isOperand(lastPressed)){
        // num1 = double.parse(text);
        print("1");
        setState(() {
          _output = text;
        });
      }
      else{
        print("2");
        setState(() {
          _output = _output + text;
          // num1 = double.parse(text);
        });

      }
    }
    lastPressed = text;
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s) != null;
  }

  bool isOperand(String s){
    if(s == "+" || s == "-" ||s == "/" ||s == "*"){
      return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 2,
            child: Container(
              color: Color(0xFFD7FFCFF3),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 24.0,horizontal: 12.0),
              child: Text(_output,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.orbitron().fontFamily,
                  )),
            ),
          ),
         // SizedBox(height: 30,),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                  buildButton("C", Colors.grey),
                  buildButton("+/-",Colors.grey),
                  buildButton("%",Colors.grey),
                  buildButton("/",Colors.deepOrange),
                ],),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                  buildButton("1", Colors.black),
                  buildButton("2", Colors.black),
                  buildButton("3", Colors.black),
                  buildButton("*",Colors.deepOrange),
                ],),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [

                  buildButton("4", Colors.black),
                  buildButton("5", Colors.black),
                  buildButton("6", Colors.black),
                  buildButton("+",Colors.deepOrange),
                ],),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [

                  buildButton("7", Colors.black),
                  buildButton("8", Colors.black),
                  buildButton("9", Colors.black),
                  buildButton("-",Colors.deepOrange),
                ],),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                  buildButton("00", Colors.grey),
                  buildButton("0", Colors.black),
                  buildButton(",", Colors.grey),
                  buildButton("=",Colors.deepOrange),
                ],),
                // SizedBox(height: 30,)



              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Text("Enejan",
                style: TextStyle(
                  fontSize: 25,
                  // color: ,
                  fontFamily: GoogleFonts.orbitron().fontFamily,
                )
            ),
          ),
        ],
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  TextButton buildButton(String text, Color textColor) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor:MaterialStateProperty.all<Color>(text=="="?textColor:Colors.transparent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: text=="="?textColor:Colors.transparent),
        //
        ),),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Text(text,
          style: TextStyle(
              fontSize: 25,
              color: text=="="?Colors.white:textColor,
              fontFamily: GoogleFonts.orbitron().fontFamily,
              )
        ),
      ),
        onPressed: ()=>buttonPressed(text));
  }


  }



