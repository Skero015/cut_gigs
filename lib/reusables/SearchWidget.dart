import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/models/Institution.dart';
import 'package:cut_gigs/notifiers/institution_notifier.dart';
import 'package:cut_gigs/screens/SearchScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

const TextStyle dropDownLabelStyle =
TextStyle(color: Colors.white, fontSize: 22.0);
const TextStyle dropDownMenuItemStyle =
TextStyle(color: Colors.black, fontSize: 22.0);

class SearchWidget extends StatefulWidget {

  TextEditingController searchController;
  AsyncSnapshot asyncSnapshot;
  BuildContext context;

  SearchWidget(this.context, this.searchController, {this.asyncSnapshot});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  InstitutionNotifier institutionNotifier;
  String institutionDropdownValue = "";
  String titleDropdownValue = "";
  List<DropdownMenuItem<String>> institutionDropdownList = [];

  void addInstitutionList(InstitutionNotifier institutionNotifier) async{
    institutionDropdownList = [];
    await getInstitutionList(institutionNotifier).then((value) {
      institutionNotifier.institutionList.forEach((element) {
        if(!institutionDropdownList.contains(element.id))
          institutionDropdownList.add(new DropdownMenuItem(child: Text(element.name), value: element.id));
      });
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      institutionNotifier = Provider.of<InstitutionNotifier>(widget.context, listen: false);
      addInstitutionList(institutionNotifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        elevation: 0.0,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        //shape: ,
        child: GestureDetector(
          child: Container(
            alignment: Alignment.centerLeft,
            height: 65,
            width: MediaQuery.of(context).size.width - 80,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.yellow[800]),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: new Image(image: AssetImage('images/SearchEventsIcon.png'),height: 35.0,width: 35.0, fit: BoxFit.scaleDown,),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new SearchScreen(snapshot: widget.asyncSnapshot,)));
      },
    );
  }
}
