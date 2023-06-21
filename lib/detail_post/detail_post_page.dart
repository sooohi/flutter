import 'package:community/detail_post/detail_post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../domain/post.dart';

class DetailPostPage extends StatelessWidget {
  final Post post;

  const DetailPostPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = DetailPostModel();
    return Scaffold(
        appBar: AppBar(
          title: const Text('모든 게시물'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //글씨 왼쪽 정렬
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(model.getProfileImageUrl()),
                  ),
                  const SizedBox(width: 8),//가로 간격 주기
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //이메일 주소 text
                      Text(
                        model.getEmail(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      //이름 text
                      Text(model.getNickName()),
                    ],
                  ),
                ],
              ),
            ),
            Hero(tag: post.id,
            child: Image.network(post.imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(post.title),
            ),
          ],
        ));
  }
}
