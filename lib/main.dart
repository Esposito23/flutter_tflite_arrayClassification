import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: NumberCheck(),
    debugShowCheckedModeBanner: false,
  ));
}

class NumberCheck extends StatefulWidget {
  @override
  _NumberCheckState createState() => _NumberCheckState();
}

class _NumberCheckState extends State<NumberCheck> {
  @override
  Widget build(BuildContext context) {
    // print(input);

    return (Scaffold(
      appBar: AppBar(
        title: Text('TFLite su Array'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(children: <Widget>[
          SizedBox(height: 20),
          Text('Clicca su questi bottoni',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('0,1,0'),
            color: Colors.grey,
            onPressed: () {
              caricaModello([
                [0.0, 1.0, 0.0]
              ]);
            },
          ),
          RaisedButton(
            child: Text('0,0,0'),
            color: Colors.grey,
            onPressed: () {
              caricaModello([
                [0.0, 0.0, 0.0]
              ]);
            },
          ),
          RaisedButton(
            child: Text('1,1,0'),
            color: Colors.grey,
            onPressed: () {
              caricaModello([
                [1.0, 1.0, 0.0]
              ]);
            },
          ),
          RaisedButton(
            child: Text('0,0,0'),
            color: Colors.grey,
            onPressed: () {
              caricaModello([
                [0.0, 0.0, 0.0]
              ]);
            },
          )
        ]),
      ),
    ));
  }

  caricaModello(List input) async {
    final modello = await tfl.Interpreter.fromAsset('simpleNet.tflite');

    var output = List(1).reshape([1, 1]);

    // inference
    modello.run(input, output);

    if (output[0][0] > 0.5) {
      showAlertDialog(context, 'Non ci sono 3 zeri');
    } else {
      showAlertDialog(context, 'Ci sono 3 zeri');
    }
  }

  showAlertDialog(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      title: Text("Risultato Inferenza"),
      content: Text(message),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
