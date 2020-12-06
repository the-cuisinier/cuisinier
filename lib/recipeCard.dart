import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new DisplayPage(),
    );
  }
}

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  // Widget _imgWidget(){
  //   return new Container(
  //     padding: const EdgeInsets.all(8.0),
  //     decoration: BoxDecoration(
  //       image: DecorationImage(image: AssetImage("assets/images/pihu.jpg"), fit: BoxFit.cover)
  //     ),

  // );
  // }
  Widget _imgWidget() {
    return new Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),

        // child: InkWell(
        //   onTap: () => print("ciao"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // add this
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.asset('assets/images/pihu.jpg',
                  width: 300, height: 150, fit: BoxFit.fill),
            ),
            //  ListTile(
            // //   //leading: Icon(Icons.add),
            //    title: new Text('Veggies, Salami, and Boursin'),
            //    trailing: Icon(Icons.favorite_border),
            // //   //subtitle: Text('Location 1'),
            //  ),
          ],
        ),
      ),
      //),
    );
  }

  Widget _RecipeCardwidget() {
    var Width = MediaQuery.of(context).size.width / 1.2;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: new Container(
        height: 300,
        width: Width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/pihu.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 16,
              ),
              color: Colors.white38,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Text(
                    "Veggies, Salami, and Boursin",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.favorite_border,
                    size: 32,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Home Page"),
        ),
        body: new Column(
          children: <Widget>[
            new Text("yashika"),
            Center(
              //child: _imgWidget()
              child: _RecipeCardwidget(),
            )
          ],
        ));
  }
}
