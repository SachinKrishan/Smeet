import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:smeet/Screens/home/home_scree.dart';

//import '/Screens/login/login_screen.dart';

class Meeting {
  late String name;
  late String description;
  late String mode;
  late String location;
  late List<String> participants = [];
  late String date = "";
  late String fromTime = "";
  late String toTime = "";

  Meeting();
}

class CreateScreenForm extends StatefulWidget {
  CreateScreenForm({Key? key}) : super(key: key);

  @override
  CreateScreenFormState createState() => CreateScreenFormState();
}

class CreateScreenFormState extends State<CreateScreenForm> {
  TextEditingController dateController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final fromTimeController = TextEditingController();
  final toTimeController = TextEditingController();

  List<dynamic> searchResults = [];
  List<dynamic> availability = [];
  List<String> selectedEmployees = [];
  List<String> employees = [];
  Meeting meeting = Meeting();

  Future save() async {
    print("here");
    final url = Uri.parse("http://172.20.2.246:8080/createMeeting");

    final meetingData = {
      "name": meeting.name,
      "description": meeting.description,
      "mode": meeting.mode,
      "location": meeting.location,
      "participants": meeting.participants,
      "date": meeting.date,
      "fromTime": meeting.fromTime,
      "toTime": meeting.toTime
    };

    final res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(meetingData), // Convert your data to JSON
    );

    print(res.body);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  Future<List<dynamic>> getAvailability() async {
    print("getAvailability");
    print(meeting.date);
    final url = Uri.parse("http://172.20.2.246:8080/getAvailability");

    final meetingData = {
      "participants": meeting.participants,
      "date": meeting.date,
    };

    final res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(meetingData), // Convert your data to JSON
    );

    //print(res.body);
    final responseBody = json.decode(res.body);
    availability = await responseBody["availability"];
    return responseBody;
  }

  Future<void> _searchEmployees(String query) async {
    print("api called");
    final response =
        await http.get(Uri.parse('http://172.20.2.246:8080/search?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = json.decode(response.body);
      });
    }

    for (var employee in searchResults) {
      employees.add(employee["name"]);
    }

    print(employees);
  }

  bool isTimeWithinBlocks() {
    final now = DateTime.now();

    for (var block in availability) {

      final startDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(block[0].split(":")[0]),
          int.parse(block[0].split(":")[1])
      );

      final endDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(block[1].split(":")[0]),
        int.parse(block[1].split(":")[1]),
      );

      final selectedStartDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(meeting.fromTime.split(" ")[0].split(":")[0]),
    int.parse(meeting.fromTime.split(" ")[0].split(":")[1])
      );

      final selectedEndDateTime = DateTime(
        now.year,
        now.month,
        now.day,
    int.parse(meeting.toTime.split(" ")[0].split(":")[0]),
    int.parse(meeting.toTime.split(" ")[0].split(":")[1])
      );

      if (selectedStartDateTime.isAfter(startDateTime) &&
          selectedEndDateTime.isBefore(endDateTime)) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    dateController.text = "";
    _searchEmployees("");
    meeting.mode = 'In-Person';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Form(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                onChanged: (value) {
                  meeting.name = value;
                },
                decoration: const InputDecoration(
                    label: Text("Meeting Name"),
                    prefixIcon: Icon(Icons.people_alt_rounded)),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 150,
                child: TextFormField(
                  onChanged: (value) {
                    meeting.description = value;
                  },
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.multiline,
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    label: Text("Meeting description"),
                    //prefixIcon: Icon(Icons.person_outline_rounded)),
                  ),
                ),
              ),
              RadioListTile(
                title: const Text("In-Person"),
                value: "In-person",
                groupValue: meeting.mode,
                onChanged: (value) {
                  setState(() {
                    meeting.mode = value != null ? value : "In-person";
                  });
                },
              ),
              RadioListTile(
                title: const Text("Remote"),
                value: "Remote",
                groupValue: meeting.mode,
                onChanged: (value) {
                  setState(() {
                    meeting.mode = value != null ? value : "In-person";
                  });
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: TextEditingController(),
                onChanged: (value) {
                  meeting.location = value;
                },
                decoration: InputDecoration(
                    labelText:
                        meeting.mode == "In-person" ? "Location" : "Meet Link",
                    prefixIcon: Icon(Icons.pin_drop)),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: DropdownSearch<String>.multiSelection(
                  items: employees,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        labelText: "Enter Participants",
                        prefixIcon: Icon(Icons.person)),
                  ),
                  popupProps: PopupPropsMultiSelection.menu(
                      showSearchBox: true,
                      onItemAdded: (l, s) {
                        meeting.participants.add(s);
                      },
                      onItemRemoved: (l, s) {
                        meeting.participants.remove(s);
                      }),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                onChanged: (value) {
                  setState(() {
                    meeting.date = value;
                  });
                },
                controller: dateController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), labelText: "Enter Date"),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat("yyyy-MM-dd").format(pickedDate);

                    setState(() {
                      dateController.text = formattedDate.toString();
                      //print(dateController.text);
                      meeting.date = formattedDate;
                      getAvailability();
                      print(availability);
                    });
                  } else {
                    print("Not selected");
                  }
                },
              ),
              Wrap(
                children: availability.map((item) => Chip(label: Text("${item[0]} - ${item[1]}"))).toList(),
              ),
              const SizedBox(height: 30),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    print(value);
                    meeting.fromTime = value;
                  });
                },
                controller: fromTimeController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.timer), labelText: "Start Time"),
                readOnly: true,
                onTap: () async {
                  var fromTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());

                  if (fromTime != null) {
                    setState(() {
                      fromTimeController.text =
                          "${fromTime.hour}:${fromTime.minute}";
                      meeting.fromTime = "${fromTime.hour}:${fromTime.minute}";
                    });
                  }
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    print(value);
                    meeting.toTime = value;
                  });
                },
                controller: toTimeController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.timer), labelText: "End Time"),
                readOnly: true,
                onTap: () async {
                  var toTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());

                  if (toTime != null) {
                    setState(() {
                      toTimeController.text = "${toTime.hour}:${toTime.minute}";
                      meeting.toTime = "${toTime.hour}:${toTime.minute}";
                    });
                  }
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print("before here");
                    if(isTimeWithinBlocks()){
                      save();
                    }
                    else{
                      print("not valid times");
                    }

                  },
                  child: Text("Create Meet".toUpperCase()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
