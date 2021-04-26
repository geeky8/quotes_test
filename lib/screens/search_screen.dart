import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quotes/style/theme.dart' as Style;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          title: Text('Quotes',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
          backgroundColor: Style.Colors.secondColor,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          TextFormField(
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            controller: _searchController,
            onChanged: (changed){},
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.grey[100],
              suffixIcon: _searchController.text.length > 0? IconButton(icon: Icon(EvaIcons.backspaceOutline), onPressed: (){},) :
              Icon(EvaIcons.searchOutline,color: Colors.grey[500],size: 16,),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[100].withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[100].withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: EdgeInsets.only(left: 15,right: 10),
              labelText: "Search...",
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            autocorrect: false,
            autovalidate: true,
          ),
        ],
      ),
    );
  }
}
