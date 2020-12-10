import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import '../utils/tagWidget.dart';

class RecipeCard extends StatelessWidget {

  final List docs;
  RecipeCard({
    @required this.docs
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 64),
      child: ListView.builder(
        itemCount: docs.length,
        itemBuilder: (BuildContext context, int index) {
          // List<Widget> listOfTagElements = List();
          // for (var item in this.docs[index]["tags"]) {
          //   var newTag = Tag(
          //     item: item
          //   );
          //   listOfTagElements.add(newTag);
          // }
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 12, vertical: 20),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        docs[index]["name"],
                        style: GoogleFonts.montserrat(
                            color: Colors.green,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                      // subtitle: Padding(
                      //   padding: EdgeInsets.symmetric(vertical: 8),
                      //   child: Row(
                      //     crossAxisAlignment:
                      //         CrossAxisAlignment.start,
                      //     children: listOfTagElements
                      //   ),
                      // ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.article_outlined),
                          label: Text(
                            "Read more",
                            style: GoogleFonts.montserrat(
                              fontSize: 14
                            ),
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
      )
    );
  }
}