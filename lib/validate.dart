import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:math';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';

Future<bool> isWordExist(String word) async {

  var response = await http.head(Uri.parse('https://samuraitruong.github.io/open-vn-en-dict/data/' + word.toLowerCase() + ".json"));
  // print(word + "--- " + response.statusCode.toString());
  if (response.statusCode == 200) {
    return true;
  }

  return false;
}


Future<List<String>> filterValidWords(List<String> list) async {
  List<String> outputs  = [''];
  final LocalStorage storage = new LocalStorage('word_trip_hack_app');
  var str = storage.getItem('cache');
  if(str == null) {
    str = "{}";
  }
  Map<String, dynamic> current = jsonDecode(str);
  for(var i=0; i< list.length; ) {
    var subList = list.sublist(i, min(i + 50, list.length));
    i += 50;

    await Future.wait(subList.map((String word) async {
      if (current[word] == 0) return word;
      if (current[word] == 1) {
        outputs.add(word);
        return word;
      }

      try {
        if (await isWordExist(word)) {
          print('Valid ' + word);
          current[word] = 1;
          outputs.add(word);
        } else {
          current[word] = 0;
        }
      } catch (err) {
        print(err);
      }
      return word;
    }));
  }
  storage.setItem('cache', jsonEncode(current));

  // await Future.forEach(list, (String word) async =>  {
  //   if(await isWordExist(word)){
  //     print('valid word ' + word),
  //     outputs.add(word)
  //   }
  // });
  // print('Return me' + outputs.toString());
  outputs.sort((a,b) => a.compareTo(b));
  return outputs;
}