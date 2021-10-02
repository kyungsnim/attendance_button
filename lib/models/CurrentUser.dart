import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

class CurrentUser {
  String id; // 수험번호 (학번)
  String password;
  String grade; // 학년호
  String name; // 이름
  String phoneNumber; // 휴대폰번호
  bool validateByAdmin; // 검증 전/후
  String role; // 학생, 관리자
  DateTime createdAt;

  CurrentUser(
      {required this.id,
        required this.password,
        required this.grade,
        required this.name,
        required this.phoneNumber,
        required this.validateByAdmin,
        required this.role,
        required this.createdAt});

  factory CurrentUser.fromDocument(DocumentSnapshot doc) {
    var getDocs = doc.data() as Map<String, dynamic>;
    return CurrentUser(
        id: doc.id,
        password: getDocs["password"],
        grade: getDocs["grade"],
        name: getDocs["name"] != null ? getDocs["name"] : "-",
        phoneNumber:
            getDocs["phoneNumber"] != null ? getDocs["phoneNumber"] : "-",
        validateByAdmin: getDocs["validateByAdmin"],
        role: getDocs["role"],
        createdAt: getDocs["createdAt"].toDate());
  }
}
