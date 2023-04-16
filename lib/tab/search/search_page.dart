import 'package:community/creat/creat_page.dart';
import 'package:flutter/material.dart';

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
        title: const Text('플러터 연습'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GridView.builder(
          //count는 화면에 표시할 아이템의 개수가 명확하게 정해져 있을때 column이나 row쓰듯이 사용. builder는 성능 좋게, 동적으로 사용
          itemCount: _urls.length, //gridView의 개수를 지정해야 지정한 만큼 이쁘게 나옴
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //crossAxisCount는 열 개수 && 사진 여백 주기
            crossAxisCount: 3,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            //이미지 3개 나오게 하는 부분
            final url = _urls[index];
            return Image.network(
              url,
              fit: BoxFit.cover, //꽉 찬 이미지. grid에서는 사이즈가 정사각형으로 알아서 지정
            );
          },
        ),
      ),
    );
  }
}
