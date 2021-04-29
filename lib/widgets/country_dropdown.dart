import 'dart:convert';
import 'package:country_state_city_picker/model/select_status_model.dart' as StatusModel;
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Country extends StatefulWidget {

  final Function onCountryChanged;
  final Function countryChange;
  final TextStyle style;
  final Color dropdownColor;
  final String country;

  const Country(
      {Key key,
        this.onCountryChanged,
        this.style,
        this.dropdownColor,
        this.countryChange,
        this.country})
      : super(key: key);

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {

  String _selectedCountry = "Choose Country";
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

  void _onSelectedCountry(String value) {
    if (!mounted) return;
    setState(() {
      _selectedCountry = value;
      this.widget.onCountryChanged(value);
    });
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
        // DropdownButton<String>(
        //   onTap: (){
        //     setState(() {
        //       color = true;
        //     });
        //   },
        //   dropdownColor: Colors.white,
        //   isExpanded: true,
        //   items: _country.map((String dropDownStringItem) {
        //     return DropdownMenuItem<String>(
        //       value: dropDownStringItem,
        //       child: Row(
        //         children: [
        //           Text(
        //             dropDownStringItem,
        //             style: TextStyle(color: color?Colors.black:Colors.black26,fontWeight: FontWeight.bold,fontSize: 14),
        //           )
        //         ],
        //       ),
        //     );
        //   }).toList(),
        //   onChanged: (value) => _onSelectedCountry(value),
        //   value: _selectedCountry,
        // ),
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
