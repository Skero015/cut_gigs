import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>(debugLabel: '_LoginScreenState');
  final GlobalKey<ScaffoldState> _scaffoldKeyLogin = new GlobalKey<ScaffoldState>(debugLabel: '_LoginScreenState');

  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
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
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            child: Image.asset('images/EmailIcon.png', width: 10, height: 10,),
                            onTap: (){

                              setState(() {

                              });

                            },
                          ),
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
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFAB1217),),
                        ),
                      ),
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 80.0,top: 40, right: 80),
                    child: TextFormField(
                      autofocus: false,
                      controller: _password,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            child: Image.asset('images/Vector.png', width: 2, height: 2,),
                            onTap: (){

                              setState(() {

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
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFAB1217),),
                        ),
                      ),
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: GestureDetector(
                          child: Text('Forgot Password ?',style: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400, color: Colors.grey[600], letterSpacing: 0.8),),

                        onTap: () {

                        },

                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40.0,left: 80, right: 80),
                      child: RaisedButton(
                        onPressed: () {

                        },
                          child: Ink(
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
                      child: RaisedButton(
                        onPressed: () {

                        },
                        child: Ink(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFF15AAD9),
                                  Color(0xFFAB1217),
                                ]
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Container(
                              constraints: const BoxConstraints(minWidth: 50.0, minHeight: 70),
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
          )),
        ],
      ),
    );
  }
}
