import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabbar/tabbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:intl/intl.dart';

String capitalize(word) {
  return "${word[0].toUpperCase()}${word.substring(1)}";
}

//const yTarget = {
//  "albay-opv" : 6,
//  "albay-hybrid" : 6,
//  "bukidnon-opv" : 6,
//  "bukidnon-hybrid" : 6,
//  "cebu-opv" : 6,
//  "cebu-hybrid" : 6,
//  "iloilo-opv" : 6,
//  "iloilo-hybrid" : 6,
//  "isabela-opv" : 6,
//  "isabela-hybrid" : 6,
//  "nueva ecija-opv" : 8.72,
//  "nueva ecija-hybrid" : 8.72,
//};

//const ySupply = {
//  "albay-opv" : 2.4,
//  "albay-hybrid" : 2.4,
//  "bukidnon-opv" : 2.92,
//  "bukidnon-hybrid" : 2.92,
//  "cebu-opv" : 1.86,
//  "cebu-hybrid" : 1.86,
//  "iloilo-opv" : 2.34,
//  "iloilo-hybrid" : 2.34,
//  "isabela-opv" :2.11,
//  "isabela-hybrid" : 2.11,
//  "nueva ecija-opv" : 1.66,
//  "nueva ecija-hybrid" : 1.66,
//};

const nRemoval = {
  "albay-opv" : {
    "n" : 16,
    "p" : 2.8,
    "k" : 4.0
  },
  "albay-hybrid" : {
    "n" : 15.6,
    "p" : 2.9,
    "k" : 3.8
  },
  "bukidnon-opv" : {
    "n" : 16,
    "p" : 2.8,
    "k" : 4.0
  },
  "bukidnon-hybrid" : {
    "n" : 15.6,
    "p" : 2.9,
    "k" : 3.8
  },
  "cebu-opv" : {
    "n" : 16,
    "p" : 2.8,
    "k" : 4.0
  },
  "cebu-hybrid" : {
    "n" : 15.6,
    "p" : 2.9,
    "k" : 3.8
  },
  "iloilo-opv" : {
    "n" : 16,
    "p" : 2.8,
    "k" : 4.0
  },
  "iloilo-hybrid" : {
    "n" : 15.6,
    "p" : 2.9,
    "k" : 3.8
  },
  "isabela-opv" : {
    "n" : 16,
    "p" : 2.8,
    "k" : 4.0
  },
  "isabela-hybrid" : {
    "n" : 15.6,
    "p" : 2.9,
    "k" : 3.8
  },
  "nueva ecija-opv" : {
    "n" : 16,
    "p" : 2.8,
    "k" : 4.0
  },
  "nueva ecija-hybrid" : {
    "n" : 15.6,
    "p" : 2.9,
    "k" : 3.8
  },
};

const fRecovery = {
  "albay-opv" : {
    "n" : 0.5,
    "p" : 0.3,
    "k" : 0.5
  },
  "albay-hybrid" : {
    "n" : 0.5,
    "p" : 0.3,
    "k" : 0.5
  },
  "bukidnon-opv" : {
    "n" : 0.5,
    "p" : 0.3,
    "k" : 0.5
  },
  "bukidnon-hybrid" : {
    "n" : 0.5,
    "p" : 0.3,
    "k" : 0.5
  },
  "cebu-opv" : {
    "n" : 0.5,
    "p" : 0.3,
    "k" : 0.5
  },
  "cebu-hybrid" : {
    "n" : 0.5,
    "p" : 0.3,
    "k" : 0.5
  },
  "iloilo-opv" : {
    "n" : 0.5,
    "p" : 0.3,
    "k" : 0.5
  },
  "iloilo-hybrid" : {
    "n" : 0.5,
    "p" : 0.3,
    "k" : 0.5
  },
  "isabela-opv" : {
    "n" : 0.5,
    "p" : 0.3,
    "k" : 0.5
  },
  "isabela-hybrid" : {
    "n" : 0.5,
    "p" : 0.3,
    "k" : 0.5
  },
  "nueva ecija-opv" : {
    "n" : 0.5,
    "p" : 0.3,
    "k" : 0.5
  },
  "nueva ecija-hybrid" : {
    "n" : 0.5,
    "p" : 0.3,
    "k" : 0.5
  },
};

const fType = {
  "complete": [.14,.14,.14],
  "muriateOfPotash": [0,0,.6],
  "solophos": [0, .18, 0],
  "ammophosphate": [.16,.2,0],
  "urea": [.46, 0, 0],
  "ammosulphate": [.21,0,0]
};

