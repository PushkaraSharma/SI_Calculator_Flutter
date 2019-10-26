import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'SI Calculator',
    home: SIform(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.green,
      accentColor: Colors.lightGreenAccent,
      buttonColor: Colors.lightGreen,
      brightness: Brightness.dark,
    ),
  ));
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIformstate();
  }
}

class SIformstate extends State<SIform> {
  final minpad = 5.0;
  var currencies = ['Rupees', 'Dollar', 'Pound', 'Yen'];
  var currentItem = 'Rupees';
  TextEditingController principal = TextEditingController();
  TextEditingController roi = TextEditingController();
  TextEditingController time = TextEditingController();
  var displayresult = '';
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle txtstyle = Theme.of(context).textTheme.title;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('SI Calculator'),
      ),
      body: Form(
          key: formkey,
          child: Padding(
            padding: EdgeInsets.all(minpad * 2),
            //margin: EdgeInsets.all(minpad * 2),
            child: ListView(
              children: <Widget>[
                ImageMoney(),
                Padding(
                    padding: EdgeInsets.only(top: minpad, bottom: minpad),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter principal ammount';
                        }
                      },
                      controller: principal,
                      style: txtstyle,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Principal',
                          labelStyle: txtstyle,
                          hintText: 'Enter amount eg 15000',
                          errorStyle: TextStyle(color: Colors.lightGreenAccent),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: minpad, bottom: minpad),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter Rate of Interest';
                        }
                      },
                      controller: roi,
                      style: txtstyle,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Rate of Interest',
                          labelStyle: txtstyle,
                          hintText: 'Enter interest in percent eg 10',
                          errorStyle: TextStyle(color: Colors.lightGreenAccent),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: minpad, bottom: minpad),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter Time';
                            }
                          },
                          controller: time,
                          style: txtstyle,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Time',
                              labelStyle: txtstyle,
                              hintText: 'Enter Time in years',
                              errorStyle:
                                  TextStyle(color: Colors.lightGreenAccent),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                        Container(
                          width: minpad * 5.0,
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            items: currencies.map((String dropdownstringitem) {
                              return DropdownMenuItem<String>(
                                value: dropdownstringitem,
                                child: Text(
                                  dropdownstringitem,
                                  style: txtstyle,
                                ),
                              );
                            }).toList(),
                            onChanged: (String newV) {
                              setState(() {
                                this.currentItem = newV;
                              });
                            },
                            value: currentItem,
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(top: minpad * 10, bottom: minpad),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                        child: Text(
                          "Calculate",
                          style: txtstyle,
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            if (formkey.currentState.validate()) {
                              this.displayresult = calculations();
                            }
                          });
                        },
                        elevation: 8.0,
                      )),
                      Container(
                        width: minpad * 5.0,
                      ),
                      Expanded(
                          child: RaisedButton(
                        child: Text(
                          "Reset",
                          style: txtstyle,
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            reset();
                          });
                        },
                        elevation: 8.0,
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: minpad * 5, bottom: minpad),
                  child: Text(
                    this.displayresult,
                    style: txtstyle,
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget ImageMoney() {
    AssetImage im = AssetImage('images/money.png');
    Image image = Image(
      image: im,
      width: 100,
      height: 100,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(minpad * 10.0),
    );
  }

  String calculations() {
    double p = double.parse(principal.text);
    double r = double.parse(roi.text);
    double t = double.parse(time.text);
    double newprincipal = p + ((p * r * t) / 100);
    String ti = time.text;
    String result =
        "After $ti years your principal amount will be $newprincipal $currentItem ";
    return result;
  }

  void reset() {
    principal.text = '';
    roi.text = '';
    time.text = '';
    displayresult = '';
  }
}
