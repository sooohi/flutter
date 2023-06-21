import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfire_ui/auth.dart';

import '../tab/tab_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      //StreamBuilder는 스트림 데이터를 기반으로 ui로 변경해주는 위젯
      //FirebaseAuth.instance = firebase를 통해서 인증을 수행한체 객체의 정보를 얻음
      //authStateChanges로 로그인이 됬는지 안됬는지 상태가 바뀔때마 변경 알려주는 스트림
      stream: FirebaseAuth.instance.authStateChanges(),
      //snapshot안에는 User?의 정보가 들어있음. Users는 firebase에서 로그인한 객체
      builder: (context, snapshot) {
        //User is not signed in
        //hasData는 정보가 들어있는지 확. 그래서 데이터 없으면 if다음 내용 실행. 있으면 return TabPage 표시.
        if (!snapshot.hasData) {
          //로그인 화면 제공
          return SignInScreen(
              providerConfigs: const [
                EmailProviderConfiguration(),
              ],
              headerBuilder: (context, constraints, _) {
                return const Center(
                  child: Text(
                    '모든 게시물',
                    style: TextStyle(fontSize: 40),
                  ),
                );
              });
        }
        // Render your application if authenticated
        return const TabPage();
      },
    );
  }
}
