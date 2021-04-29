import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:quotes/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quotes/screens/login_screen.dart';
import 'dart:math';
import 'package:quotes/widgets/clipPainter.dart';
import 'package:quotes/widgets/country_dropdown.dart';

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
  PhoneNumber number = PhoneNumber(isoCode: "IN");
  // TextEditingController password;
  TextEditingController state;
  TextEditingController city;
  String country;
  Dio _dio = Dio();
  // String state;
  // String city;

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
      width: 280,
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
            "Register Now",
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
              saveUser(name.text, email.text, country, city.text, number.phoneNumber);
            } catch (e) {
              print(e);
            }
            // print(email.text);
            // print(name.text);
            print(country);
            // print(city.text);
            // print(number.phoneNumber);
          },
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                print(country);
              },
              child: Text(
                'Login',
                style: TextStyle(
                    color: Color(0xfff79c4f),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
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
        _entryField("Name", name,"Name"),
        _entryField("Email id", email,"E-mail"),
        // _entryField("Password",password, isPassword: true),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('Country',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Container(
            width: 280,
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
              // onCountryChanged: (value){
              //   setState(() {
              //     country = value;
              //   });
              // },
              // style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),
            ),
          ),
        ),
        _entryField("City", city,"City"),
        // _entryField("City", city),
        SizedBox(height: 10,),
        InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber value) {
            setState(() {
              number = value;
            });
          },
          onFieldSubmitted: (String value){
            print(number.phoneNumber);
          },
          // onSubmit: (){print(phone.text);},
          initialValue: number,
          textFieldController: phone,
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          selectorTextStyle: TextStyle(color: Colors.black),
          autoValidateMode: AutovalidateMode.disabled,
          inputBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.black,width: 1.1,style: BorderStyle.solid),
          ),
          spaceBetweenSelectorAndTextField: 16,
          searchBoxDecoration: InputDecoration(
            focusColor: Color(0xffe46b10),
          ),
          inputDecoration: InputDecoration(focusColor:Color(0xffe46b10) ),
        )
      ],
    );
  }

  @override
  void initState() {
    email = new TextEditingController();
    name = new TextEditingController();
    phone = new TextEditingController();
    city = new TextEditingController();
    // password = new TextEditingController();
    // country = new TextEditingController();
    // city = new TextEditingController();
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
                    SizedBox(height: height * 0.15),
                    _title(),
                    SizedBox(
                      height: 30,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    _loginAccountLabel(),
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
