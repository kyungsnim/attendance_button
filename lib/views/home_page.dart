import 'package:attendance_button/models/current_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'attendance_page.dart';
import 'my_info_page.dart';

// variable for firestore collection 'users'
final userReference =
    FirebaseFirestore.instance.collection('users'); // 사용자 정보 저장을 위한 ref
final courseReference = FirebaseFirestore.instance.collection('courses'); // 과제 정보 저장을 위한 ref

final FirebaseFirestore firestoreReference = FirebaseFirestore.instance;

final DateTime timestamp = DateTime.now();
CurrentUser currentUser = CurrentUser(
  id: "",
  password: "",
  validateByAdmin: false,
  createdAt: DateTime.now(), name: '', phoneNumber: ''
);
var fontSize;

class HomePage extends StatefulWidget {
  final int getPageIndex;

  const HomePage({Key? key, required this.getPageIndex}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 페이지 컨트롤
  late PageController pageController;
  late int getPageIndex;
  var validateToken;
  late DocumentSnapshot documentSnapshot;

  @override
  void initState() {
    super.initState();
    setState(() {
      getPageIndex = widget.getPageIndex;
    });
    pageController = PageController(
      // 다른 페이지에서 넘어올 때도 controller를 통해 어떤 페이지 보여줄 것인지 셋팅
      initialPage: getPageIndex
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  whenPageChanges(int pageIndex) {
    setState(() {
      this.getPageIndex = pageIndex;
    });
  }

  onTapChangePage(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
  }

  @override
  Widget build(BuildContext context) {
    fontSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: SafeArea(
        child: Scaffold(
          body: PageView(
            children: <Widget>[
              AttendancePage(),
              MyInfoPage(), // 1번 pageIndex
            ],
            controller: pageController, // controller를 지정해주면 각 페이지별 인덱스로 컨트롤 가능
            onPageChanged:
            whenPageChanges, // page가 바뀔때마다 whenPageChanges 함수가 호출되고 현재 pageIndex 업데이트해줌
            // physics: NeverScrollableScrollPhysics(),
          ),
          // resizeToAvoidBottomPadding: true,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: this.getPageIndex,
            onTap: onTapChangePage,
            selectedItemColor: Colors.blueAccent,
            selectedIconTheme: IconThemeData(color: Colors.blueAccent, size: 35),
            selectedLabelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: Colors.blueAccent),
            unselectedItemColor: Colors.grey,
            unselectedFontSize: 12,
            showUnselectedLabels: true,
            iconSize: 25,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.lock_clock,), label: '출퇴근 입력', ),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.free_breakfast), label: '무료\n수업'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_pin), label: '내정보'),
            ],
          ),
        ),
      ),
    );
  }

  _onBackPressed(context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("종료하시겠습니까?",
            style: TextStyle(fontFamily: 'Binggrae', fontSize: 18)),
        actions: <Widget>[
          TextButton(
            child: Text(
              "확인",
              style: TextStyle(
                  fontFamily: 'Binggrae',
                  fontSize: 18,
                  color: Colors.redAccent),
            ),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
          TextButton(
            child: Text(
              "취소",
              style: TextStyle(
                  fontFamily: 'Binggrae', fontSize: 18, color: Colors.grey),
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    );
  }
}
