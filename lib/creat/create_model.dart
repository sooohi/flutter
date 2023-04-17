import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CreateModel{
  //imagepicker 설정
  final _picker = ImagePicker();

  //await를 쓰기 위해서는 오래걸리는 Future 사용
  Future<File?> getImage() async{
    //await는 오래 걸리는 함수 && gallery말고 직접 찍은 사진은 camera
    final XFile? image=await _picker.pickImage(source: ImageSource.gallery);
    //이미지가 null이면 null 리턴하고 아니면 경로 리턴
    if(image==null) {
      return null;
    }
    return File(image.path);

  }
}