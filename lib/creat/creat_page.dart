// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:community/creat/create_model.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  //StatelessWidget은 변수 다룰 수 없음. 상수만 가질 수 있음
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final model = CreateModel(); //이것을 통해 동작하도록 작성할거임

  final _titleTextController = TextEditingController();

  File? _image; //File 뒤 ?를 붙여서 null을 허용 && file 리턴하면 여기로 받음

  bool isLoading = false;
  @override
  void dispose() {
    _titleTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 게시물'),
        actions: [
          IconButton(
            onPressed: () async {
              if(_image!=null&& _titleTextController.text.isNotEmpty) {
               //로딩시작
                setState(() {
                  isLoading = true;
                });
                //업로드
                //이미지 피커 실행
               await  model.uplodaPsoet(
                    _titleTextController.text, _image!,
                );

               //로딩이 끝남
                setState(() {
                  isLoading = true;
                });

               //여기까지 왔을 때 화면이 살아 있다면
               if(mounted) {
                 //끝나고 나면(글쓰고나면) 화면을 뒤로 가겠다.
                 Navigator.pop(context);
                }
               }
            },
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
                controller: _titleTextController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "내용을 입력하세요",
                    fillColor: Colors.white70),
              ),
              const SizedBox(height: 20),
              //로딩 오래걸리는거 보여줌
              if(isLoading) const CircularProgressIndicator(),
              ElevatedButton(
                onPressed: () async {
                  //await 쓰려면 async 있어야함 && setState는 async와 함께 못써서 화면 갱신은 아래 따로
                  _image = await model.getImage(); //이미지 가져옴

                  //화면 갱신
                  setState(() {});
                },
                child: const Text('이미지 선택'),
              ),
              //이미지가 없을 경우 Placeholder을 사용하면 x표기로 나타남. && 그것의 사이즈 지정
              /*const SizedBox(
                  width: 300,
                  height: 300,
                  child: Placeholder()),
               */
              if (_image != null)
                Image.file(//파일 속 이미지 가져옴
                  _image!,//_image로 하면 에러나는 이유가 위에는 _image?로 지정을 했기 때문. !를 붙임으로 null이 아님을 보장
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
