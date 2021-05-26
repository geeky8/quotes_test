import 'dart:ui';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quotes/screens/login_screen.dart';
import 'dart:math';
import 'package:quotes/widgets/clipPainter.dart';
import 'package:quotes/widgets/country_dropdown.dart';

import '../main.dart';

class Signup extends StatefulWidget {
  Signup({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email;
  TextEditingController name;
  TextEditingController phone;
  String initCountry = "IN";
  TextEditingController state;
  TextEditingController city;
  String country;
  Dio _dio = Dio();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
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
      width: 0.777*width,
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
      padding: EdgeInsets.all(0.04166*width),
      child: Material(
        elevation: 0.0067*height,
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xffe46b10),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width / 2.7,
          height: MediaQuery.of(context).size.width / 10.7,
          padding: EdgeInsets.fromLTRB(0.0416*width, 0.0203*height, 0.0277*width, 0.0203*height),
          child: Text(
            "Register Now",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 0.0472*width,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            if(name.text=="" ||email.text==""||phone.text==""||city.text==""){
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
                saveUser(name.text, email.text, country, city.text, "${number}${phone.text}");
              } catch (e) {
                print(e);
              }
            }
          },
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.0067*height),
        padding: EdgeInsets.all(0.0055*width),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 0.0361*width, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 0.0277*width,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                print("${number}${phone.text}");
              },
              child: Text(
                'Login',
                style: TextStyle(
                    color: Color(0xfff79c4f),
                    fontSize: 0.0361*width,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
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
        _entryField("Name", name,"Name"),
        _entryField("Email id", email,"E-mail"),
        Padding(
          padding: EdgeInsets.only(left: 0.0277*width),
          child: Text('Country',style: TextStyle(fontSize: 0.04166*width,fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: 0.0135*height,),
        Padding(
          padding: EdgeInsets.only(left: 0.0277*width),
          child: Container(
            width: 0.777*width,
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Country(
              countryChange: (dynamic value){
                setState(() {
                  country = value;
                });
              },
              country: country,
            ),
          ),
        ),
        _entryField("City", city,"City"),
        SizedBox(height: 0.0135*height,),
        Container(
          margin: EdgeInsets.symmetric(vertical: 0.0135*height,horizontal: 0.0277*width),
          width: 0.777*width,
          height: 0.1032*height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Phone",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 0.0416*width),
              ),
              SizedBox(
                height: 0.0135*height,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width:0.250*width,
                    child: CountryCodePicker(
                      initialSelection: 'IN',
                      onChanged: (value){
                        setState(() {
                          number = value.toString();
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 0.526*width,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                        hintText: validate?"Please fill the details":"Enter Number",
                        hintStyle: validate?TextStyle(color: Colors.red,fontSize: 0.0286*width,fontWeight: FontWeight.bold):TextStyle(color: Colors.black26,fontSize: 0.0416*width,fontWeight: FontWeight.bold),
                      ),
                      scrollPadding: EdgeInsets.all(0.0277*width),
                      controller: phone,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    email = new TextEditingController();
    name = new TextEditingController();
    phone = new TextEditingController();
    city = new TextEditingController();
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

  Future<void> saveUser(String name,String email,String country,String city, String number) async{
    var params = {
      "name": name,
      "emailID" : email,
      "country" : country,
      "city" : city,
      "phone": number
    };
    await _dio.post("http://swiftinit.net:813/RegisterUser",queryParameters: params);
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: Scaffold(
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
                padding: EdgeInsets.symmetric(horizontal: 0.0271*height),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * 0.08),
                      _title(),
                      SizedBox(
                        height: 0,
                      ),
                      _emailPasswordWidget(),
                      SizedBox(
                        height: 0.0271*height,
                      ),
                      _submitButton(),
                      _loginAccountLabel(),
                    ],
                  ),
                ),
              ),
              Positioned(top: 0.0543*height, left: 0, child: _backButton()),
            ],
          ),
        ),
      ),
    );
  }
}
