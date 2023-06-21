import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../detail_post/detail_post_page.dart';
import '../../domain/post.dart';
import 'account_model.dart';

class AccountPage extends StatelessWidget {

  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AccountModel();
    return Scaffold(
        appBar: AppBar(
          title: const Text('내 게시물 관리'),
          actions: [
            IconButton(
              onPressed: () {
                model.logout();
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          //spaceBetween으로 했기때문에 padding으로 공백 주기
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //spaceEvenly로 할 경우 공백까지 균등
                children: [
                  Column(
                    children: [
                      Stack(
                        //그림 위 버튼을 덧붙이기 위해 스택 사용
                        children: [
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: CircleAvatar(
                              //동그라미 사진
                              backgroundImage: NetworkImage(
                                  model.getProfileImageUrl()),
                            ),
                          ),
                          Container(
                            //아래 세줄은 버튼을 아래 오른쪽에 오기 위해 사이즈를 맞춰주며 정렬한 부분
                            width: 80,
                            height: 80,
                            alignment: Alignment.bottomRight,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                const SizedBox(
                                  //파랑 버튼 주변에 흰색 원 하나 더 해줘서 입체적으로 보이게
                                  //FloatingActionButton size 조정
                                  width: 28,
                                  height: 28,
                                  child: FloatingActionButton(
                                    onPressed: null,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  //파란 버튼
                                  //FloatingActionButton size 조정
                                  width: 25,
                                  height: 25,
                                  child: FloatingActionButton(
                                    onPressed: () {}, //이 부분을 null로 바꾸면 클릭 효과는 없어짐
                                    child: const Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        model.getNickName(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      StreamBuilder <QuerySnapshot<Post>>(
                        stream: model.postsStrem,
                        builder: (context, snapshot) {
                          int count=0;
                          if(snapshot.hasData){//데이터가 있으면 null아님 보증하고 사이즈
                            count = snapshot.data!.size;
                          }
                          //게시물 수 만큼 표시
                          return Text(
                            '$count',
                            style: const TextStyle(fontSize: 18),
                          );
                        }
                      ),
                      const Text(
                        '게시물',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        '526',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '팔로워',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        '283',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '팔로잉',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
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
              ),
            ],
          ),
        ));
  }
}
