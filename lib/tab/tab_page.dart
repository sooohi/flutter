import 'package:community/tab/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'account/account_page.dart';
import 'home/home_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _currentIndex=0;

  //순서대로 정리
  final _pages=const [
    HomePage(),
    SearchPage(),
    AccountPage(),
    ProfileScreen(
      providerConfigs: [//이메일 인증
        EmailProviderConfiguration(),
      ],
      avatarSize: 24,//사진 크기
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,//어떤 곳에 있는지 표시
        onTap: (index){
          //print(index);//잘나오는지 확인
          setState(() {
            _currentIndex=index;
          });
        },
        //각각 내용 보이게 함
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
