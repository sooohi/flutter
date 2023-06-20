import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    //이미지 업로드
    final storageRef = FirebaseStorage.instance.ref();
    //밀리세컨 시간 기준으로 이름 무작위 생성
    final imageRef = storageRef
        .child('postImages/${DateTime.now().microsecondsSinceEpoch}.png');

    //이미지 url 얻음
    await imageRef.putFile(imageFile);
    //url 얻는 방법
    final downloadUrl = await imageRef.getDownloadURL();

    //게시물 업로드
    final postsRef = FirebaseFirestore.instance
        .collection('posts')
        .withConverter<Post>(
            fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
            toFirestore: (post, _) => post.toJson());

    //사전 문서 Id를 얻을 수 있음
    final newPostRef = postsRef.doc();
    //newPostRef.set으로 데이터 넣음
    newPostRef.set(Post(
      //사전 문서 id 얻어서 id 활용해 데이터 만들 수 있음
      id: newPostRef.id,
      userId: FirebaseAuth.instance.currentUser?.uid ?? '',
      title: title,
      imageUrl: downloadUrl,
    ));
  }
}
