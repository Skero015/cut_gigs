import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _email = new TextEditingController();
  //final TextEditingController _title = new TextEditingController();
  final TextEditingController _fullNames = new TextEditingController();
  final TextEditingController _surname = new TextEditingController();
 // final TextEditingController _country = new TextEditingController();
  final TextEditingController _phoneNumber = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  String titleDropdownValue ;
  String countryDropdownValue ;

  //List title = <String>['Mr', 'Ms', 'Mrs', 'Miss', 'Dr', 'Prof', 'Sir'];

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  padding: const EdgeInsets.only(left: 70.0, top: 160),
                  child: Text(
                    'SIGN UP',
                    style: GoogleFonts.poppins(
                        fontSize: 35, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70.0, top: 10),
                  child: Text(
                    'Sign up to continue to our application',
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 80.0, top: 40, right: 80),
                  child: TextFormField(
                    autofocus: false,
                    controller: _email,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: GestureDetector(
                          //wrap this around any widget to give it an onTap feature
                          //e.g) The image below can now be tapped and perform any task you want it to perform
                          child: Image.asset(
                            'images/EmailIcon.png',
                            width: 10,
                            height: 10,
                          ),
                          onTap: () {
                            setState(() {});
                          },
                        ),
                      ),
                      hintText: 'example@email.com',
                      contentPadding:
                      EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
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
                        //The line of the editText changes to red when the validator returns an error
                        borderSide: BorderSide(
                          color: Color(0xFFAB1217),
                        ),
                      ),
                    ),
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 80.0, top: 40, right: 80),
                  child: DropdownButton<String>(
                    hint: Text('Title'),
                    value: titleDropdownValue,
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 425.0),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 39,
                      ),
                    ),
                    underline: Container(
                      height: 2,
                      color: Color(0xFF15AAD9),
                    ),
                    items: <String>[
                      'Mr',
                      'Ms',
                      'Mrs',
                      'Miss',
                      'Dr',
                      'Prof',
                      'Sir'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        titleDropdownValue = newValue;
                      });
                    },
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 80.0, top: 40, right: 80),
                  child: TextFormField(
                    autofocus: false,
                    controller: _fullNames,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: GestureDetector(
                          //wrap this around any widget to give it an onTap feature
                          //e.g) The image below can now be tapped and perform any task you want it to perform
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 40,
                          ),
                          onTap: () {
                            setState(() {});
                          },
                        ),
                      ),
                      hintText: 'Full Names',
                      contentPadding:
                      EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
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
                        //The line of the editText changes to red when the validator returns an error
                        borderSide: BorderSide(
                          color: Color(0xFFAB1217),
                        ),
                      ),
                    ),
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 80.0, top: 40, right: 80),
                  child: TextFormField(
                    autofocus: false,
                    controller: _surname,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: GestureDetector(
                          //wrap this around any widget to give it an onTap feature
                          //e.g) The image below can now be tapped and perform any task you want it to perform
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 40,
                          ),
                          onTap: () {
                            setState(() {});
                          },
                        ),
                      ),
                      hintText: 'Surname',
                      contentPadding:
                      EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
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
                        //The line of the editText changes to red when the validator returns an error
                        borderSide: BorderSide(
                          color: Color(0xFFAB1217),
                        ),
                      ),
                    ),
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 80.0, top: 40, right: 80),
                  child: DropdownButton<String>(
                    hint: Text('Country'),
                    value: countryDropdownValue,
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 376.0),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 39,
                      ),
                    ),
                    underline: Container(
                      height: 2,
                      color: Color(0xFF15AAD9),
                    ),

                    onChanged: (String newValue) {
                      setState(() {
                        countryDropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'South Africa',
                      'Namibia',
                      'Zimbabwe',
                      'Kenya',
                      'Nigeria',
                      'Congo',
                      'Swaziland'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),

                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 80.0, top: 40, right: 80),
                  child: TextFormField(
                    autofocus: false,
                    controller: _phoneNumber,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: GestureDetector(
                          //wrap this around any widget to give it an onTap feature
                          //e.g) The image below can now be tapped and perform any task you want it to perform
                          child: Icon(
                            Icons.phone,
                            color: Colors.black,
                            size: 40,
                          ),
                          onTap: () {
                            setState(() {});
                          },
                        ),
                      ),
                      hintText: 'Phone Number',
                      contentPadding:
                      EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
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
                        //The line of the editText changes to red when the validator returns an error
                        borderSide: BorderSide(
                          color: Color(0xFFAB1217),
                        ),
                      ),
                    ),
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 80.0, top: 40, right: 80),
                  child: TextFormField(
                    autofocus: false,
                    controller: _password,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: GestureDetector(
                          //wrap this around any widget to give it an onTap feature
                          //e.g) The image below can now be tapped and perform any task you want it to perform
                          child: Icon(
                            Icons.lock,
                            color: Colors.black,
                            size: 40,
                          ),
                          onTap: () {
                            setState(() {});
                          },
                        ),
                      ),
                      hintText: 'Password',
                      contentPadding:
                      EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
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
                        //The line of the editText changes to red when the validator returns an error
                        borderSide: BorderSide(
                          color: Color(0xFFAB1217),
                        ),
                      ),
                    ),
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                Center(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 40.0, left: 80, right: 80),
                    child: RaisedButton(
                      //Button comes with its own onTap or onPressed method .... I do not normally decorate buttons with Ink and Container widgets, I had to find a way to give it gradient colors since RaisedButton does not come with the decoration: field
                      onPressed: () {
                        //In this onPressed of the RaisedButton we will not need the setState method because
                        // we are not changing the state of the UI.
                        //We will only be this button to navigate to authenticate the user and move to a different screen
                      }, //Ink widget here, is a child of the Button, learning more about it however...
                      child: Ink(
                        //The Ink widget allowed us to decorate the button as we wish (we needed to use it for the color gradients) .
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            Color(0xFF15AAD9),
                            Color(0xFF7EE0FF),
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Container(
                            constraints: const BoxConstraints(
                                minWidth: 50.0, minHeight: 70),
                            alignment: Alignment.center,
                            child: Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  letterSpacing: 0.8),
                            )),
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
        ],
      ),
    );
  }
}
