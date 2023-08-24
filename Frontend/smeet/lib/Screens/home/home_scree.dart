import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:smeet/Screens/bottom_navbar.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CustomDialogBox extends StatefulWidget {
  final Map<String, dynamic> meeting;

  CustomDialogBox({required this.meeting});

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(widget.meeting["name"]),
      content: SizedBox(
        width: double.maxFinite,
        child: Card(
          elevation: 0,
          margin: EdgeInsets.only(left: 16, top: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Row(children: [
                Icon(LineIcons.clock),
                SizedBox(width: 10),
                Text(
                    "${widget.meeting['fromTime']} - ${widget.meeting['toTime']}")
              ]),
            ),
            if (widget.meeting["mode"] == "In-Person")
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(children: [
                  Icon(LineIcons.mapPin),
                  SizedBox(width: 10),
                  Text(widget.meeting["location"])
                ]),
              )
            else
              Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () => _launchURL(widget.meeting["location"]),
                  child: const Row(children: [
                    Icon(LineIcons.link),
                    SizedBox(width: 10),
                    Text(
                      'Meet Link',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ]),
                ),
              ),
            Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(widget.meeting["description"])),
            const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  "Participants",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            // List of participants
            SizedBox(
              height: 50,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: widget.meeting["participants"].length,
                itemBuilder: (_, i) {
                  return Text(widget.meeting["participants"][i]);
                },
              ),
            ),
          ]),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {

  @override
  HomeScreenState createState() => HomeScreenState();
}

dynamic dialoger() {
  return AlertDialog(
    title: Text("Listview"),
    content: SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.builder(
            itemCount: 50,
            itemBuilder: (_, i) {
              return Text("Item $i");
            },
          ),
        ],
      ),
    ),
  );
}

_launchURL(String urlString) async {
  if (true) {
    await launchUrl(Uri.parse(urlString), mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $urlString';
  }
}

class HomeScreenState extends State<HomeScreen> {
  List<dynamic> dates = [];
  String? user;

  String getDayName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return 'Unknown';
    }
  }

  final List<Map<String, dynamic>> outerList = [
    {
      'title': 'Group 1',
      'items': ['Item 1', 'Item 2', 'Item 3']
    },
    {
      'title': 'Group 2',
      'items': ['Item A', 'Item B']
    },
// Add more groups here
  ];

  Future<String> getStoredUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? "";
  }

  Future<List<dynamic>> getMeetings(BuildContext context) async {
    String? searchTerm = await getStoredUserName();
    //String searchTerm = "Sachin Krishan";
    //print(searchTerm);
    String encodedSearchTerm = Uri.encodeQueryComponent(searchTerm);

    final String apiUrl = "http://172.20.2.246:8080/getMeetings?q=$encodedSearchTerm"; // Replace with your API endpoint

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        //print(responseBody);
        return responseBody;
      }
    } catch (e) {
      // Network or other errors
      print('Error occurred: $e');
      return ["inside error"];
    }

    return ["empty"];
  }

  Future<void> initializeMeetings() async {
    List<dynamic> fetchedDates = await getMeetings(context);
    setState(() {
      dates = fetchedDates;
    });
  }

  // Future<void> initUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? curUser = prefs.getString('userName');
  //   setState(() {
  //     user = curUser;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    //initUser();
    initializeMeetings();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Scheduled Meetings'),
          elevation: 4,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: ListView.builder(
          itemCount: dates.length,
          itemBuilder: (context, index) {
            final group = dates[index];
            final groupTitle = group['date'];
            final groupItems = List<dynamic>.from(group['meeting']);
            DateTime dateTime = DateTime.parse(groupTitle);

            return Card(
              elevation: 0,
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(children: [
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            DateFormat('MMM dd').format(dateTime),
                            style: const TextStyle(
                                fontSize: 17, // Font size
                                fontWeight: FontWeight.bold,
                                color: Colors.black87 // Font weight
                                ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(getDayName(dateTime.weekday),
                            style: const TextStyle(
                              fontSize: 17, // Font size
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ))
                      ])),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: groupItems.length,
                    itemBuilder: (context, innerIndex) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 45),
                        child: GestureDetector(
                          onTap: () {
                            print("tapped");
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                      meeting: groupItems[innerIndex]);
                                });
                          },
                          child: Card(
                            elevation: 4,
                            margin: EdgeInsets.only(left: 16, top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text(groupItems[innerIndex]["name"],
                                      style: TextStyle(
                                        fontSize: 15, // Font size
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Row(children: [
                                    Icon(LineIcons.clock),
                                    SizedBox(width: 10),
                                    Text(
                                        "${groupItems[innerIndex]['fromTime']} - ${groupItems[innerIndex]['toTime']}")
                                  ]),
                                ),
                                if (groupItems[innerIndex]["mode"] ==
                                    "In-Person")
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(children: [
                                      Icon(LineIcons.mapPin),
                                      SizedBox(width: 10),
                                      Text(groupItems[innerIndex]["location"])
                                    ]),
                                  )
                                else
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: GestureDetector(
                                      onTap: () => _launchURL(
                                          groupItems[innerIndex]["location"]),
                                      child: const Row(children: [
                                        Icon(LineIcons.link),
                                        SizedBox(width: 10),
                                        Text(
                                          'Meet Link',
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: NavBar(selected: 0),
      ),
    );
  }
}
