import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'home/home_scree.dart';
import 'createMeeting/create_screen.dart';
import 'Profile/profile_screen.dart';


class NavBar extends StatefulWidget {
  final int selected;

  NavBar({Key? key, required this.selected}) : super(key: key);

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'Meetings',
              ),
              GButton(
                icon: LineIcons.plusSquare,
                text: 'Create',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              _selectedIndex = index;
              switch (_selectedIndex) {
                case 0:
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  break;
                case 1:
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const CreateMeetingScreen()));
                  break;
                case 2:
                // do something else
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}
