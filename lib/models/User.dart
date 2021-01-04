class UserModel{
  String uid;
  String email;
  String name;
  String password;
  String mainPhone;
  String altPhone;
  String homeLocation;
  String altLocation;
  bool hasRunningOrder;
  String promo;

  UserModel({this.uid, this.email, this.name, this.mainPhone, this.homeLocation,
    this.altLocation, this.hasRunningOrder});
}