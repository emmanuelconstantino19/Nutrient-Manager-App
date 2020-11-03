import 'package:flutter/material.dart';
import 'dart:math';

String capitalize(word) {
  return "${word[0].toUpperCase()}${word.substring(1)}";
}

const yTarget = {
  "albay-opv" : 6,
  "albay-hybrid" : 6,
  "bukidnon-opv" : 6,
  "bukidnon-hybrid" : 6,
  "cebu-opv" : 6,
  "cebu-hybrid" : 6,
  "iloilo-opv" : 6,
  "iloilo-hybrid" : 6,
  "isabela-opv" : 6,
  "isabela-hybrid" : 6,
  "nueva ecija-opv" : 8.72,
  "nueva ecija-hybrid" : 8.72,
};

const ySupply = {
  "albay-opv" : 2.4,
  "albay-hybrid" : 2.4,
  "bukidnon-opv" : 2.92,
  "bukidnon-hybrid" : 2.92,
  "cebu-opv" : 1.86,
  "cebu-hybrid" : 1.86,
  "iloilo-opv" : 2.34,
  "iloilo-hybrid" : 2.34,
  "isabela-opv" :2.11,
  "isabela-hybrid" : 2.11,
  "nueva ecija-opv" : 1.66,
  "nueva ecija-hybrid" : 1.66,
};

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

