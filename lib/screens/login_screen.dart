import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes/screens/home_screen.dart';
import 'package:quotes/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:quotes/widgets/clipPainter.dart';
import '../main.dart';

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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0277*width),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 0.0135*height, bottom: 0.0135*height),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 0.0333*width, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController control,String hint,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0135*height,horizontal: 0.0277*width),
      width: 0.833*width,
      height: 0.1032*height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 0.0416*width),
          ),
          SizedBox(
            height: 0.0135*height,
          ),
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              hintText: validate?"Please fill the details":hint,
              hintStyle: validate?TextStyle(color: Colors.red,fontSize: 0.0286*width,fontWeight: FontWeight.bold):TextStyle(color: Colors.black26,fontSize: 0.0416*width,fontWeight: FontWeight.bold),
            ),
            scrollPadding: EdgeInsets.all(0.0277*width),
            controller: control,

          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Padding(
      padding: EdgeInsets.all(0.0416*width),
      child: Material(
        elevation: 0.0067*height,
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xffe46b10),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width / 2.7,
          height: MediaQuery.of(context).size.width / 10.7,
          padding: EdgeInsets.fromLTRB(0.0277*width, 0.0203*height, 0.0277*width, 0.0203*height),
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 0.0472*width,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            if(email.text==""){
              setState(() {
                validate = true;
              });
            }
            else{
              try {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("user", email.text);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              } catch (e) {
                print(e);
              }
            }
          },
        ),
      ),
    );
  }


  Widget _title() {
    return Container(
      width: 0.333*width,
      height: 0.163*height,
      child: Image(image: AssetImage("images/saidattavikas-foundation.png"),),
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
    setState(() {
      validate = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _willpop() {
    Navigator.of(context).pop(true);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Signup()));
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return InteractiveViewer(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: _willpop,
          child: Container(
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
                  padding: EdgeInsets.symmetric(horizontal: 0.055*width),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 0.2717*height),
                        _title(),
                        SizedBox(
                          height: 0.0543*height,
                        ),
                        _emailPasswordWidget(),
                        SizedBox(
                          height: 0.0271*height,
                        ),
                        _submitButton(),
                      ],
                    ),
                  ),
                ),
                Positioned(top: 0.0543*height, left: 0, child: _backButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}