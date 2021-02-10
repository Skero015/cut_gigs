import 'dart:collection';
import 'package:cut_gigs/models/Institution.dart';
import 'package:flutter/cupertino.dart';

class InstitutionNotifier with ChangeNotifier {
  List<Institution> _institutionList = [];
  Institution _currentInstitution;
  bool isListenersNotified = false;

  UnmodifiableListView<Institution> get institutionList => UnmodifiableListView(_institutionList);

  //gets the event that has been selected, this data can be used anywhere in the app
  Institution get currentInstitution => _currentInstitution;

  set institutionList(List<Institution> institutionList) {
    _institutionList = institutionList;

    notifyListeners();
  }

  set currentInstitution(Institution institution) {
    _currentInstitution = institution;

    notifyListeners();
  }

}