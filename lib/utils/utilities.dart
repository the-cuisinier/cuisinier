List<String> spotifyPlaylists = [
  "https://open.spotify.com/playlist/3o7230LSFvwTLl3ZyjBE0x",
  "https://open.spotify.com/playlist/2Nsd4rLKXdDUcSdDWKQ1D6",
  "https://open.spotify.com/playlist/0YLV1AgMw1RajVlMqde6tx",
  "https://open.spotify.com/playlist/7MaYipYx1Vsgap7CMTBXCu",
  "https://open.spotify.com/playlist/37i9dQZF1DZ06evO2GAl7Q",
  "https://open.spotify.com/playlist/37i9dQZF1DZ06evO0dlbQk",
  "https://open.spotify.com/playlist/0l88QNwuL9LCTFjzrTlstQ",
  "https://open.spotify.com/playlist/37i9dQZF1DWY2kRx09S3yf",
  "https://open.spotify.com/playlist/37i9dQZF1DZ06evO1rXMLC",
  "https://open.spotify.com/playlist/6lmQEYJGnghRK3aV8xMm8i",
  "https://open.spotify.com/playlist/37i9dQZF1DX8xfQRRX1PDm",
  "https://open.spotify.com/playlist/37i9dQZF1DX3wwp27Epwn5",
  "https://open.spotify.com/playlist/37i9dQZF1DWTUfv2yzHEe7",
  "https://open.spotify.com/playlist/37i9dQZF1DX0XUfTFmNBRM",
  "https://open.spotify.com/playlist/37i9dQZF1DXaq7lvg1a3j6"
];

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