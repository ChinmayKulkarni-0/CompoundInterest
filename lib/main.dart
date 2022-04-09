// ignore_for_file: deprecated_member_use, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:slide_to_confirm/slide_to_confirm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interest Calculator',
      theme:
          ThemeData(primarySwatch: Colors.teal, accentColor: Colors.tealAccent),
      home: Form(),
    );
  }
}

class Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {
  // controller
  TextEditingController principalTextEditingController =
      TextEditingController();
  TextEditingController rateofInterestTextEditingController =
      TextEditingController();
  TextEditingController termTextEditingController = TextEditingController();

  // currencices

  String result = "";
  final String _character = "";
  String currentValue = "";
  String nv = "";
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Compound Interest Calculator",
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            //image
            getImage(),

            Row(
              children: <Widget>[
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: ListTile(
                    title: Text(
                      "Coumpound Interest",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                )),
                Container(
                  width: 5.0,
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                controller: principalTextEditingController,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "Principal",
                    hintText: "Enter a principal amount e.g, 1099",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                controller: rateofInterestTextEditingController,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "Rate of Interest",
                    hintText: "Enter a rate per year",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
            ),

            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      controller: termTextEditingController,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          labelText: "Term",
                          hintText: "Enter number of year",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ),
                ),
                Container(
                  width: 10,
                ),

                // dropdown menu
                Expanded(child: Text("Rs")),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ConfirmationSlider(
                    text: "Calculate",
                    textStyle: TextStyle(color: Colors.black),
                    onConfirmation: () => confirmed()
                    // SwipeButton(),
                    // Expanded(
                    //   child: LiteRollingSwitch(
                    //     value: true,
                    //     textOn: 'active',
                    //     textOff: 'inactive',
                    //     colorOn: Colors.deepOrange,
                    //     colorOff: Colors.blueGrey,
                    //     iconOn: Icons.lightbulb_outline,
                    //     iconOff: Icons.power_settings_new,
                    //     onChanged: (bool state) {
                    //       print('turned ${(state) ? 'on' : 'off'}');
                    //     },
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Expanded(
                    //       child: RaisedButton(
                    //     color: Colors.tealAccent,
                    //     textColor: Colors.black,
                    //     child: const Text(
                    //       "RESET",
                    //       style: TextStyle(fontSize: 15),
                    //     ),
                    //     onPressed: () {
                    //       _reset();
                    //     },
                    //   )),
                    // ),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ConfirmationSlider(
                    text: "Reset",
                    textStyle: TextStyle(color: Colors.black),
                    onConfirmation: () => _reset()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void confirmed() {
    this.result = _getEffectiveAmount(this.nv);
    onDialogOpen(context, this.result);
    print(result);
  }

  void _setSelectedValue(String newValue) {
    setState(() {
      this.currentValue = newValue;
    });
  }

  String _getEffectiveAmount(String newValue) {
    String newResult;
    double principal = double.parse(principalTextEditingController.text);
    double rate = double.parse(rateofInterestTextEditingController.text);
    double term = double.parse(termTextEditingController.text);

    double netpayableAmount = 0;

    netpayableAmount = principal * pow((1 + (rate / 100)), term);
    if (term == 1) {
      newResult = "Error";
    } else {
      newResult =
          "In $term year, you will have = ${netpayableAmount.toStringAsFixed(2)} Rs";
    }
    return newResult;
  }

  void _reset() {
    principalTextEditingController.text = "";
    rateofInterestTextEditingController.text = "";
    termTextEditingController.text = "";
    result = "";
  }

  // dialog box

  void onDialogOpen(BuildContext context, String s) {
    var alertDialog = AlertDialog(
      title: const Text("Empty"),
      content: Text(s),
      backgroundColor: Colors.green,
      elevation: 8.0,
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(s),
          );
        });
  }
}

Widget getImage() {
  NetworkImage assetImage = const NetworkImage(
      "https://media-exp1.licdn.com/dms/image/C4E0BAQF7DpVxCjBbew/company-logo_200_200/0/1637047537893?e=2147483647&v=beta&t=S0SqhNTXuf_EsPfoc4hzsd8njzWuyf76Atb9Q_pWiyw");
  Image image = Image(
    image: assetImage,
    width: 150,
    height: 150,
  );

  return Container(
    child: Column(children: [image, const Text("Ventura Securities Ltd")]),
  );
}
