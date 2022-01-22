import 'package:flutter/material.dart';

class Progress extends StatelessWidget {

  final String message;

  const Progress({Key? key, this.message = 'Loading'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[const CircularProgressIndicator(), Text(message)],
      ),
    );
  }
}
