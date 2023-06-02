import 'package:flutter/material.dart';

import 'account_model.dart';

class AccountPage extends StatelessWidget {

  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AccountModel();
    return Scaffold(
        appBar: AppBar(
          title: const Text('플러터 연습'),
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
          child: Row(
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
                children: const [
                  Text(
                    '39',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
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
        ));
  }
}
