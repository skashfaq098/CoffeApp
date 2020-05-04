import 'package:firenew/services/auth.dart';
import 'package:firenew/shared/constants.dart';
import 'package:firenew/shared/loading.dart';
import 'package:flutter/material.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey=GlobalKey<FormState>();
  String email="";
  String pass="";
  String error="";
  bool loading=false;
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(appBar: new AppBar(title:Text('Sign in to Brew crew'),
    actions: <Widget>[FlatButton.icon(onPressed: (){
      widget.toggleView();
    }, icon: Icon(Icons.person), label: Text('Register'))],
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
              validator: (val)=>val.isEmpty?'Enter Email':null,
              
              onChanged: (val){
                setState(() => email=val
                  
                );
              },
            ),
            SizedBox(height: 20,),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Password'),
              validator: (val)=>val.length<6?'Enter password with 6+ chars':null,
              obscureText: true,
              onChanged: (val){
                setState(() => pass=val
                  
                );

              },
            ),
            SizedBox(height: 20,),

            RaisedButton(
              child: Text('Sign in'),
              onPressed: () async{
                if(_formKey.currentState.validate())
                {
                  setState(() => loading=true
                    
                  );
                  dynamic result=await _auth.signInWithEmailAndPassword(email, pass);
                  
                  if(result==null){
                    setState(() {
                      

                      error='Could not Sign in';
                      loading=false;
                    });

                  }
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