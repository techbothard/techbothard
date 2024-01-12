import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Admin/screen/userbookingdetails.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ViewBooking extends StatefulWidget {
  const ViewBooking({super.key});

  @override
  State<ViewBooking> createState() => _ViewBookingState();
}

class _ViewBookingState extends State<ViewBooking> {
  List allBookingdata = [];
  List foundlist = [];
  getData() async {
    await FirebaseFirestore.instance
        .collectionGroup('bookingPkg')
        .get()
        .then((QuerySnapshot? snapshot) {
      for (var element in snapshot!.docs) {
        if (element.exists) {
          Map<String, dynamic> data = {
            "id": element["id"],
            "type": element["type"],
            'startingForm': element["startingForm"],
            'retunFligthDate': element["retunFligthDate"],
            'retunReachFligthDate': element["retunReachFligthDate"],
            'retunFligthTime': element["retunFligthTime"],
            'retunReachFligthTime': element["retunReachFligthTime"],
            "traveligTo": element["traveligTo"],
            "startDate": element["startDate"],
            "endDate": element["endDate"],
            "imgUrl": element["imgUrl"],
            "decs": element["decs"],
            "price": element["price"],
            "img1": element["img1"],
            "img2": element["img2"],
            "img3": element["img3"],
            "img4": element["img4"],
            "flightDate": element["flightDate"],
            "reachDate": element["reachDate"],
            "flightTime": element["flightTime"],
            "reachTime": element["reachTime"],
            "hotelName": element["hotelName"],
            "hotelImg": element["hotelImg"],
            "hotelAdd": element["hotelAdd"],
            "hotelPhone": element["hotelPhone"],
            "hotelRate": element["hotelRate"],
            "activityList": element["activityList"],
            //"package": element ["package,
            "name": element["name"],
            "email": element["email"],
            "address": element["address"],
            "phone": element["phone"],
            "city": element["city"],
            "state": element["state"],
            "totalprice": element["totalprice"],
            "travellerlist": element["travellerlist"]
          };
          allBookingdata.add(data);
          setState(() {});
        }
      }
    });
  }

  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allBookingdata;
    } else {
      results = allBookingdata
          .where((element) =>
              element["startingForm"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element["traveligTo"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      foundlist = results;
    });
  }

  @override
  void initState() {
    getData();
    foundlist = allBookingdata;
    setState(() {});

    super.initState();
  }

  var nameC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("BOOKING"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrow_left_2)),
        ),
        body: allBookingdata.isEmpty
            ? Center(
                child: CircularProgressIndicator(color: Color(0xff0078aa)),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextField(
                      controller: nameC,
                      onChanged: (value) => _runFilter(value),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15),
                        hintText: "Search",
                        suffixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        // prefix: Icon(Icons.search),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: foundlist.isEmpty
                        ? Center(
                            child: Text(
                              "DATA NOT FOUND!",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 22),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserBookingDetails(
                                                    name: foundlist[index]
                                                        ["name"],
                                                    id: foundlist[index]["id"],
                                                    email: foundlist[index]
                                                        ["email"],
                                                    phone: foundlist[index]
                                                        ["phone"],
                                                    add: foundlist[index]
                                                        ["address"],
                                                    city: foundlist[index]
                                                        ["city"],
                                                    state: foundlist[index]
                                                        ["state"],
                                                    travelerlist:
                                                        foundlist[index]
                                                            ["travellerlist"]),
                                          ));
                                    },
                                    child: Card(
                                        elevation: 1,
                                        color: Colors.white,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Titletext(
                                                title: foundlist[index]
                                                        ["startingForm"] +
                                                    " To " +
                                                    foundlist[index]
                                                        ["traveligTo"],
                                                size: 18,
                                              ),
                                              SizedBox(
                                                height: mq.size.height * 0.014,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 72,
                                                    width: 92,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child:
                                                            FancyShimmerImage(
                                                          imageUrl:
                                                              foundlist[index]
                                                                  ["imgUrl"],
                                                          boxFit: BoxFit.cover,
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12, right: 5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: mq.size.width *
                                                              0.48,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Name : ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      13.5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  foundlist[
                                                                          index]
                                                                      ["name"],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.65)),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              mq.size.height *
                                                                  0.013,
                                                        ),
                                                        SizedBox(
                                                          width: mq.size.width *
                                                              0.48,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "Date   : ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      13.5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                foundlist[index]
                                                                    [
                                                                    "startDate"],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.5,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.65)),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              mq.size.height *
                                                                  0.013,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Price  : ",
                                                              style: TextStyle(
                                                                fontSize: 13.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Text(
                                                              foundlist[index][
                                                                  "totalprice"],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.5,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.65)),
                                                            ),
                                                            SizedBox(
                                                              width: mq.size
                                                                      .height *
                                                                  0.026,
                                                            ),
                                                            Text(
                                                              "Travellers  : ",
                                                              style: TextStyle(
                                                                fontSize: 13.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Text(
                                                              foundlist[index][
                                                                      "travellerlist"]
                                                                  .length
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.5,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.65)),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              // SizedBox(
                                              // height: mq.size.height * 0.01,
                                              //),
                                              //  Divider(color: themeState.getDarkTheme ? Colors.white38 : Colors.black38),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              );
                            },
                            itemCount: foundlist.length,
                          ),
                  ),
                ],
              ));
  }
}
