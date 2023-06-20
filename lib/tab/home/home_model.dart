import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class HomeModel {
  final _picker = ImagePicker();

  Future<void> updateProfileImage() async {
    XFile? xfile = await _picker.pickImage(source: ImageSource.gallery);
    if(xfile != null){
      //선택한 사진 업로드
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef//uid 프로필 무작위 만듬
          .child('user/${FirebaseAuth.instance.currentUser?.uid}/profile/${DateTime.now().microsecondsSinceEpoch}.png');

      await imageRef.putFile(File(xfile.path));
      final downloadUrl = await imageRef.getDownloadURL();

      //업데이트
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadUrl);
    }

  }
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
