import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:cuisinier/screens/deliciora-dish.dart';
import 'package:cuisinier/utils/WaitingWidget.dart';

class DelicioraScreen extends StatefulWidget {
  @override
  _DelicioraScreenState createState() => _DelicioraScreenState();
}

class _DelicioraScreenState extends State<DelicioraScreen> {

  bool hasMadeRequest = false, waitingForServerResponse = true;
  String localhostIP = '192.168.43.95';
  File _image;
  final picker = ImagePicker();
  List<Widget> delicioraAiResults = List();
  TextEditingController ipController = TextEditingController();

  getResults() async {
    setState(() {
      delicioraAiResults.clear();
      hasMadeRequest = true;
      waitingForServerResponse = true;
    });
    var url = 'http://$localhostIP:8000/upload/api';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    var fileName = _image.path.split("/").last;
    request.files.add(
      http.MultipartFile(
        'image',
        _image.readAsBytes().asStream(),
        _image.lengthSync(),
        filename: fileName
      )
    );
    http.Response response = await http.Response.fromStream(await request.send());
    Map<String, dynamic> result = json.decode(response.body.toString());
    await Future.delayed(Duration(seconds: 2));
    for (var key in result.keys){
      var newWidget = ListTile(
        key: Key(key),
        title: Text(
          result[key]["name"],
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w300
          ),
        ),
        trailing: Icon(Icons.chevron_right),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => DelicioraDishScreen(
                image: _image,
                title: result[key]["name"],
                ingredients: result[key]["ingredients"],
                steps: result[key]["instructions"]
              )
            )
          );
        },
      );
      delicioraAiResults.add(newWidget);
    }
    setState(() {
      waitingForServerResponse = false;
    });
  }

  Future pickImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    setState(() {
      hasMadeRequest = false;
    });
    if(await _image.exists()){
      await getResults();
    }
  }

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    setState(() {
      hasMadeRequest = false;
    });
    if(await _image.exists()){
      await getResults();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasMadeRequest ? waitingForServerResponse ? WaitingWidget() : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Image.file(_image),
              ),
            ),
            SizedBox(
              height: 36,
            ),
            Column(
              children: delicioraAiResults,
            )
          ]
        ),
      ) : DelicioraInformationScreen(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "Camera Upload",
            onPressed: () => pickImageFromCamera(),
            child: Icon(Icons.camera_alt),
          ),
          SizedBox(
            height: 18,
          ),
          FloatingActionButton(
            heroTag: "Gallery Image Upload",
            onPressed: () => pickImageFromGallery(),
            child: Icon(Icons.image),
          ),
        ],
      ),
    );
  }
}

class DelicioraInformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 54,
            ),
            Text(
              "What is Deliciora?",
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 24
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Image.asset(
                "assets/images/ai-vector.jpg"
              ),
            ),
            SizedBox(
              height: 42,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 32
              ),
              child: Text(
                "Deliciora is a smart system which recognises the image of a dish, and tells the recipe of the dish.\n\nJust click the image of a dish, and we'll tell you how you can make that dish. Feel free to try it out.",
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 16.5
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ),
    );
  }
}