const prices={
  "complete": 1211.84,
  "urea": 1230.57,
  "ammosulphate": 886.58,
  "ammophosphate": 1009.09,
  "muriateOfPotash": 1262.50,
  "solophos": 980.00,
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green,     //  <-- dark color
          textTheme: ButtonTextTheme.primary, //  <-- this auto selects the right color
        )
      ),
      home: MyHomePage(title: 'Nutrient Manager App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _areaController = new TextEditingController();
  TextEditingController _tyController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String site, variety, municipality, brgy, growingSeason;
  double ySupply;
  String _choice = 'Yes';
  List<String> municipalities = [], brgys = [];

  void process(area,ch,caseCH,yTarget,growingSeason) async {
    final ProgressDialog pr = ProgressDialog(context, isDismissible: false);

    pr.style(
      message: 'Processing values'
    );

    await pr.show();

    var place_index = {
      'albay' : 9,
      'bukidnon' : 16,
      'cebu' : 23,
      'iloilo' : 30,
      'isabela' : 37,
      'nueva ecija' : 44,
    };
    var growingSeasonIndex = (growingSeason == "Dry") ? 0 : 2;

    var response =
        await http.get('https://spreadsheets.google.com/feeds/cells/17gN4VZB7jIh5MX9uXISDS9IIl_vvRZr2WfB6r9iulEM/od6/public/basic?alt=json');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var gsheets = json.decode(response.body);
      ySupply = double.parse(gsheets['feed']['entry'][place_index[ch.split('-')[0]] + growingSeasonIndex]['content']['\$t']);
      print(ySupply);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load indigenous supply');
    }

    var AMF1, AMF2, AMF3;

    var frrN = (((yTarget-ySupply)*nRemoval[ch]['n'])/fRecovery[ch]['n']) * area;
    var frrP = (((yTarget-ySupply)*nRemoval[ch]['p'])/fRecovery[ch]['p']) * area;
    var frrK = (((yTarget-ySupply)*nRemoval[ch]['k'])/fRecovery[ch]['k']) * area;

    AMF1 = frrK / fType[caseCH[0]][2];

    if(caseCH[1] == "solophos"){
      if(caseCH[0] == "muriateOfPotash"){
        AMF2 = frrP / fType[caseCH[1]][1];
        AMF3 = frrN / fType[caseCH[2]][0];
      }else{
        AMF2 = (frrP - frrK) / fType[caseCH[1]][1];
        AMF3 = (frrN - frrK) / fType[caseCH[2]][0];
      }
    }
    else if (caseCH[1] == "ammophosphate"){
      AMF2 = ((frrP-frrK) / fType[caseCH[1]][1]) * fType[caseCH[1]][0];

      AMF3 = (frrN-frrK-AMF2) / fType[caseCH[2]][0];
    }

    List<String> forN=[],forP=[],forK=[];

    for(var i=0 ; i<=2; i++){
      if(fType[caseCH[i]][0] != 0)
        forN.add(caseCH[i]);

      if(fType[caseCH[i]][1] != 0)
        forP.add(caseCH[i]);

      if(fType[caseCH[i]][2] != 0)
        forK.add(caseCH[i]);
    }

    List<double> frr_target = [frrN,frrP,frrK];

    List<double> AMF = [AMF1,AMF2,AMF3];

    await pr.hide();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage(forN:forN, forP:forP, forK: forK, AMF: AMF, caseCH: caseCH, area: area, ch: ch, frr_target: frr_target, yTarget: yTarget, ySupply: ySupply)),
    );

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Text('Nutrient Manager', style: TextStyle(color: Colors.white))
            ),
            Image.asset(
              'assets/dost-pcaarrd-uplb.png',
              fit: BoxFit.contain,
              height: 30,
            ),

          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        validator: (value) => value == null ? 'field required' : null,
                        isExpanded: true,
                        value: site,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize:15),
                        hint: Text('Province'),
                        onChanged: (String newValue) {
                          setState(() {
                            if(site != newValue){
                              site = newValue;
                              municipality = null;
                              brgy = null;
                              if(site == "Albay"){
                                municipalities = ['Ligao City'];
                              }else if(site == "Bukidnon"){
                                municipalities = ['Maramag'];
                              }else if(site == "Cebu"){
                                municipalities = ['Barili'];
                              }else if(site == "Iloilo"){
                                municipalities = ['Lambunao'];
                              }else if(site == "Isabela"){
                                municipalities = ['Echague'];
                              }else if(site == "Nueva Ecija"){
                                municipalities = ['Lupao'];
                              }
                            }
                          });
                        },
                        items: <String>[
                          'Albay',
                          'Bukidnon',
                          'Cebu',
                          'Iloilo',
                          'Isabela',
                          'Nueva Ecija'
                        ]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButtonFormField<String>(
                        validator: (value) => value == null ? 'field required' : null,
                        isExpanded: true,
                        value: municipality,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize:15),
                        hint: Text('Municipality'),
                        onChanged: (String newValue) {
                          setState(() {
                            if(municipality != newValue){
                              municipality = newValue;
                              brgy = null;
                              if(municipality == "Ligao City"){
                                brgys = ['Tuburan'];
                              }else if(municipality == "Maramag"){
                                brgys = ['Dologon'];
                              }else if(municipality == "Barili"){
                                brgys = ['Bagakay'];
                              }else if(municipality == "Lambunao"){
                                brgys = ['Agsirab'];
                              }else if(municipality == "Echague"){
                                brgys = ['Pag-asa'];
                              }else if(municipality == "Lupao"){
                                brgys = ['Parista'];
                              }
                            }
                          });
                        },
                        items: municipalities
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButtonFormField<String>(
                        validator: (value) => value == null ? 'field required' : null,
                        isExpanded: true,
                        value: brgy,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize:15),
                        hint: Text('Barangay'),
                        onChanged: (String newValue) {
                          setState(() {
                            brgy = newValue;
                          });
                        },
                        items: brgys
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButtonFormField<String>(
                        validator: (value) => value == null ? 'field required' : null,
                        isExpanded: true,
                        value: growingSeason,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize:15),
                        hint: Text('Growing Season'),
                        onChanged: (String newValue) {
                          setState(() {
                            growingSeason = newValue;
                          });
                        },
                        items: <String>[
                          'Dry',
                          'Wet',
                        ]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        keyboardType: TextInputType.number,
                        //autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Area (ha)'),
                        controller: _areaController,
                      ),
                      TextFormField(
                        validator: (val) {
                          if(val.isEmpty) {
                            return 'field requried';
                          }
                          if(double.parse(val) < 1 || double.parse(val) > 20) {
                            return 'Please only enter values from 1-20';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        //autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Target Yield (t/ha)'),
                        controller: _tyController,
                      ),
                      DropdownButtonFormField<String>(
                        validator: (value) => value == null ? 'field required' : null,
                        isExpanded: true,
                        value: variety,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize:15),
                        hint: Text('Corn Variety Type'),
                        onChanged: (String newValue) {
                          setState(() {
                            variety = newValue;
                          });
                        },
                        items: <String>[
                          'OPV',
                          'Hybrid'
                        ]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(height:20),
                      Text("Which fertilizer combination do you prefer?"),
                      ListTile(
                        title: const Text('Complete, Solophos, Urea'),
                        leading: Radio(
                          value: 'complete,solophos,urea',
                          groupValue: _choice,
                          onChanged: (String value) {
                            setState(() {
                              _choice = value;
                              print(_choice);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Complete, Ammophosphate, Urea'),
                        leading: Radio(
                          value: 'complete,ammophosphate,urea',
                          groupValue: _choice,
                          onChanged: (String value) {
                            setState(() {
                              _choice = value;
                              print(_choice);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Muriate of potash, Solophos, Ammosulphate'),
                        leading: Radio(
                          value: 'muriateOfPotash,solophos,ammosulphate',
                          groupValue: _choice,
                          onChanged: (String value) {
                            setState(() {
                              _choice = value;
                              print(_choice);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Complete, Solophos, Ammosulphate'),
                        leading: Radio(
                          value: 'complete,solophos,ammosulphate',
                          groupValue: _choice,
                          onChanged: (String value) {
                            setState(() {
                              _choice = value;
                              print(_choice);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Complete, Ammophosphate, Ammosulphate'),
                        leading: Radio(
                          value: 'complete,ammophosphate,ammosulphate',
                          groupValue: _choice,
                          onChanged: (String value) {
                            setState(() {
                              _choice = value;
                              print(_choice);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Muriate of Potash, Solophos, Urea'),
                        leading: Radio(
                          value: 'muriateOfPotash,solophos,urea',
                          groupValue: _choice,
                          onChanged: (String value) {
                            setState(() {
                              _choice = value;
                              print(_choice);
                            });
                          },
                        ),
                      ),
                      SizedBox(height:10),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height:20),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  //side: BorderSide(color: Colors.lightGreen[700])
                ),
                onPressed: () {
                  if(_formKey.currentState.validate()){
                    process(double.parse(_areaController.text),(site + '-' + variety).toLowerCase(),_choice.split(','),double.parse(_tyController.text), growingSeason);
//                    FocusScopeNode currentFocus = FocusScope.of(context);
//                    if (!currentFocus.hasPrimaryFocus) {
//                      currentFocus.unfocus();
//                    }
                  }
                },
                textColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical:15.0),
                child: Text('Proceed',style:TextStyle(fontSize:15)),
              ),
            ),
          ],
        ),
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SecondPage extends StatefulWidget {
  final List<String> forN,forP,forK, caseCH;
  final List<double> AMF;
  final double area, yTarget, ySupply;
  final String ch;
  final List<double> frr_target;
  SecondPage({Key key, @required this.forN, @required this.forP, @required this.forK, @required this.AMF, @required this.caseCH, @required this.area, @required this.ch, @required this.frr_target, @required this.yTarget, @required this.ySupply}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();
  String chosenN, chosenP, chosenK;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<double> cost1;
  Future<double> cost2;
  Future<double> cost3;
  Future<double> cost4;
  Future<double> cost5;
  Future<double> cost6;
  TextEditingController _cost1Controller = new TextEditingController();
  TextEditingController _cost2Controller = new TextEditingController();
  TextEditingController _cost3Controller = new TextEditingController();
  TextEditingController _cost4Controller = new TextEditingController();
  TextEditingController _cost5Controller = new TextEditingController();
  TextEditingController _cost6Controller = new TextEditingController();
  final formatter = new NumberFormat("#,###.##");

  Future<void> _changeCost(cost) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      cost1 = prefs.setDouble("complete", cost[0]).then((bool success) {
        return cost[0];
      });

      cost2 = prefs.setDouble("urea", cost[1]).then((bool success) {
        return cost[1];
      });

      cost3 = prefs.setDouble("ammosulphate", cost[2]).then((bool success) {
        return cost[2];
      });

      cost4 = prefs.setDouble("ammophosphate", cost[3]).then((bool success) {
        return cost[3];
      });

      cost5 = prefs.setDouble("muriateOfPotash", cost[4]).then((bool success) {
        return cost[4];
      });

      cost6 = prefs.setDouble("solophos", cost[5]).then((bool success) {
        return cost[5];
      });
    });
  }

  Future<void> _changeDefault() async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      cost1 = prefs.setDouble("complete", prices['complete']).then((bool success) {
        return prices['complete'];
      });

      cost2 = prefs.setDouble("urea", prices['urea']).then((bool success) {
        return prices['urea'];
      });

      cost3 = prefs.setDouble("ammosulphate", prices['ammosulphate']).then((bool success) {
        return prices['ammosulphate'];
      });

      cost4 = prefs.setDouble("ammophosphate", prices['ammophosphate']).then((bool success) {
        return prices['ammophosphate'];
      });

      cost5 = prefs.setDouble("muriateOfPotash", prices['muriateOfPotash']).then((bool success) {
        return prices['muriateOfPotash'];
      });

      cost6 = prefs.setDouble("solophos", prices['solophos']).then((bool success) {
        return prices['solophos'];
      });
    });
  }

  List<double> computeAMFEcon(frrN,frrP,frrK){
    var AMF1_econ, AMF2_econ, AMF3_econ;

    AMF1_econ = frrK / fType[widget.caseCH[0]][2];

    if(widget.caseCH[1] == "solophos"){
      if(widget.caseCH[0] == "muriateOfPotash"){
        AMF2_econ = frrP / fType[widget.caseCH[1]][1];
        AMF3_econ = frrN / fType[widget.caseCH[2]][0];
      }else{
        AMF2_econ = (frrP - frrK) / fType[widget.caseCH[1]][1];
        AMF3_econ = (frrN - frrK) / fType[widget.caseCH[2]][0];
      }
    }
    else if (widget.caseCH[1] == "ammophosphate"){
      AMF2_econ = ((frrP-frrK) / fType[widget.caseCH[1]][1]) * fType[widget.caseCH[1]][0];

      AMF3_econ = (frrN-frrK-AMF2_econ) / fType[widget.caseCH[2]][0];
    }

    return([AMF1_econ,AMF2_econ,AMF3_econ]);
  }

  Future<List<double>> computeElement(chosen,element,index) async {
    //a
    var rate = (((widget.yTarget-widget.ySupply)*nRemoval[widget.ch][element])/fRecovery[widget.ch][element]) * widget.area;

    var a = (widget.yTarget-widget.ySupply)/pow(rate,2);
    //print(a);
    //b
    var b = (widget.yTarget + (pow(rate,2)*a) - widget.ySupply) / rate;
    //print(b);
    //c
    var c = widget.ySupply;
    //print(c);

    var price; //depends on the chosen variable
    if(chosen == "complete"){
      price = await cost1;
    }else if(chosen == "urea"){
      price = await cost2;
    }else if(chosen == "ammosulphate"){
      price = await cost3;
    }else if(chosen == "ammophosphate"){
      price = await cost4;
    }else if(chosen == "muriateOfPotash"){
      price = await cost5;
    }else if(chosen == "solophos"){
      price = await cost6;
    }

    var y,z,econ, max, economic, target, frr;

    for(var i = 1 ; i <= 397; i++){
      y = -a*pow(i,2)+b*i+c;
      z = i*(price/(fType[chosen][index]*50));
      econ = ( (widget.yTarget-widget.ySupply) / (rate) ) * i + widget.ySupply;

      if(i == 1){
        max = y-econ;
        economic = z;
        frr = i;
      }
      if(max < y-econ){
        max = y-econ;
        economic = z;
        frr = i;
      }
    }

    target = rate.round()*(price/(fType[chosen][index]*50));

    return [economic,target,double.parse(frr.toString()),price];

    //print("Max: $max Economic N: $economic Target N: $target");
  }

  @override
  void initState() {
    super.initState();
    cost1 = _prefs.then((SharedPreferences prefs) {
      return (prefs.getDouble('complete') ?? prices['complete']);
    });

    cost2 = _prefs.then((SharedPreferences prefs) {
      return (prefs.getDouble('urea') ?? prices['urea']);
    });

    cost3 = _prefs.then((SharedPreferences prefs) {
      return (prefs.getDouble('ammosulphate') ?? prices['ammosulphate']);
    });

    cost4 = _prefs.then((SharedPreferences prefs) {
      return (prefs.getDouble('ammophosphate') ?? prices['ammophosphate']);
    });

    cost5 = _prefs.then((SharedPreferences prefs) {
      return (prefs.getDouble('muriateOfPotash') ?? prices['muriateOfPotash']);
    });

    cost6 = _prefs.then((SharedPreferences prefs) {
      return (prefs.getDouble('solophos') ?? prices['solophos']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Nutrient Manager'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
//              Center(
//                  child: Text(
//                    'Amount of fertilizer',
//                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                  )),
//              DataTable(
//                columns: [
//                  DataColumn(label: Text('')),
//                  DataColumn(label: Text('kg')),
//                  DataColumn(label: Text('Bag')),
//                ],
//                rows: [
//                  DataRow(cells: [
//                    DataCell(Text(capitalize(widget.caseCH[0]))),
//                    DataCell(Text(widget.AMF[0].toStringAsFixed(2))),
//                    DataCell(Text( (widget.AMF[0]/50).toStringAsFixed(2)  )),
//                  ]),
//                  DataRow(cells: [
//                    DataCell(Text(capitalize(widget.caseCH[1]))),
//                    DataCell(Text(widget.AMF[1].toStringAsFixed(2))),
//                    DataCell(Text((widget.AMF[1]/50).toStringAsFixed(2))),
//                  ]),
//                  DataRow(cells: [
//                    DataCell(Text(capitalize(widget.caseCH[2]))),
//                    DataCell(Text(widget.AMF[2].toStringAsFixed(2))),
//                    DataCell(Text((widget.AMF[2]/50).toStringAsFixed(2))),
//                  ]),
//                ],
//              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                              'Fertilizer Cost',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                        RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(color: Colors.lightGreen[700])
                          ),
                          onPressed: () {
                            buildEditCostsDialog(context);
                          },
                          textColor: Colors.green,
                          //padding: const EdgeInsets.symmetric(vertical:15.0),
                          child: Text('Edit',style:TextStyle(fontSize:15)),
                        ),
                        DataTable(
                          columns: [
                            DataColumn(label: Text('Fertilizer Material')),
                            DataColumn(label: Expanded(child:Text('Cost per bag(PHP)'))),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text('Complete (14-14-14)')),
                              DataCell(
                                  FutureBuilder(
                                    future: cost1,
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      _cost1Controller.text = snapshot.data.toString();
                                      return Text(formatter.format(snapshot.data));
                                    }
                                  )
                              ),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Urea (46-0-0)')),
                              DataCell(FutureBuilder(
                                  future: cost2,
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    _cost2Controller.text = snapshot.data.toString();
                                    return Text(formatter.format(snapshot.data));
                                  }
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Ammosulphate (21-0-0)')),
                              DataCell(FutureBuilder(
                                  future: cost3,
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    _cost3Controller.text = snapshot.data.toString();
                                    return Text(formatter.format(snapshot.data));
                                  }
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Ammophosphate (16-20-0)')),
                              DataCell(FutureBuilder(
                                  future: cost4,
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    _cost4Controller.text = snapshot.data.toString();
                                    return Text(formatter.format(snapshot.data));
                                  }
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Muriate of potash (0-0-60)')),
                              DataCell(FutureBuilder(
                                  future: cost5,
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    _cost5Controller.text = snapshot.data.toString();
                                    return Text(formatter.format(snapshot.data));
                                  }
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Solophos (0-18-0)')),
                              DataCell(FutureBuilder(
                                  future: cost6,
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    _cost6Controller.text = snapshot.data.toString();
                                    return Text(formatter.format(snapshot.data));
                                  }
                              )),
                            ]),
                          ],
                        ),
                        DropdownButtonFormField<String>(
                          validator: (value) => value == null ? 'field required' : null,
                          isExpanded: true,
                          value: chosenN,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black, fontSize:15),
                          hint: Text('For N'),
                          onChanged: (String newValue) {
                            setState(() {
                              chosenN = newValue;
                            });
                          },
                          items: widget.forN
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        DropdownButtonFormField<String>(
                          validator: (value) => value == null ? 'field required' : null,
                          isExpanded: true,
                          value: chosenP,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black, fontSize:15),
                          hint: Text('For P'),
                          onChanged: (String newValue) {
                            setState(() {
                              chosenP = newValue;
                            });
                          },
                          items: widget.forP
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        DropdownButtonFormField<String>(
                          validator: (value) => value == null ? 'field required' : null,
                          isExpanded: true,
                          value: chosenK,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black, fontSize:15),
                          hint: Text('For K'),
                          onChanged: (String newValue) {
                            setState(() {
                              chosenK = newValue;
                            });
                          },
                          items: widget.forK
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text( (value=='muriateOfPotash') ? "muriate of potash" : value ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height:20),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    //side: BorderSide(color: Colors.lightGreen[700])
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      var nCost = await computeElement(chosenN,'n',0);
                      var pCost = await computeElement(chosenP,'p',1);
                      var kCost = await computeElement(chosenK,'k',2);

                      var AMF_econ = computeAMFEcon(nCost[2],pCost[2],kCost[2]);

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => resultsPage(nCost:nCost, pCost:pCost, kCost:kCost, AMF: widget.AMF, AMF_econ: AMF_econ, caseCH: widget.caseCH, frr_target: widget.frr_target, frr_econ: [nCost[2],pCost[2],kCost[2]], area:widget.area)),
                      );
//                    FocusScopeNode currentFocus = FocusScope.of(context);
//                    if (!currentFocus.hasPrimaryFocus) {
//                      currentFocus.unfocus();
//                    }
                    }
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                  child: Text('Calculate',style:TextStyle(fontSize:15)),
                ),
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  buildEditCostsDialog(BuildContext context){
    return showDialog<String>(
      context: context,
      barrierDismissible: true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return AlertDialog(
                title: Text('Fertilizer Cost'),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(8.0)),
                content: Container(
                    child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              validator: (val) => val.isEmpty ? 'field required' : null,
                              keyboardType: TextInputType.number,
                              //autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Complete'),
                              controller: _cost1Controller,
                            ),
                            TextFormField(
                              validator: (val) => val.isEmpty ? 'field required' : null,
                              keyboardType: TextInputType.number,
                              //autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Urea'),
                              controller: _cost2Controller,
                            ),
                            TextFormField(
                              validator: (val) => val.isEmpty ? 'field required' : null,
                              keyboardType: TextInputType.number,
                              //autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Ammosulphate'),
                              controller: _cost3Controller,
                            ),
                            TextFormField(
                              validator: (val) => val.isEmpty ? 'field required' : null,
                              keyboardType: TextInputType.number,
                              //autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Ammophosphate'),
                              controller: _cost4Controller,
                            ),
                            TextFormField(
                              validator: (val) => val.isEmpty ? 'field required' : null,
                              keyboardType: TextInputType.number,
                              //autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Muriate of potash'),
                              controller: _cost5Controller,
                            ),
                            TextFormField(
                              validator: (val) => val.isEmpty ? 'field required' : null,
                              keyboardType: TextInputType.number,
                              //autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Solophos'),
                              controller: _cost6Controller,
                            ),
                          ],
                        )
                    )
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Reset Default',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      _changeDefault();
                      Navigator.of(context).pop();
                    },
                  ),
                  RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.lightGreen[700]),
                        borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text('Cancel',
                      style: TextStyle(color:Colors.green)
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text('Save',
                    ),
                    onPressed: () {
                      _changeCost([double.parse(_cost1Controller.text),
                        double.parse(_cost2Controller.text),
                        double.parse(_cost3Controller.text),
                        double.parse(_cost4Controller.text),
                        double.parse(_cost5Controller.text),
                        double.parse(_cost6Controller.text)]
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
        );
      },
    );
  }
}


class resultsPage extends StatefulWidget {
  final List<double> nCost,pCost,kCost;
  final List<double> AMF, AMF_econ;
  final List<String> caseCH;
  final List<double> frr_target, frr_econ;
  final double area;
  resultsPage({Key key, @required this.nCost, @required this.pCost, @required this.kCost, @required this.AMF, @required this.AMF_econ, @required this.caseCH, @required this.frr_target, @required this.frr_econ, @required this.area}) : super(key: key);

  @override
  _resultsPageState createState() => _resultsPageState();
}

class _resultsPageState extends State<resultsPage> {
  final controller = PageController();
  final formatter = new NumberFormat("#,###.##");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TabbarHeader(
            controller: controller,
            tabs: [
              Tab(text: "Economic Yield"),
              Tab(text: "Target Yield"),
            ],
          ),
        ),
      ),
      body: TabbarContent(
        controller: controller,
        children: <Widget>[
      ListView(children: <Widget>[
        SizedBox(height:10),
        Center(
            child: Text(
              'Fertilizer Rate Recommendation (kg)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        DataTable(
          columns: [
            DataColumn(label: Text('')),
            DataColumn(label: Text('N')),
            DataColumn(label: Text('P₂O₅')),
            DataColumn(label: Text('K₂O')),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text("per hectare")),
              DataCell(Text( (widget.frr_econ[0]/widget.area).toStringAsFixed(2))),
              DataCell(Text( (widget.frr_econ[1]/widget.area).toStringAsFixed(2))),
              DataCell(Text( (widget.frr_econ[2]/widget.area).toStringAsFixed(2))),
            ]),
            DataRow(cells: [
              DataCell(Text("farmer's area")),
              DataCell(Text(widget.frr_econ[0].toStringAsFixed(2))),
              DataCell(Text(widget.frr_econ[1].toStringAsFixed(2))),
              DataCell(Text(widget.frr_econ[2].toStringAsFixed(2))),
            ]),
          ],
        ),
        SizedBox(height:20),
        Center(
            child: Text(
              'Amount of Fertilizer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        Center(
            child: Text(
              "per hectare",
              style: TextStyle(fontSize: 15),
            )),
        DataTable(
          columns: [
            DataColumn(label: Text('')),
            DataColumn(label: Text('kg')),
            DataColumn(label: Text('Bag')),
            DataColumn(label: Text('Cost\n(PHP)',overflow: TextOverflow.ellipsis,)),
          ],
          rows: [
            DataRow(cells: [
              DataCell(
                Container(
                    width:MediaQuery.of(context).size.width/10,
                    child: Text(capitalize(widget.caseCH[0]))
                ),
              ),
              DataCell(Text((widget.AMF_econ[0]/widget.area).toStringAsFixed(2))),
              DataCell(Text( ((widget.AMF_econ[0]/widget.area)/50).toStringAsFixed(2)  )),
              DataCell(Text( (((widget.AMF_econ[0]/widget.area)/50)*widget.nCost[3]).toStringAsFixed(2) )),
            ]),
            DataRow(cells: [
              DataCell(
                Container(
                    width:MediaQuery.of(context).size.width/10,
                    child: Text(capitalize(widget.caseCH[1]))
                ),
              ),
              DataCell(Text((widget.AMF_econ[1]/widget.area).toStringAsFixed(2))),
              DataCell(Text(((widget.AMF_econ[1]/widget.area)/50).toStringAsFixed(2))),
              DataCell(Text( (((widget.AMF_econ[1]/widget.area)/50)*widget.pCost[3]).toStringAsFixed(2) )),
            ]),
            DataRow(cells: [
              DataCell(
                Container(
                    width:MediaQuery.of(context).size.width/10,
                    child: Text(capitalize(widget.caseCH[2]))
                ),
              ),
              DataCell(Text((widget.AMF_econ[2]/widget.area).toStringAsFixed(2))),
              DataCell(Text(((widget.AMF_econ[2]/widget.area)/50).toStringAsFixed(2))),
              DataCell(Text( (((widget.AMF_econ[2]/widget.area)/50)*widget.kCost[3]).toStringAsFixed(2) )),
            ]),
            DataRow(cells: [
              DataCell(Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(
                  Text(
                      (
                          (widget.AMF_econ[0]/50)*widget.nCost[3]+
                              (widget.AMF_econ[1]/50)*widget.pCost[3]+
                              (widget.AMF_econ[2]/50)*widget.kCost[3]
                      ).toStringAsFixed(2), style: TextStyle(fontWeight: FontWeight.bold)
                  )
              ),
            ]),
          ],
        ),
        SizedBox(height:20),
        Center(
            child: Text(
              'Amount of Fertilizer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        Center(
            child: Text(
              "farmer's area",
              style: TextStyle(fontSize: 15),
            )),
        DataTable(
          columns: [
            DataColumn(label: Text('')),
            DataColumn(label: Text('kg')),
            DataColumn(label: Text('Bag')),
            DataColumn(label: Text('Cost\n(PHP)',overflow: TextOverflow.ellipsis,)),
          ],
          rows: [
            DataRow(cells: [
              DataCell(
                Container(
                    width:MediaQuery.of(context).size.width/10,
                    child: Text(capitalize(widget.caseCH[0]))
                ),
              ),
              DataCell(Text(widget.AMF_econ[0].toStringAsFixed(2))),
              DataCell(Text( (widget.AMF_econ[0]/50).toStringAsFixed(2)  )),
              DataCell(Text( ((widget.AMF_econ[0]/50)*widget.nCost[3]).toStringAsFixed(2) )),
            ]),
            DataRow(cells: [
              DataCell(
                Container(
                  width:MediaQuery.of(context).size.width/10,
                  child: Text(capitalize(widget.caseCH[1]))
                ),
              ),
              DataCell(Text(widget.AMF_econ[1].toStringAsFixed(2))),
              DataCell(Text((widget.AMF_econ[1]/50).toStringAsFixed(2))),
              DataCell(Text( ((widget.AMF_econ[1]/50)*widget.pCost[3]).toStringAsFixed(2) )),
            ]),
            DataRow(cells: [
              DataCell(
                Container(
                    width:MediaQuery.of(context).size.width/10,
                    child: Text(capitalize(widget.caseCH[2]))
                ),
              ),
              DataCell(Text(widget.AMF_econ[2].toStringAsFixed(2))),
              DataCell(Text((widget.AMF_econ[2]/50).toStringAsFixed(2))),
              DataCell(Text( ((widget.AMF_econ[2]/50)*widget.kCost[3]).toStringAsFixed(2) )),
            ]),
            DataRow(cells: [
              DataCell(Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(
                  Text(
                      (
                          (widget.AMF_econ[0]/50)*widget.nCost[3]+
                              (widget.AMF_econ[1]/50)*widget.pCost[3]+
                              (widget.AMF_econ[2]/50)*widget.kCost[3]
                      ).toStringAsFixed(2), style: TextStyle(fontWeight: FontWeight.bold)
                  )
              ),
            ]),
          ],
        ),
          SizedBox(height:20),
          Center(
              child: Text(
                'Nutrient Cost Analysis',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          DataTable(
            columns: [
              DataColumn(label: Text('nutrient')),
              DataColumn(label: Text('per hectare',overflow: TextOverflow.ellipsis,)),
              DataColumn(label: Text("farmer's area",overflow: TextOverflow.ellipsis,)),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('N')),
                DataCell(Text(formatter.format(widget.nCost[0]/widget.area))),
                DataCell(Text(formatter.format(widget.nCost[0]))),
              ]),
              DataRow(cells: [
                DataCell(Text('P₂O₅')),
                DataCell(Text(formatter.format(widget.pCost[0]/widget.area))),
                DataCell(Text(formatter.format(widget.pCost[0]))),
              ]),
              DataRow(cells: [
                DataCell(Text('K₂O')),
                DataCell(Text(formatter.format(widget.kCost[0]/widget.area))),
                DataCell(Text(formatter.format(widget.kCost[0]))),
              ]),
            ],
          ),
        ]),
          ListView(children: <Widget>[
            SizedBox(height:10),
            Center(
                child: Text(
                  'Fertilizer Rate Recommendation (kg)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            DataTable(
              columns: [
                DataColumn(label: Text('')),
                DataColumn(label: Text('N')),
                DataColumn(label: Text('P₂O₅')),
                DataColumn(label: Text('K₂O')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("per hectare")),
                  DataCell(Text( (widget.frr_target[0]/widget.area).toStringAsFixed(2))),
                  DataCell(Text( (widget.frr_target[1]/widget.area).toStringAsFixed(2))),
                  DataCell(Text( (widget.frr_target[2]/widget.area).toStringAsFixed(2))),
                ]),
                DataRow(cells: [
                  DataCell(Text("farmer's area")),
                  DataCell(Text(widget.frr_target[0].toStringAsFixed(2))),
                  DataCell(Text(widget.frr_target[1].toStringAsFixed(2))),
                  DataCell(Text(widget.frr_target[2].toStringAsFixed(2))),
                ]),
              ],
            ),
              SizedBox(height:20),
            Center(
                child: Text(
                  'Amount of Fertilizer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Center(
                child: Text(
                  "per hectare",
                  style: TextStyle(fontSize: 15),
                )),
            DataTable(
              columns: [
                DataColumn(label: Text('')),
                DataColumn(label: Text('kg')),
                DataColumn(label: Text('Bag')),
                DataColumn(label: Text('Cost\n(PHP)',overflow: TextOverflow.ellipsis,)),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(
                    Container(
                        width:MediaQuery.of(context).size.width/10,
                        child: Text(capitalize(widget.caseCH[0]))
                    ),
                  ),
                  DataCell(Text((widget.AMF[0]/widget.area).toStringAsFixed(2))),
                  DataCell(Text( ((widget.AMF[0]/widget.area)/50).toStringAsFixed(2)  )),
                  DataCell(Text( (((widget.AMF[0]/widget.area)/50)*widget.nCost[3]).toStringAsFixed(2) )),
                ]),
                DataRow(cells: [
                  DataCell(
                    Container(
                        width:MediaQuery.of(context).size.width/10,
                        child: Text(capitalize(widget.caseCH[1]))
                    ),
                  ),
                  DataCell(Text((widget.AMF[1]/widget.area).toStringAsFixed(2))),
                  DataCell(Text(((widget.AMF[1]/widget.area)/50).toStringAsFixed(2))),
                  DataCell(Text( (((widget.AMF[1]/widget.area)/50)*widget.pCost[3]).toStringAsFixed(2) )),
                ]),
                DataRow(cells: [
                  DataCell(
                    Container(
                        width:MediaQuery.of(context).size.width/10,
                        child: Text(capitalize(widget.caseCH[2]))
                    ),
                  ),
                  DataCell(Text((widget.AMF[2]/widget.area).toStringAsFixed(2))),
                  DataCell(Text(((widget.AMF[2]/widget.area)/50).toStringAsFixed(2))),
                  DataCell(Text( (((widget.AMF[2]/widget.area)/50)*widget.kCost[3]).toStringAsFixed(2) )),
                ]),
                DataRow(cells: [
                  DataCell(Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(
                      Text(
                          (
                              (widget.AMF[0]/50)*widget.nCost[3]+
                                  (widget.AMF[1]/50)*widget.pCost[3]+
                                  (widget.AMF[2]/50)*widget.kCost[3]
                          ).toStringAsFixed(2), style: TextStyle(fontWeight: FontWeight.bold)
                      )
                  ),
                ]),
              ],
            ),
            SizedBox(height:20),
            Center(
                child: Text(
                  'Amount of Fertilizer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Center(
                child: Text(
                  "farmer's area",
                  style: TextStyle(fontSize: 15),
                )),
            DataTable(
              columns: [
                DataColumn(label: Text('')),
                DataColumn(label: Text('kg')),
                DataColumn(label: Text('Bag')),
                DataColumn(label: Text('Cost\n(PHP)',overflow: TextOverflow.ellipsis,)),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(
                    Container(
                        width:MediaQuery.of(context).size.width/10,
                        child: Text(capitalize(widget.caseCH[0]))
                    ),
                  ),
                  DataCell(Text(widget.AMF[0].toStringAsFixed(2))),
                  DataCell(Text( (widget.AMF[0]/50).toStringAsFixed(2)  )),
                  DataCell(Text( ((widget.AMF[0]/50)*widget.nCost[3]).toStringAsFixed(2) )),
                ]),
                DataRow(cells: [
                  DataCell(
                    Container(
                        width:MediaQuery.of(context).size.width/10,
                        child: Text(capitalize(widget.caseCH[1]))
                    ),
                  ),
                  DataCell(Text(widget.AMF[1].toStringAsFixed(2))),
                  DataCell(Text((widget.AMF[1]/50).toStringAsFixed(2))),
                  DataCell(Text( ((widget.AMF[1]/50)*widget.pCost[3]).toStringAsFixed(2) )),
                ]),
                DataRow(cells: [
                  DataCell(
                    Container(
                        width:MediaQuery.of(context).size.width/10,
                        child: Text(capitalize(widget.caseCH[2]))
                    ),
                  ),
                  DataCell(Text(widget.AMF[2].toStringAsFixed(2))),
                  DataCell(Text((widget.AMF[2]/50).toStringAsFixed(2))),
                  DataCell(Text( ((widget.AMF[2]/50)*widget.kCost[3]).toStringAsFixed(2) )),
                ]),
                DataRow(cells: [
                  DataCell(Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(
                      Text(
                          (
                              (widget.AMF[0]/50)*widget.nCost[3]+
                                  (widget.AMF[1]/50)*widget.pCost[3]+
                                  (widget.AMF[2]/50)*widget.kCost[3]
                          ).toStringAsFixed(2), style: TextStyle(fontWeight: FontWeight.bold)
                      )
                  ),
                ]),
              ],
            ),
            SizedBox(height:20),
            Center(
                child: Text(
                  'Nutrient Cost Analysis',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            DataTable(
              columns: [
                DataColumn(label: Text('nutrient')),
                DataColumn(label: Text('per hectare',overflow: TextOverflow.ellipsis,)),
                DataColumn(label: Text("farmer's area",overflow: TextOverflow.ellipsis,)),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('N')),
                  DataCell(Text(formatter.format(widget.nCost[1]/widget.area))),
                  DataCell(Text(formatter.format(widget.nCost[1]))),
                ]),
                DataRow(cells: [
                  DataCell(Text('P₂O₅')),
                  DataCell(Text(formatter.format(widget.pCost[1]/widget.area))),
                  DataCell(Text(formatter.format(widget.pCost[1]))),
                ]),
                DataRow(cells: [
                  DataCell(Text('K₂O')),
                  DataCell(Text(formatter.format(widget.kCost[1]/widget.area))),
                  DataCell(Text(formatter.format(widget.kCost[1]))),
                ]),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}