import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_app/DataHandler/appdata.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropoffTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String placeAddress = "Kathmandu";

    pickUpTextEditingController.text = placeAddress;
    return Scaffold(
        body: Column(
      children: [
        Container(
            height: 215,
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 6,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7)),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, top: 20, right: 25, bottom: 20),
              child: Column(children: [
                const SizedBox(height: 5),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    Center(
                      child: Text(
                        "Set Drop Off",
                        style:
                            TextStyle(fontSize: 18, fontFamily: "Brand-Bold"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Image.asset("images/pickicon.png",
                        height: 16.0, width: 16.0),
                    SizedBox(width: 18.0),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(3),
                          child: TextField(
                            controller: pickUpTextEditingController,
                            decoration: InputDecoration(
                              hintText: "PickUp Location",
                              fillColor: Colors.grey[400],
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.only(left: 11, top: 8, bottom: 8),
                            ),
                          )),
                    ))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset("images/desticon.png",
                        height: 16.0, width: 16.0),
                    SizedBox(width: 18.0),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(3),
                          child: TextField(
                            controller: dropoffTextEditingController,
                            decoration: InputDecoration(
                              hintText: "Where to?",
                              fillColor: Colors.grey[400],
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.only(left: 11, top: 8, bottom: 8),
                            ),
                          )),
                    ))
                  ],
                )
              ]),
            ))
      ],
    ));
  }
}
