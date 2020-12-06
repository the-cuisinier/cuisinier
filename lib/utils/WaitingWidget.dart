import 'package:flutter/material.dart';

class WaitingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/fetchData.png"),
          SizedBox(
            height: 32,
          ),
          Text("Fetching your data")
        ],
      ),
    );
  }
}