import 'package:flutter/material.dart';
import 'word_gen.dart';
import 'validate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Trip Hack',
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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Word Trip Hack'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

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
  // Future<List<String>> _listWords;
  List<String> _listWords = [];
  int _letterCount = 0;
  final myController = TextEditingController();

  void _set3Letters() async {
    var list = await filterValidWords(gen3(myController.text));
    setState(() {
      _listWords = list;
    });
  }

  void _set4Letters() async {
    var list = await filterValidWords(gen4(myController.text));
    setState(() {
      _listWords = list;
    });
  }


  void _set5Letters() async {
    var list = await filterValidWords(gen5(myController.text));
    setState(() {
      _listWords = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: myController,
              onChanged: (text) {
                setState(() {
                  _letterCount = text.length;
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter input characters'
            ),
          ),

            // FutureBuilder<List<String>>(
            //   initialData: [],
            //   future: _listWords,
            //   builder: (context, snapData) {
            //     if (snapData.connectionState == ConnectionState.none && snapData.hasData == null) {
            //     //print('project snapshot data is: ${projectSnap.data}');
            //     return Text("Loading...");
            //     }
            //     List<String> data =  snapData.data as List<String>;
            //
            //    return new ListView.builder
            //     (
            //     itemCount: data.length,
            //     itemBuilder: (BuildContext ctxt, int Index) {
            //       return new Text(data[Index]);
            //     });
            //   })
            Opacity(
                opacity: _listWords.length> 0 ? 0:1,
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No Result found')
                )
            ),
            new Expanded(
                child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: new ListView.builder
                      (
                        itemCount: _listWords.length,
                        itemBuilder: (BuildContext ctxt, int Index) {
                          return new Text(_listWords[Index].toUpperCase(), style: TextStyle(fontSize: 30),);
                        }
                    )
                )
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Opacity(
            opacity: _letterCount >=3 ? 1: 0,
            child: Padding(
              padding: EdgeInsets.only(right: 180),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    heroTag: "btn1",
                    // backgroundColor: Color(0XFF0D325E),
                    backgroundColor: Colors.red,
                    // child: Icon(Icons.refresh),
                    child: Text('3'),
                    onPressed: _set3Letters
              ))),
          ),
          Opacity(
            opacity: _letterCount >= 4 ? 1: 0,
            child: Padding(
                padding: EdgeInsets.only(right: 120),
                child:  Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  heroTag: "btn2",
                  backgroundColor: Color(0XFF0D325E),

                  // child: Icon(Icons.refresh),('
                  child: Text("4"),
                  onPressed: _set4Letters
              )
            )
          )),
          Opacity(
              opacity: _letterCount >= 5 ? 1: 0,
              child: Padding(
                  padding: EdgeInsets.only(right: 60),
                  child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                      heroTag: "btn2",
                      backgroundColor: Color(0XFF0D325E),

                      // child: Icon(Icons.refresh),('
                      child: Text("5"),
                      onPressed: _set5Letters
                  )
              )
          )),

          Opacity(
              opacity: _letterCount >= 5 ? 1: 0,
              child: Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                          heroTag: "btn2",
                          backgroundColor: Color(0XFF0D325E),

                          // child: Icon(Icons.refresh),('
                          child: Text("6"),
                          onPressed: _set5Letters
                      )
                  )
              ))

        ]
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _set3Letters,
      //   tooltip: '3',
      //   child: Icon(Icons.add_alert),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
