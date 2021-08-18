import 'package:flutter/material.dart';
import 'word_gen.dart';
import 'validate.dart';

void main() {
  runApp(WordTripHackApp());
}

class WordTripHackApp extends StatelessWidget {
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
        primarySwatch: Colors.orange,
      ),
      home: WordTripHackHome(title: 'Word Trip Hack'),
    );
  }
}

class WordTripHackHome extends StatefulWidget {
  WordTripHackHome({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _WordTripHackHomeState createState() => _WordTripHackHomeState();
}

class _WordTripHackHomeState extends State<WordTripHackHome> {
  // Future<List<String>> _listWords;
  List<String> _listWords = [];
  int _letterCount = 0;
  int _fetching = 0;
  String subtext = '';

  final myController = TextEditingController();
  final subController = TextEditingController();

  void _fetchWords(int len) async {

    setState(() {
      _listWords = [];
      _fetching = 1;
    });
    List<String> words = [];
    switch(len) {
      case 3:
        words = gen3(myController.text);
        break;
      case 4:
        words = gen4(myController.text);
        break;
      case 5:
        words = gen5(myController.text);
        break;
      case 6:
        words = gen6(myController.text);
        break;
      case 7:
        words = gen7(myController.text);
        break;
    }
    if(subController.text != "") {
      words = words.where((element) => element.contains(subController.text)).toList();
    }
    var list = await filterValidWords(words);
    setState(() {
      _listWords = list;
      _fetching = -1;
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

            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: myController,
                      onChanged: (text) {
                        // myController.text = myController.text.toUpperCase();
                        setState(() {
                          _letterCount = text.length;
                          _listWords = [];
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter input characters'
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: subController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Must Included sub-text'
                      ),
                    ),
                  ),
                ),
              ],
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
            Visibility(
                visible: _listWords.length == 0 && _fetching == 0,
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No Result found')
                )
            ),
            Visibility(
                visible: _fetching > 0,
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator()
                )
            ),

            new Expanded(
                child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: new GridView.builder
                      (
                        itemCount: _listWords.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).orientation ==
                          Orientation.landscape ? 3: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: (4 / 1),
                          ),
                        itemBuilder: (context, index,) {
                          return GestureDetector(
                          onTap:() {},
                            child: new Text(_listWords[index].toUpperCase(), style: TextStyle(fontSize: 30),)
                          );
                        }
                        // itemBuilder: (BuildContext ctxt, int Index) {
                        //   return new Text(_listWords[Index].toUpperCase(), style: TextStyle(fontSize: 30),);
                        // }
                    )
                )
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Visibility(
            visible: _letterCount >=3,
            child: Padding(
              padding: EdgeInsets.only(right: 0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black87,
                    // child: Icon(Icons.refresh),
                    child: Text('3'),
                    onPressed: () => _fetchWords(3)
              ))),
          ),
          Visibility(
              visible: _letterCount >=4,
            child: Padding(
                padding: EdgeInsets.only(right: 60),
                child:  Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black87,

                  // child: Icon(Icons.refresh),('
                  child: Text("4"),
                  onPressed: () => _fetchWords(4)
              )
            )
          )),
          Visibility(
              visible: _letterCount >=5,
              child: Padding(
                  padding: EdgeInsets.only(right: 120),
                  child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black87,
                      // child: Icon(Icons.refresh),('
                      child: Text("5"),
                      onPressed: () => _fetchWords(5)
                  )
              )
          )),

        Visibility(
            visible: _letterCount >=6,
              child: Padding(
                  padding: EdgeInsets.only(right: 180),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black87,

                          // child: Icon(Icons.refresh),('
                          child: Text("6"),
                          onPressed: () => _fetchWords(6)
                      )
                  )
              )),
          Visibility(
              visible: _letterCount >=7,
              child: Padding(
                  padding: EdgeInsets.only(right: 240),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black87,

                          // child: Icon(Icons.refresh),('
                          child: Text("7"),
                          onPressed: () => _fetchWords(7)
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
