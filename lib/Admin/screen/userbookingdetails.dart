import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

// ignore: must_be_immutable
class UserBookingDetails extends StatelessWidget {
  String name;
  String id;
  String email;
  String phone;
  String add;
  String city;
  String state;
  List travelerlist;
  UserBookingDetails({
    super.key,
    required this.name,
    required this.id,
    required this.email,
    required this.phone,
    required this.add,
    required this.city,
    required this.state,
    required this.travelerlist,
  });

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Travellers Details"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrow_left_2, color: Colors.white))),
      body: name.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff0078aa),
              ),
            )
          : Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(children: [
                    Card(
                      elevation: 1,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: mq.size.width,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: mq.size.height * 0.01,
                                ),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Contact Details",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.035,
                                ),
                                Text(
                                  "NAME           :     $name",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.028,
                                ),
                                Text(
                                  "EMAIL           :     $email",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.028,
                                ),
                                Text(
                                  "PHONE          :     $phone",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.028,
                                ),
                                Text(
                                  "ADDRESS     :     $add",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.028,
                                ),
                                Text(
                                  "CITY              :     $city",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.028,
                                ),
                                Text(
                                  "STATE           :     $state",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.01,
                                ),
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Card(
                      elevation: 1,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const Text(
                              "Travellers",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: travelerlist.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: mq.size.height * 0.035,
                                    ),
                                    Text("Traveller ${index + 1} : ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16)),
                                    SizedBox(
                                      height: mq.size.height * 0.03,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        "NAME           :     " +
                                            travelerlist[index]
                                                ["travellerName"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mq.size.height * 0.028,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        "DOB              :     " +
                                            travelerlist[index]["travellerDob"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mq.size.height * 0.028,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        "GENDER       :     " +
                                            travelerlist[index]["gender"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    )
                  ]),
                ))
              ],
            ),
    );
  }
}
