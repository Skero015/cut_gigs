
class Favourite {

  String eventID;
  bool isFavourite;
  String tagID;

  Favourite.fromMap(Map<String, dynamic> data){
    this.eventID = data['eventID'];
    this.isFavourite = data['isFavourite'];
    this.tagID = data['tagID'];
  }

  Map<String, dynamic> toMap() {
    return {
      'eventID': eventID,
      'isFavourite': isFavourite,
      'tagID': tagID,
    };
  }
}