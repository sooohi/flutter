class Post {
  String id;
  String userId;
  String title;
  String imageUrl;

  //생성자
  Post({
      required this.id,
      required this.userId,
      required this.title,
      required this.imageUrl
  });

  //2가지 유틸.메소드(가져오기/쓰기)

  // -1. firestore에서 데이터 받으면 json 형태로 받아서 post 형태로 변환해주는것
  //Post.fromJson은 dart문법에서 생성자를 만들어주 것 중 하나. post를 만드는 것중 json으로 만드는거를 정의한
  //json은 dart 문법에 map과 동일한 모양을 가짐. String은 key, dynamic은(아무거나 올 수 잇음) value.
  //factory는 이런 생성자 만들때 붙여줌
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      //json에서 userId라는 것을 가져와서 string으로 타입을 변환 하자
      id : json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  //-2. 쓰기
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
    };
  }
}
