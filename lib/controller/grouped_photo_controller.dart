import 'dart:math';

import 'package:get/get.dart';

class GroupedPhotoController extends GetxController {
  var index = 0.obs;
  var randomList = [[], [], [], [], [], [], [], [], [], []].obs;
  var count = 30;
  var exitNum = [];

  void createRandomList() {
    count = 30;
    randomList.value = [[], [], [], [], [], [], [], [], [], []];
    exitNum = [];

    while (count > 0) {
      var arrayIndex = Random().nextInt(10);
      var randomNumber = Random().nextInt(30);

      if (!exitNum.contains(randomNumber)) {
        exitNum.add(randomNumber);
        randomList[arrayIndex].add(randomNumber);
        count--;
      }
    }
  }
}
