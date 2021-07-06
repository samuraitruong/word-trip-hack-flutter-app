List<String> gen3(String input) {
  List<String> results = [];

  for( var i1 = 0 ; i1< input.length; i1++ ) {
    for( var i2 = 0 ; i2< input.length; i2++ ) {
      for( var i3 = 0 ; i3< input.length; i3++ ) {
        if(Set<int>.from([i1, i2, i3, i3]).length == 3) {
          results.add(input[i1] + input[i2] + input[i3]);
        }
      }
    }
  }
  var set = Set<String>.from(results);
  return set.toList();
}


List<String> gen4(String input) {
  List<String> results = [];

  for( var i1 = 0 ; i1< input.length; i1++ ) {
    for( var i2 = 0 ; i2< input.length; i2++ ) {
      for( var i3 = 0 ; i3< input.length; i3++ ) {
        for (var i4 = 0; i4 < input.length; i4++) {
          if(Set<int>.from([i1, i2, i3, i4]).length == 4) {
            results.add(input[i1] + input[i2] + input[i3] + input[i4]);
          }
        }
      }
    }
  }
  var set = Set<String>.from(results);
  return set.toList();
}


List<String> gen5(String input) {
  List<String> results = [];

  for( var i1 = 0 ; i1< input.length; i1++ ) {
    for( var i2 = 0 ; i2< input.length; i2++ ) {
      for( var i3 = 0 ; i3< input.length; i3++ ) {
        for (var i4 = 0; i4 < input.length; i4++) {
          for (var i5 = 0; i5 < input.length; i5++) {
            if (Set<int>.from([i1, i2, i3, i4, i5]).length == 5) {
              results.add(input[i1] + input[i2] + input[i3] + input[i4] + input[i5]);
            }
          }
        }
      }
    }
  }
  var set = Set<String>.from(results);
  return set.toList();
}

List<String> gen6(String input) {
  List<String> results = [];

  for( var i1 = 0 ; i1< input.length; i1++ ) {
    for( var i2 = 0 ; i2< input.length; i2++ ) {
      for( var i3 = 0 ; i3< input.length; i3++ ) {
        for (var i4 = 0; i4 < input.length; i4++) {
          for (var i5 = 0; i5 < input.length; i5++) {
            for (var i6 = 0; i6 < input.length; i6++) {
              if (Set<int>.from([i1, i2, i3, i4, i5, i6]).length == 6) {
                results.add(
                    input[i1] + input[i2] + input[i3] + input[i4] + input[i5] + input[i6]);
              }
            }
          }
        }
      }
    }
  }
  var set = Set<String>.from(results);
  return set.toList();
}
