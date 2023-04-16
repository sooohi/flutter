import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 게시물'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          //SingleChildScrollView를 통해 사진의 크기가 클 경우 스크롤로 넘어가게 설정
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "제목을 입력하세요",
                    fillColor: Colors.white70),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('이미지 선택'),
              ),
              //이미지가 없을 경우 Placeholder을 사용하면 x표기로 나타남. && 그것의 사이즈 지정
              /*const SizedBox(
                  width: 300,
                  height: 300,
                  child: Placeholder()),
               */
              Image.network(
                'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzAxMjdfNDQg%2FMDAxNjc0ODA4MTkxNTc4.gVATRXlifbUc0AJuGa0DQJr5jdw1eGk0JEFgtVbJRDUg.bRMYmlx-SZrkUKQ4-a82clnY9o0b7_FhlLX-SY7Fws8g.PNG.safeway1104%2F2023-01-27_17%253B27%253B30.PNG&type=sc960_832',
                width: 300,
                //사진 가로 고정
              ),
            ],
          ),
        ),
      ),
    );
  }
}
