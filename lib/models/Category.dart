import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';


class Category{
  String name;
  String image;

  Category.fromMap(Map<String, dynamic> data){
    this.name = data['name'];
    this.image = data['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }
}

Future<List> getCategories() async {
  Firebase.initializeApp();
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Category')
      .get();

  List<dynamic> categoryList = [];

  snapshot.docs.forEach((element) {
    Category category = Category.fromMap(element.data());
    categoryList.add(category);
  });

  return categoryList;
}