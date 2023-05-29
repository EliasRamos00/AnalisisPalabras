import 'package:flutter/material.dart';
import 'classifier-2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _controller;
  late Classifier _classifier;
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _classifier = Classifier();
    _children = [];
    _children.add(Container());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Analisis de Text'),
        ),
        body: Container(
          padding: EdgeInsets.all(4),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                itemCount: _children.length,
                itemBuilder: (_, index) {
                  return _children[index];
                },
              )),
              Container(
                padding: EdgeInsets.all(8),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.amber)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      decoration: const InputDecoration(hintText: 'Texto'),
                      controller: _controller,
                    )),
                    TextButton(
                        onPressed: () {
                          final text = _controller.text;
                          final prediction = _classifier.classify(text);
                          setState(() {
                            _children.add(Dismissible(
                                key: GlobalKey(),
                                onDismissed: (direction) {},
                                child: Card(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    color:  prediction[1] > prediction[0] ? Colors.lightGreenAccent : Colors.red,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:<Widget> [
                                        Text(
                                          "Input: $text", style: TextStyle(fontSize: 16),
                                        ),
                                        Text("Output:"),
                                        Text("Positivo: ${prediction[1]}"),
                                        Text("Negativo: ${prediction[0]}"),

                                      ],
                                    ),
                                  ),
                                )
                              ));
                            _controller.clear();
                          });
                        },
                        child: Text("Clasificar"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
