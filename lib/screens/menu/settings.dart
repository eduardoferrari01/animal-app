import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [

       Card(child: Column( mainAxisSize: MainAxisSize.min,children :<Widget> [
         const ListTile(
           leading: Icon(Icons.android),
           title: Text('Versão do app'),
           subtitle: Text('1.0.0-alfa'),
         ),

       ],),)

    ],);
  }
}



