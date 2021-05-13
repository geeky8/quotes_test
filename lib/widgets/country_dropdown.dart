import 'dart:convert';
import 'package:country_state_city_picker/model/select_status_model.dart' as StatusModel;
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Country extends StatefulWidget {

  final Function countryChange;
  final String country;

  const Country(
      {Key key,
        this.countryChange,
        this.country})
      : super(key: key);

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {

  List<String> _country = ["Choose Country"];
  var responses;
  bool color = false;

  Future getResponse() async {
    var res = await rootBundle.loadString(
        'packages/country_state_city_picker/lib/assets/country.json');
    return jsonDecode(res);
  }

  Future getCounty() async {
    var countryres = await getResponse() as List;
    countryres.forEach((data) {
      var model = StatusModel.StatusModel();
      model.name = data['name'];
      model.emoji = data['emoji'];
      if (!mounted) return;
      setState(() {
        _country.add(model.emoji + "    " + model.name);
      });
    });

    return _country;
  }


  @override
  void initState() {
    getCounty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DropDownField(
          onValueChanged: widget.countryChange,
          value: widget.country,
          required: false,
          hintText: 'Choose a country',
          hintStyle: TextStyle(color: Colors.black26,fontSize: 15,fontWeight: FontWeight.bold),
          items: _country,
        ),
      ],
    );
  }
}
