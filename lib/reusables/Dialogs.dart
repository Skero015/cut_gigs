import 'dart:ui';
import 'package:cut_gigs/screens/EventDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


//the main dialog to be used in the app
class MainDialogBox extends StatefulWidget {
  final String title, descriptions, buttonText;
  final Image img;

  const MainDialogBox({Key key, this.title, this.descriptions, this.buttonText, this.img}) : super(key: key);

  @override
  _MainDialogBoxState createState() => _MainDialogBoxState();
}

class _MainDialogBoxState extends State<MainDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20,top: 45
              + 20.0, right: 20,bottom: 20
          ),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text(widget.descriptions,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(widget.buttonText,style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                child: Image.asset("images/speaker1.png")
            ),
          ),
        ),
      ],
    );
  }
}

// dialog for entering information in the app
class CommunicationDialogBox extends StatefulWidget {
  final String title, buttonText;
  final AsyncSnapshot snapshot;
  final int index;
  final Image img;

  const CommunicationDialogBox({Key key, this.title, this.snapshot, this.buttonText, this.index, this.img}) : super(key: key);

  @override
  _CommunicationDialogBoxState createState() => _CommunicationDialogBoxState();
}

class _CommunicationDialogBoxState extends State<CommunicationDialogBox> {

  final GlobalKey<FormState> _formKeyPassword = GlobalKey<FormState>(debugLabel: '_CommunicationDialogBoxState');
  final TextEditingController _password = new TextEditingController();

  bool _autoValidate = false;
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20,top: 45
              + 20.0, right: 20,bottom: 20
          ),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Form(
            autovalidate: _autoValidate,
            key: _formKeyPassword,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                SizedBox(height: 15,),
                TextFormField(
                  controller: _password,
                  decoration: new InputDecoration(
                    labelText: widget.title,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if(val.isEmpty) {
                      return "Password cannot be empty";
                    }else if(val.toLowerCase().trim() != widget.snapshot.data[widget.index].password.toLowerCase().trim()) {
                      return "Incorrect password";
                    }else{
                      return null;
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 22,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                      onPressed: (){
                        print(_formKeyPassword.currentState.validate());
                        print(_password.text);
                        print(widget.snapshot.data[widget.index].password);
                        if(_formKeyPassword.currentState.validate()){

                          try{

                            print('timer for: textInput');
                            SystemChannels.textInput.invokeMethod('TextInput.hide');

                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetailsScreen()));

                          }catch(e){

                          }
                        }else{
                          setState(() => _autoValidate = true);
                        }

                      },
                      child: Text(widget.buttonText,style: TextStyle(fontSize: 18),)),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                child: Image.asset("images/speaker1.png")
            ),
          ),
        ),
      ],
    );
  }
}