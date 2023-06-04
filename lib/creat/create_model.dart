import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/post.dart';

class CreateModel {
  //imagepicker 설정
  final _picker = ImagePicker();

  //await를 쓰기 위해서는 오래걸리는 Future 사용
  Future<File?> getImage() async {
    //await는 오래 걸리는 함수 && gallery말고 직접 찍은 사진은 camera
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    //이미지가 null이면 null 리턴하고 아니면 경로 리턴
    if (image == null) {
      return null;
    }
    return File(image.path);
  }

  //이 기능은(글 쓰기) 네트워크 경유해 오래 걸림
  //firebasefirestore에 있는 데이터를 post데이터로 변환을 함. 가지고 올때는 post.fromJson(snapshot.data()!)를 통해서 post로 변환을 하고 firestore에 쓸때는 post,Json()을 통해서 만들어줄거다.
  Future<void> uplodaPsoet(String title, File imageFile) async {
    final PostRef = FirebaseFirestore.instance
        .collection('posts')
        .withConverter<Post>(
            fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
            toFirestore: (post, _) => post.toJson());

    postsRef.add(Post(
      userId: FirebaseAuth.instance.currentUser?.uid ??'',
      title: title,
      imageUrl: 'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzAxMjdfNDQg%2FMDAxNjc0ODA4MTkxNTc4.gVATRXlifbUc0AJuGa0DQJr5jdw1eGk0JEFgtVbJRDUg.bRMYmlx-SZrkUKQ4-a82clnY9o0b7_FhlLX-SY7Fws8g.PNG.safeway1104%2F2023-01-27_17%253B27%253B30.PNG&type=sc960_832',
    ));
  }
}
