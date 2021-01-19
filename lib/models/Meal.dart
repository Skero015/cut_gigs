import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class Meal{
  String name;
  String image;
  String ingredients;


  Meal.fromMap(Map<String, dynamic> data){
    this.name = data['name'];
    this.image = data['image'];
    this.ingredients = data['ingredients'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'ingredients': ingredients,
    };
  }
}

Future<List> getMealPlan(String eventID) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Events')
      .doc(eventID)
      .collection('Meal Plan')
      .get();

  List<dynamic> mealList = [];

  snapshot.docs.forEach((element) {
    Meal mealPlan = Meal.fromMap(element.data());
    mealList.add(mealPlan);
  });

  return mealList;
}