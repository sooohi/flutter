import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/post.dart';

class SearchModel {
  //collection('posts')에 있는 데이터들이 postsStrem으로 들어옴. 그걸 QuerySnapshot라는 객체로 정보를 가지고 있음.
  //stream은 데이터가 들어오면 자동으로 갱신
  final Stream<QuerySnapshot<Post>> postsStrem = FirebaseFirestore.instance
      .collection('posts')
      .withConverter<Post>(
        fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
        toFirestore: (post, _) => post.toJson(),
      )
      .snapshots();
}
