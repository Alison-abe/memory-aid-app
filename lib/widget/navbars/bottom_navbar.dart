import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:memory_aid/screens/exercise/exercise.dart';
import 'package:memory_aid/screens/notes/notes.dart';
import 'package:memory_aid/screens/profile.dart';
import 'package:memory_aid/screens/recording/record_page.dart';
import 'package:memory_aid/screens/summary/summary.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 2;
  final List<Widget> _pages = [
    const Notes(),
    const SummaryPage(),
    const RecordPage(),
    const Exercise(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    
    final theme=Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:theme.colorScheme.secondary,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedIconTheme: IconThemeData(
          color: theme.colorScheme.tertiary,
          size: 35,
        ),
        unselectedIconTheme: IconThemeData(
          color: theme.colorScheme.tertiary,
          size: 20,
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.note_alt_sharp), label: "", tooltip: "Notes"),
          BottomNavigationBarItem(
              icon: Icon(Icons.note), label: "", tooltip: "Summary"),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "", tooltip: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb), label: "", tooltip: "exercise"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "", tooltip: "Profile"),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}