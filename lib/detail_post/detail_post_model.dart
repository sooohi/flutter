//로그인 정보 제공

import 'package:firebase_auth/firebase_auth.dart';

class DetailPostModel{
  String getEmail() {
    //firebase인증 정보로 로그인한 사용자 알 수 있음
    return FirebaseAuth.instance.currentUser?.email ?? '메일 없음';
  }

  String getNickName() {
    return FirebaseAuth.instance.currentUser?.displayName ?? '이름 없음';
  }

  String getProfileImageUrl() {
    //내거 있으면 내꺼 주고, 없으면 인터넷 사진 주자
    return FirebaseAuth.instance.currentUser?.photoURL ??
        'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzAxMjdfNDQg%2FMDAxNjc0ODA4MTkxNTc4.gVATRXlifbUc0AJuGa0DQJr5jdw1eGk0JEFgtVbJRDUg.bRMYmlx-SZrkUKQ4-a82clnY9o0b7_FhlLX-SY7Fws8g.PNG.safeway1104%2F2023-01-27_17%253B27%253B30.PNG&type=sc960_832';
  }
}