const multiplier={
  'n': 15.6,
  'p': 2.9,
  'k': 3.8
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
  final _formKey = GlobalKey<FormState>();
  String site, variety;
  String _choice = 'Yes';

  void process(area,ch,caseCH) {
    var AMF1, AMF2, AMF3;

    var frr = {
      "n" : (((yTarget[ch]-ySupply[ch])*nRemoval[ch]['n'])/fRecovery[ch]['n']) * area,
      "p" : (((yTarget[ch]-ySupply[ch])*nRemoval[ch]['p'])/fRecovery[ch]['p']) * area,
      "k" : (((yTarget[ch]-ySupply[ch])*nRemoval[ch]['k'])/fRecovery[ch]['k']) * area,
    };

    AMF1 = frr['k'] / fType[caseCH[0]][2];

    if(caseCH[1] == "solophos"){
      if(caseCH[0] == "muriateOfPotash"){
        AMF2 = frr['p'] / fType[caseCH[1]][1];
        AMF3 = frr['n'] / fType[caseCH[2]][0];
      }else{
        AMF2 = (frr['p'] - frr['k']) / fType[caseCH[1]][1];
        AMF3 = (frr['n'] - frr['k']) / fType[caseCH[2]][0];
      }
    }
    else if (caseCH[1] == "ammophosphate"){
      AMF2 = ((frr['p']-frr['k']) / fType[caseCH[1]][1]) * fType[caseCH[1]][0];

      AMF3 = (frr['n']-frr['k']-AMF2) / fType[caseCH[2]][0];
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

    print(forN);
    print(forP);
    print(forK);


//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => resultsPage(area:area, caseCH: caseCH, AMF: [AMF1,AMF2,AMF3])),
//    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage(forN:forN, forP:forP, forK: forK, AMF: [AMF1,AMF2,AMF3], caseCH: caseCH, area: area, ch: ch)),
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
                      TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        keyboardType: TextInputType.number,
                        //autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Area (HA)'),
                        controller: _areaController,
                      ),
                      DropdownButtonFormField<String>(
                        validator: (value) => value == null ? 'field required' : null,
                        isExpanded: true,
                        value: site,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize:15),
                        hint: Text('Crop Planted'),
                        onChanged: (String newValue) {
                          setState(() {
                            site = newValue;
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
                      Text("Which fertilizer combination you would like to use?"),
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
                    process(double.parse(_areaController.text),(site + '-' + variety).toLowerCase(),_choice.split(','));
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
  final List<dynamic> AMF;
  final double area;
  final String ch;
  SecondPage({Key key, @required this.forN, @required this.forP, @required this.forK, @required this.AMF, @required this.caseCH, @required this.area, @required this.ch}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();
  String chosenN, chosenP, chosenK;

  List<double> computeElement(chosen,element,index){
    //a
    var rate = ((yTarget[widget.ch]-ySupply[widget.ch])*multiplier[element]/fRecovery[widget.ch][element]) * widget.area;
    //print(rate.ceil());

    var a = (yTarget[widget.ch]-ySupply[widget.ch])/pow(rate,2);
    //print(a);
    //b
    var b = (yTarget[widget.ch] + (pow(rate,2)*a) - ySupply[widget.ch]) / rate;
    //print(b);
    //c
    var c = ySupply[widget.ch];
    //print(c);

    var price = prices[chosen]; //depends on the chosen variable

    var y,z,econ, max, economic, target;
    for(var i = 1 ; i <= 397; i++){
      y = -a*pow(i,2)+b*i+c;
      z = i*(price/(fType[chosen][index]*50));
      econ = ( (yTarget[widget.ch]-ySupply[widget.ch]) / (rate) ) * i + ySupply[widget.ch];

      if(i == 1){
        max = y-econ;
        economic = z;
      }
      if(max < y-econ){
        max = y-econ;
        economic = z;
      }
      if(rate.ceil() == i){
        target = z;
      }
    }

    return [economic,target];

    //print("Max: $max Economic N: $economic Target N: $target");
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
              Center(
                  child: Text(
                    'Amount of fertilizer',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              DataTable(
                columns: [
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('kg')),
                  DataColumn(label: Text('Bag')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text(capitalize(widget.caseCH[0]))),
                    DataCell(Text(widget.AMF[0].toStringAsFixed(2))),
                    DataCell(Text( (widget.AMF[0]/50).toStringAsFixed(2)  )),
                  ]),
                  DataRow(cells: [
                    DataCell(Text(capitalize(widget.caseCH[1]))),
                    DataCell(Text(widget.AMF[1].toStringAsFixed(2))),
                    DataCell(Text((widget.AMF[1]/50).toStringAsFixed(2))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text(capitalize(widget.caseCH[2]))),
                    DataCell(Text(widget.AMF[2].toStringAsFixed(2))),
                    DataCell(Text((widget.AMF[2]/50).toStringAsFixed(2))),
                  ]),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                              child: Text(value),
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
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      var nCost = computeElement(chosenN,'n',0);
                      var pCost = computeElement(chosenP,'p',1);
                      var kCost = computeElement(chosenK,'k',2);

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => resultsPage(nCost:nCost, pCost:pCost, kCost:kCost)),
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
}


class resultsPage extends StatefulWidget {
  final List<double> nCost,pCost,kCost;
  resultsPage({Key key, @required this.nCost, @required this.pCost, @required this.kCost}) : super(key: key);

  @override
  _resultsPageState createState() => _resultsPageState();
}

class _resultsPageState extends State<resultsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Results'),
          centerTitle: true,
        ),
        body: ListView(children: <Widget>[
          SizedBox(height:10),
          Center(
              child: Text(
                'Nutrient Cost Analysis',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          DataTable(
            columns: [
              DataColumn(label: Text('Cost(PhP)')),
              DataColumn(label: Text('Economic')),
              DataColumn(label: Text('Target'))
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('N')),
                DataCell(Text(widget.nCost[0].toStringAsFixed(2))),
                DataCell(Text(widget.nCost[1].toStringAsFixed(2))),
              ]),
              DataRow(cells: [
                DataCell(Text('P₂O₅')),
                DataCell(Text(widget.pCost[0].toStringAsFixed(2))),
                DataCell(Text(widget.pCost[1].toStringAsFixed(2))),
              ]),
              DataRow(cells: [
                DataCell(Text('K₂O')),
                DataCell(Text(widget.kCost[0].toStringAsFixed(2))),
                DataCell(Text(widget.kCost[1].toStringAsFixed(2))),
              ]),
            ],
          ),
        ])
    );
  }
}