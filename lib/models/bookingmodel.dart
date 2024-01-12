import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/packagemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Booking {
  // Package? package;
  List<dynamic>? ActivityList;

  String? startingForm;
  String? traveligTo;

  String? startDate;
  String? endDate;
  String? imgUrl;
  String? decs;
  String? price;
  String? img1;
  String? img2;
  String? img3;
  String? img4;
  String? retunfligthdate;
  String? retunreachfligthdate;
  String? retunfligthtime;
  String? retunreachfligthtime;
  String? flightDate;
  String? reachDate;
  String? flightTime;
  String? reachTime;
  String? hotelName;
  String? hotelImg;
  String? hotelRate;
  String? hotelAdd;
  String? hotelPhone;
  
  String? type;
  String? name;
  String? id;
  String? email;
  String? address;
  String? phone;
  String? city;
  String? state;
  String? totalprice;
  List<dynamic>? travellerlist;

  Booking(
      { //this.package,
      required this.name,
      required this.type,
      this.id,
      required this.retunfligthdate,
      required this.retunreachfligthdate,
      required this.retunfligthtime,
      required this.retunreachfligthtime,
      required this.ActivityList,
      required this.startingForm,
      required this.traveligTo,
      required this.startDate,
      required this.endDate,
      required this.imgUrl,
      required this.decs,
      required this.price,
      required this.img1,
      required this.img2,
      required this.img3,
      required this.img4,
      required this.flightDate,
      required this.reachDate,
      required this.flightTime,
      required this.reachTime,
      required this.hotelName,
      required this.hotelImg,
      required this.hotelAdd,
      required this.hotelPhone,
      required this.hotelRate,
      required this.email,
      required this.address,
      required this.phone,
      required this.city,
      required this.state,
      required this.totalprice,
      required this.travellerlist});

  static addBookPackage(Booking booking, id) {
    CollectionReference db = FirebaseFirestore.instance.collection('booking');

    Map<String, dynamic> data = {
      "id": booking.id,
      "type": booking.type,
      'startingForm': booking.startingForm,

      'retunFligthDate': booking.retunfligthdate,
      'retunReachFligthDate': booking.retunreachfligthdate,
      'retunFligthTime': booking.retunfligthtime,
      'retunReachFligthTime': booking.retunreachfligthtime,
      "traveligTo": booking.traveligTo,
      "startDate": booking.startDate,
      "endDate": booking.endDate,
      "imgUrl": booking.imgUrl,
      "decs": booking.decs,
      "price": booking.price,
      "img1": booking.img1,
      "img2": booking.img2,
      "img3": booking.img3,
      "img4": booking.img4,
      "flightDate": booking.flightDate,
      "reachDate": booking.reachDate,
      "flightTime": booking.flightTime,
      "reachTime": booking.reachTime,
      "hotelName": booking.hotelName,
      "hotelImg": booking.hotelImg,
      "hotelAdd": booking.hotelAdd,
      "hotelPhone": booking.hotelPhone,
      "hotelRate": booking.hotelRate,
      "activityList": booking.ActivityList,
      //"package": booking.package,
      "name": booking.name,
      "email": booking.email,
      "address": booking.address,
      "phone": booking.phone,
      "city": booking.city,
      "state": booking.state,
      "totalprice": booking.totalprice,
      "travellerlist": booking.travellerlist
    };
    db
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("bookingPkg")
        .doc(id)
        .set(data);
  }

  static Future<void> deleteBookPackage(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection('booking');
    await db
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("bookingPkg")
        .doc(id)
        .delete();
  }
}
