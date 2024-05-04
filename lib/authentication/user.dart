import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({
    this.name,
    this.uid,
    this.image,
    this.email,
    this.yuotube,
    this.facebook,
    this.twitter,
    this.instagram,
  });
  String? name;
  String? uid;
  String? image;
  String? email;
  String? yuotube;
  String? facebook;
  String? twitter;
  String? instagram;

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "image": image,
        "email": email,
        "yutube": yuotube,
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
      };

  static User fromSnap(DocumentSnapshot snapshot) {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return User(
      name: dataSnapshot["name"],
      uid: dataSnapshot["uid"],
      image: dataSnapshot["image"],
      email: dataSnapshot["email"],
      yuotube: dataSnapshot["yuotube"],
      facebook: dataSnapshot["facebook"],
      twitter: dataSnapshot["twitter"],
      instagram: dataSnapshot["instagram"],
    );
  }
}
