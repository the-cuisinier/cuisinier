double hamingDistanceErrorPercentage(String one, String two){
  var count = 0;
  var firstString = one.toLowerCase().trim();
  var secondString = two.toLowerCase().trim();
  if(firstString.length < secondString.length){
    for(var i = 0; i < firstString.length; i++){
      if(firstString[i] != secondString[i]){
        count = count + 1;
      }
    }
    return count / firstString.length;
  }
  else{
    for(var i = 0; i < secondString.length; i++){
      if(firstString[i] != secondString[i]){
        count = count + 1;
      }
    }
    return count / secondString.length;
  }
}