import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:quotes/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'dart:math';
import 'package:quotes/widgets/clipPainter.dart';
import 'package:quotes/widgets/country_dropdown.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email;

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController control,String hint,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      width: 300,
      height: 76,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black26,fontSize: 15,fontWeight: FontWeight.bold),
            ),
            scrollPadding: EdgeInsets.all(10),
            controller: control,

          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    // return GestureDetector(
    //   child: Container(
    //     width: MediaQuery.of(context).size.width,
    //     padding: EdgeInsets.symmetric(vertical: 15),
    //     alignment: Alignment.center,
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.all(Radius.circular(5)),
    //         boxShadow: <BoxShadow>[
    //           BoxShadow(
    //               color: Colors.grey.shade200,
    //               offset: Offset(2, 4),
    //               blurRadius: 5,
    //               spreadRadius: 2)
    //         ],
    //         gradient: LinearGradient(
    //             begin: Alignment.centerLeft,
    //             end: Alignment.centerRight,
    //             colors: [Color(0xfffbb448), Color(0xfff7892b)])),
    //     child: Text(
    //       'Register Now',
    //       style: TextStyle(fontSize: 20, color: Colors.white),
    //     ),
    //   ),
    // );
    return Padding(
      padding: EdgeInsets.all(15),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xffe46b10),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width / 2.7,
          height: MediaQuery.of(context).size.width / 10.7,
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            try {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("user", email.text);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            } catch (e) {
              print(e);
            }
            // print(email.text);
            // print(name.text);
            // print(country);
            // print(city.text);
            // print(number.phoneNumber);
          },
        ),
      ),
    );
  }


  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Q',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'uo',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'tes',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _entryField("Email id", email,"E-mail"),
      ],
    );
  }

  @override
  void initState() {
    email = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    exit();
    super.dispose();
  }

  Future<void> exit() async{
    await SystemNavigator.pop();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: Container(
                  child: Transform.rotate(
                    angle: -pi / 3.5,
                    child: ClipPath(
                      clipper: ClipPainter(),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xfffbb448), Color(0xffe46b10)])),
                      ),
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 230),
                    _title(),
                    SizedBox(
                      height: 60,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}