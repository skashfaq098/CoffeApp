import 'package:firenew/services/auth.dart';
import 'package:firenew/shared/constants.dart';
import 'package:firenew/shared/loading.dart';
import 'package:flutter/material.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey= GlobalKey<FormState>();
  String email="";
  String password="";
  String error="";
  bool loading=false;
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
      return loading?Loading(): Scaffold(appBar: new AppBar(title:Text('Sign up to Brew crew'),
      actions: <Widget>[FlatButton.icon(onPressed: (){
        widget.toggleView();
      }, icon: Icon(Icons.person), label: Text('Sign in'))], 
    ),
    body: Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(50, 20, 50, 0),
      
        child:Form(
          
          key: _formKey,
          child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Email'),
              validator: (val)=>val.isEmpty?'Enter Correct Email':null,
              
              onChanged: (val){
                setState(() => email=val
                  
                );
              },
            ),
            SizedBox(height: 20,),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: "Password"),
              
              validator: (val)=>val.length<6?'Enter password with 6+ chars':null,

              obscureText: true,
              onChanged: (val){
                setState(() => password=val
                  
                );

              },
            ),
            SizedBox(height: 20,),

            RaisedButton(
              child: Text('Register'),
              onPressed: ()async{
                if(_formKey.currentState.validate()){
                  setState(() {
                    loading=true;
                  });
                  dynamic result=await _auth.registerWithEmailAndPassword(email, password);
                  
                if(result == null){
                  setState(() { 
                    error="Enter valid email and password";
                    loading=false;
                    
                 } );}

                
                }
              }),
              SizedBox(height: 20,),

              Text(error,
              style: TextStyle(color:Colors.red,fontSize: 14),
              ),

            
          ],
        )),
      ),
    ),
    );
  }
}