
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_gigs/notifiers/institution_notifier.dart';

class Institution {

  String id;
  String name;
  String email;
  String location;
  String image;

  Institution({this.id, this.name});

  Institution.fromMap(Map<String, dynamic> data){
    this.name = data['name'];
    this.id = data['id'];
    this.email = data['email'];
    this.location = data['location'];
    this.image = data['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'email': email,
      'location': location,
      'image': image,
    };
  }
}

Future<List> getInstitutionList(InstitutionNotifier institutionNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Institutions')
      .get();

  List<dynamic> institutionList = [];

  snapshot.docs.forEach((element) {
    Institution institution = Institution.fromMap(element.data());
    institutionList.add(institution);
    print(institution.name);
  });

  institutionNotifier.institutionList = institutionList;
  return institutionList;
}