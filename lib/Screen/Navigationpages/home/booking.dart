import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/consts/upipayment.dart';
import 'package:demo/models/bookingmodel.dart';
import 'package:demo/models/packagemodel.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BookingDone extends StatefulWidget {
  String? id;
  Package? package;
  BookingDone({super.key, this.id, this.package});

  @override
  State<BookingDone> createState() => _BookingDoneState();
}

bool loading = false;
final _formKey = GlobalKey<FormState>();

class _BookingDoneState extends State<BookingDone> {
  var name = TextEditingController();

  var email = TextEditingController();

  var phone = TextEditingController();
  var address = TextEditingController();
  var city = TextEditingController();
  var state = TextEditingController();
  var tname = TextEditingController();
  var dob = TextEditingController();
  String gender = list.first;
  List<Map<String, dynamic>> travellerList = [];

  static const List<String> list = <String>[
    '---Select---',
    'Male',
    'Female',
  ];
  int totleprise = 0;
  var okprise;
  @override
  void initState() {
    okprise = widget.package!.price;
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      name.text = snapshot['name'];
      email.text = snapshot['email'];

      phone.text = snapshot['phone'];
      address.text = snapshot['address'];
      city.text = snapshot['city'];
      state.text = snapshot['State'];
      totleprise = int.parse(widget.package!.price!);

      setState(() {});
    });
    super.initState();
  }

  // ignore: prefer_typing_uninitialized_variables
  bool validateMobile(String value) {
    String pattern = r'(?:\+91|0)?[9678]\d{9}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  int? traveleller;
  Map<String, dynamic>? paymentIntenData;
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Book Trip"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconlyLight.arrow_left_2, color: Colors.white))),
      body: name.text.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff0078aa),
              ),
            )
          : Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            color: themeState.getDarkTheme
                                ? const Color(0xff212121)
                                : const Color(0xffffffff),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Column(
                                children: [
                                  const Titletext(
                                      title: "Fill In Your Details"),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* required";
                                      }
                                      return null;
                                    },
                                    controller: name,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        label: const Text("Name"),
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black))),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* required";
                                      }
                                      return null;
                                    },
                                    controller: email,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        label: const Text("Email"),
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black))),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* required";
                                      } else {
                                        if (!validateMobile(value)) {
                                          return 'Invalid mobile number';
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    controller: phone,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        label: const Text("Mobile phone"),
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black))),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* required";
                                      }
                                      return null;
                                    },
                                    controller: address,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        label: const Text("Address"),
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black))),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* required";
                                      }
                                      return null;
                                    },
                                    controller: city,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        label: const Text("city"),
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black))),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* required";
                                      }
                                      return null;
                                    },
                                    controller: state,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        label: const Text("State"),
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                              color: themeState.getDarkTheme
                                  ? const Color(0xff212121)
                                  : const Color(0xffffffff),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 85,
                                        ),
                                        Titletext(title: "Traveller Details"),
                                        Spacer(),
                                        TextButton(
                                            onPressed: () {
                                              addTravellers();
                                              setState(() {
                                                traveleller =
                                                    travellerList.length;
                                                totleprise =
                                                    totleprise * traveleller!;
                                                okprise =
                                                    totleprise * traveleller!;
                                              });
                                            },
                                            child: Text("+ Traveller"))
                                      ],
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (travellerList.isEmpty) {
                                          if (value!.isEmpty) {
                                            return "* required";
                                          }
                                          return null;
                                        }
                                        return null;
                                      },
                                      controller: tname,
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                          label: const Text("Name"),
                                          labelStyle: TextStyle(
                                              color: themeState.getDarkTheme
                                                  ? Colors.white54
                                                  : Colors.black54,
                                              fontWeight: FontWeight.w500),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1.5,
                                                      color:
                                                          Color(0xff0078aa))),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white
                                                      : Colors.black))),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (travellerList.isEmpty) {
                                          if (value!.isEmpty) {
                                            return "* required";
                                          }
                                          return null;
                                        }
                                        return null;
                                      },
                                      readOnly: true,
                                      controller: dob,
                                      onTap: () async {
                                        var dateTime = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime(2018, 1, 1),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2019));

                                        dob.text =
                                            "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
                                      },
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        label: const Text("Date of birth"),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black)),
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    DropdownButtonFormField(
                                      validator: (value) {
                                        if (travellerList.isEmpty) {
                                          if (value!.isEmpty &&
                                              value == list.first) {
                                            return "* required";
                                          }
                                          return null;
                                        }
                                        return null;
                                      },
                                      items: list
                                          .map((e) => DropdownMenuItem<String>(
                                              value: e, child: Text(e)))
                                          .toList(),
                                      value: gender,
                                      hint: const Text("Gender"),
                                      decoration: InputDecoration(
                                          label: const Text("Gender"),
                                          labelStyle: TextStyle(
                                              color: themeState.getDarkTheme
                                                  ? Colors.white54
                                                  : Colors.black54,
                                              fontWeight: FontWeight.w500),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1.5,
                                                      color:
                                                          Color(0xff0078aa))),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white
                                                      : Colors.black))),
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value.toString();
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      "Note : Only add the details of the person above Five years.",
                                      style: TextStyle(
                                          color: themeState.getDarkTheme
                                              ? Colors.white.withOpacity(0.7)
                                              : Colors.black.withOpacity(0.7)),
                                    )
                                  ]))),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: themeState.getDarkTheme
                            ? const Color(0xff121212)
                            : const Color(0xFFffffff),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(5, 5),
                              color: themeState.getDarkTheme
                                  ? Colors.white12
                                  : Colors.black12)
                        ]),
                    height: mq.size.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Titletext(title: "₹ $totleprise "),
                              SizedBox(
                                height: mq.size.height * 0.01,
                              ),
                              Text(
                                  travellerList.isEmpty || traveleller == 1
                                      ? "Per person"
                                      : "$traveleller Traveller",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: themeState.getDarkTheme
                                          ? Colors.white54
                                          : Colors.black54,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                              height: mq.size.height * 0.067,
                              width: 140,
                              child: commenButton(
                                  loading: loading,
                                  title: "PAY NOW",
                                  callback: () {
                                    // await makePayment();
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        totleprise =
                                            int.parse(widget.package!.price!);

                                        saveBooking().whenComplete(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UoiIndia(),
                                              ));
                                        });
                                      });
                                      travellerList.clear();
                                    }
                                  }))
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> saveBooking() async {
    addTravellers();
    await Booking.addBookPackage(
        Booking(
          type: "booking",
          // package: widget.package!,
          id: widget.id,
          name: name.text,
          email: email.text,
          address: address.text,
          phone: phone.text,
          city: city.text,
          state: state.text,
          totalprice: okprise.toString(),
          travellerlist: travellerList,
          retunfligthdate: widget.package!.retunfligthdate,
          retunreachfligthdate: widget.package!.retunreachfligthdate,
          retunfligthtime: widget.package!.retunfligthtime,
          retunreachfligthtime: widget.package!.retunreachfligthtime,
          ActivityList: widget.package!.ActivityList,
          startingForm: widget.package!.startingForm,
          traveligTo: widget.package!.traveligTo,
          startDate: widget.package!.startDate,
          endDate: widget.package!.endDate,
          imgUrl: widget.package!.imgUrl,
          decs: widget.package!.decs,
          price: widget.package!.price,
          img2: widget.package!.img2,
          img1: widget.package!.img1,
          reachDate: widget.package!.reachDate,
          hotelName: widget.package!.hotelName,
          hotelRate: widget.package!.hotelRate,
          img3: widget.package!.img3,
          img4: widget.package!.img4,
          flightDate: widget.package!.flightDate,
          flightTime: widget.package!.flightTime,
          hotelImg: widget.package!.hotelImg,
          hotelAdd: widget.package!.hotelAdd,
          reachTime: widget.package!.reachTime,
          hotelPhone: widget.package!.hotelPhone,
        ),
        widget.id);
  }

  addTravellers() {
    if (tname.text.isNotEmpty &&
        gender.isNotEmpty &&
        gender != list.first &&
        dob.text.isNotEmpty) {
      travellerList.add({
        "travellerName": tname.text,
        "gender": gender,
        "travellerDob": dob.text
      });

      tname.clear();
      gender = list.first;
      dob.clear();
      //ScaffoldMessenger.of(context)
      //  .showSnackBar(const SnackBar(content: Text("ADDED SUCCESSFULLY")));
    } /*else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ENTER THE TRAVELLER DETAILS")));
    }*/
  }
}
