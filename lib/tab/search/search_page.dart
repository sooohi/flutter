import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community/creat/creat_page.dart';
import 'package:community/detail_post/detail_post_page.dart';
import 'package:community/tab/search/search_model.dart';
import 'package:flutter/material.dart';

import '../../domain/post.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  final List<String> _urls = const [
    //임의로 사진 넣어주기
    'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzAxMjdfNDQg%2FMDAxNjc0ODA4MTkxNTc4.gVATRXlifbUc0AJuGa0DQJr5jdw1eGk0JEFgtVbJRDUg.bRMYmlx-SZrkUKQ4-a82clnY9o0b7_FhlLX-SY7Fws8g.PNG.safeway1104%2F2023-01-27_17%253B27%253B30.PNG&type=sc960_832',
    'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzAxMjdfNDQg%2FMDAxNjc0ODA4MTkxNTc4.gVATRXlifbUc0AJuGa0DQJr5jdw1eGk0JEFgtVbJRDUg.bRMYmlx-SZrkUKQ4-a82clnY9o0b7_FhlLX-SY7Fws8g.PNG.safeway1104%2F2023-01-27_17%253B27%253B30.PNG&type=sc960_832',
    'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzAxMjdfNDQg%2FMDAxNjc0ODA4MTkxNTc4.gVATRXlifbUc0AJuGa0DQJr5jdw1eGk0JEFgtVbJRDUg.bRMYmlx-SZrkUKQ4-a82clnY9o0b7_FhlLX-SY7Fws8g.PNG.safeway1104%2F2023-01-27_17%253B27%253B30.PNG&type=sc960_832',
    'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzAxMjdfNDQg%2FMDAxNjc0ODA4MTkxNTc4.gVATRXlifbUc0AJuGa0DQJr5jdw1eGk0JEFgtVbJRDUg.bRMYmlx-SZrkUKQ4-a82clnY9o0b7_FhlLX-SY7Fws8g.PNG.safeway1104%2F2023-01-27_17%253B27%253B30.PNG&type=sc960_832',
  ];

  @override
  Widget build(BuildContext context) {
    final model = SearchModel();
    return Scaffold(
      //밑에 동그라미 버튼과 그 안에 펜 모양 주기
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //글쓰기 버튼을 눌렀을 경우 creat_page로 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePage()),
          );
        },
        child: const Icon(Icons.create),
      ),
      appBar: AppBar(
        title: const Text('모든 게시물'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: StreamBuilder<QuerySnapshot<Post>>(
            stream: model.postsStrem,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('알 수 없는 에러');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              //data 안에 <QuerySnapshot<Post>>이게 들어 있음. 그것을 docs라는 걸로 접근하면 list로 접근이 된다.
              //안에 있는 것을 map으로 돌면서 데이터 뽑아서 리스트로
              List<Post> posts =
                  snapshot.data!.docs.map((e) => e.data()).toList();

              return GridView.builder(
                //count는 화면에 표시할 아이템의 개수가 명확하게 정해져 있을때 column이나 row쓰듯이 사용. builder는 성능 좋게, 동적으로 사용
                itemCount: posts.length, //gridView의 개수를 지정해야 지정한 만큼 이쁘게 나옴
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //crossAxisCount는 열 개수 && 사진 여백 주기
                  crossAxisCount: 3,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  //이미지 3개 나오게 하는 부분
                  final post = posts[index];
                  return GestureDetector(
                    //이미지 클릭 시 화면 전화을 하겠다
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPostPage(post: post)),
                      );
                    },
                    child: Hero(//애니메이션 주기
                      tag: post.id,
                      child: Image.network(
                        post.imageUrl,
                        fit: BoxFit.cover, //꽉 찬 이미지. grid에서는 사이즈가 정사각형으로 알아서 지정
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
