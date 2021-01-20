import 'package:cut_gigs/config/validators.dart';
import 'package:cut_gigs/reusables/CustomBottomNavBar.dart';
import 'package:cut_gigs/reusables/Dialogs.dart';
import 'package:cut_gigs/screens/HomeScreen.dart';
import 'package:cut_gigs/screens/auth_screens/RegisterScreen.dart';
import 'package:cut_gigs/services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {

  String reason;
  LoginScreen({this.reason});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>(debugLabel: '_LoginScreenState');
  final GlobalKey<ScaffoldState> _scaffoldKeyLogin = new GlobalKey<ScaffoldState>(debugLabel: '_LoginScreenState');

  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  bool _autoValidate = false;
  bool _isBusyDialogVisible = false;
  FocusNode myFocusNode;
  final Auth _auth = Auth();

  bool isPasswordEyeTapped = false;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_){

      if(widget.reason == "verify email"){
        showDialog(context: context,
            builder: (BuildContext context){
              return MainDialogBox(
                title: "Verify Email",
                descriptions: "Thank you for registering. In order to login, first check your mail to confirm your email.",
                buttonText: "Ok",
              );
            }
        );
      }
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyLogin,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
        opacity: 0.16,
        inAsyncCall: _isBusyDialogVisible,
        progressIndicator: ColoredCircularProgressIndicator(
          strokeWidth: 5,
        ),
        child: Form(
          key: _formKeyLogin,
          autovalidate: _autoValidate,
          child: Stack(
            children: <Widget>[
              Image(
                image: AssetImage('images/MainBackground.png'),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget> [
                              Padding(
                                padding: const EdgeInsets.all(35.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage('images/AppBar.png'),
                                      fit: BoxFit.cover,
                                      height: 75.0,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 70.0, top: 310),
                                child: Text('SIGN IN',style: GoogleFonts.poppins(fontSize: 35, fontWeight: FontWeight.w500),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 70.0,top: 10),
                                child: Text('Sign in to continue',style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 80.0,top: 40, right: 80),
                                child: TextFormField(
                                  autofocus: false,
                                  controller: _email,
                                  validator: Validator.validateEmail,
                                  decoration: InputDecoration(
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Image.asset('images/EmailIcon.png', width: 10, height: 10,),
                                    ),
                                    hintText: 'example@email.com',
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black87),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFF15AAD9)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFF15AAD9)),
                                    ),
                                    errorBorder: UnderlineInputBorder(//The line of the editText changes to red when the validator returns an error
                                      borderSide: BorderSide(color: Color(0xFFAB1217),),
                                    ),
                                  ),
                                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 80.0,top: 40, right: 80),
                                child: TextFormField(//This is an EditText
                                  autofocus: false,//we tell the screen not to autofocus ( or auto click) on the EditText when it loads up
                                  controller: _password, // The controller holds the users text.. for the password, we will use password.text to grab the user's text
                                  validator: Validator.validatePassword,//validator: ---> validator for the EditText, will be defined later.. check Validator class under config package for example code.
                                  decoration: InputDecoration(//Allows us to decorate the EditText, below we placed the icon at the end (suffixIcon), placed a hint, did some padding and defined the unlinerline color according to its state
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: GestureDetector(//wrap this around any widget to give it an onTap feature
                                        //e.g) The image below can now be tapped and perform any task you want it to perform
                                        child: Image.asset('images/Vector.png', width: 2, height: 2,),
                                        onTap: (){

                                          setState(() {
                                            //In here, when the password eye icon on the right is clicked. It will change the state of the icon to a different icon
                                            //and allow the user to see the password they are typing in
                                          });

                                        },
                                      ),
                                    ),
                                    hintText: 'Password',
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black87),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFF15AAD9)),
                                    ),
                                    errorBorder: UnderlineInputBorder(//The line of the editText changes to red when the validator returns an error
                                      borderSide: BorderSide(color: Color(0xFFAB1217),),
                                    ),
                                  ),
                                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: GestureDetector(//wrap this around any widget to give it an onTap feature
                                    child: Text('Forgot Password ?',style: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400, color: Colors.grey[600], letterSpacing: 0.8),),

                                    onTap: () {
                                      //Here we can navigate to a screen or open a dialog when the user clicks the Forgot Password text
                                    },

                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 40.0,left: 80, right: 80),
                                  child: RaisedButton(//Button comes with its own onTap or onPressed method .... I do not normally decorate buttons with Ink and Container widgets, I had to find a way to give it gradient colors since RaisedButton does not come with the decoration: field
                                    onPressed: () {

                                      //In this onPressed of the RaisedButton we will not need the setState method because
                                      // we are not changing the state of the UI.
                                      //We will only be this button to navigate to authenticate the user and move to a different screen
                                      signIn(email: _email.text.trim(), password: _password.text.trim(), context: context);

                                    },//Ink widget here, is a child of the Button, learning more about it however...
                                    child: Ink(//The Ink widget allowed us to decorate the button as we wish (we needed to use it for the color gradients) .
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: <Color>[
                                              Color(0xFF15AAD9),
                                              Color(0xFF7EE0FF),
                                            ]
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                      child: Container(
                                          constraints: const BoxConstraints(minWidth: 50.0, minHeight: 70),
                                          alignment: Alignment.center,
                                          child: Text('Sign In',textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: 0.8),)),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 9.0,
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 40.0),
                                  child: Text('OR',style: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w500, color: Colors.black87, letterSpacing: 0.8),),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 40.0,left: 80, right: 80),
                                  child: RaisedButton(//Button comes with its own onTap or onPressed method .... I do not normally decorate buttons with Ink and Container widgets, I had to find a way to give it gradient colors since RaisedButton does not come with the decoration: field
                                    onPressed: () {

                                      //In this onPressed of the RaisedButton we will not need the setState method because
                                      // we are not changing the state of the UI.
                                      //We will only be using the button to navigate to the Register screen
                                      Navigator.of(context).push(new MaterialPageRoute(
                                          builder: (BuildContext context) => new RegisterScreen()));

                                    },//Ink widget here, is a child of the Button, learning more about it however...
                                    child: Ink(//The Ink widget allowed us to decorate the button as we wish (we needed to use it for the color gradients) .
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: <Color>[
                                              Color(0xFF15AAD9),
                                              Color(0xFFAB1217),
                                            ]
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),// The border radius of the Ink Widget decoration
                                      ),
                                      child: Container(
                                          constraints: const BoxConstraints(minWidth: 50.0, minHeight: 70),//
                                          alignment: Alignment.center,
                                          child: Text('Sign Up',textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: 0.8),)),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 9.0,
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  void signIn({String email, String password, BuildContext context}) async {

    if (_formKeyLogin.currentState.validate()) {
      try {
        print('timer for: textInput');
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        print('timer for: _changeLoadingVisible');
        await _changeBusyVisible();
        //need await so it has chance to go through error if found.
        // await StateWidget.of(context).logInUser(email, password);
        dynamic result = await _auth.signIn(email, password);
        if (result != null) {
          print('timer for: Wrapper');

          //retrieve data from database using async
          Navigator.of(context).pop();
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new CustomNavBar()));

          //dispose();
          //deactivate();

          _changeBusyVisible();
        } else {
          _changeBusyVisible();
        }
      } catch (e) {
        _changeBusyVisible();
        String exception = Auth.getExceptionText(e);
        _scaffoldKeyLogin.currentState.showSnackBar(SnackBar(
          content: new Text(exception),
          duration: new Duration(seconds: 5),
        ));

      }
    } else {
      setState(() => _autoValidate = true);
    }
  }

  Future<void> _changeBusyVisible() async {
    setState(() {
      _isBusyDialogVisible = !_isBusyDialogVisible;
    });
  }
}
