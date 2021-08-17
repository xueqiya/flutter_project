import 'package:flutter/material.dart';
import 'package:flutter_project/page/login.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<Widget> pageWidgetList = [LoginPage(), LoginPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: pageWidgetList[_currentIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
        onPressed: () {
          print("点击了 FloatingActionButton");
        },
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "首页"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "我的"),
        ],
        onTap: (flag) {
          _currentIndex = flag;
          setState(() {});
        },
        currentIndex: _currentIndex,
      ),
    );
  }
}