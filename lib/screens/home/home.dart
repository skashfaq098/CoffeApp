import 'package:firenew/models/brew.dart';
import 'package:firenew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firenew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firenew/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth =AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      
          child: Scaffold(appBar: new AppBar(title:Text('Brew Brew'),

      actions: <Widget>[
        FlatButton.icon(onPressed: ()async{
          await _auth.signOUt();
        }, icon: Icon(Icons.person), label: Text('Logout'))
      ],
      ),
      body: BrewList(),
      ),
    );
  }
}