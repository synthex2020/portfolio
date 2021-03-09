import 'package:flutter/material.dart';
import 'package:portfolio/Education/Education.dart';
import 'package:portfolio/Projects/Projects.dart';
import 'package:portfolio/home/summaryScreen/Summary.dart';
import 'package:portfolio/releventSkills/SkillSummary.dart';

class NavigationBar extends StatefulWidget {
  int selectedIndex;
  NavigationBar({this.selectedIndex});
  @override
  _NavigationBarState createState() => _NavigationBarState(selectedIndex: selectedIndex);
}

class _NavigationBarState extends State<NavigationBar> {
  int selectedIndex;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Summary',
      style: optionStyle,
    ),
    Text(
      'Index 1: Education',
      style: optionStyle,
    ),
    Text(
      'Index 2: Skills',
      style: optionStyle,
    ),
    Text(
      'Index 3: Projects',
      style: optionStyle,
    ),
  ];
  _NavigationBarState({this.selectedIndex});
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (selectedIndex == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Summary()));
    }else if(selectedIndex == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Education()));
    }else if (selectedIndex == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> SkillSummary()));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Projects()));

    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem> [
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Summary'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Education'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Skills'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Projects'
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blueGrey,
      onTap: _onItemTapped,
    );
  }
}
