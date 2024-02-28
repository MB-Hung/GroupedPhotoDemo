import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoItem extends StatelessWidget {
  final int indexNumber;
  final int number;

  const PhotoItem({
    super.key,
    required this.indexNumber,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.green,
            width: Get.width * 0.25,
            height: Get.width * 0.25,
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          Container(
            color: Colors.blueGrey,
            width: Get.width * 0.25,
            height: 50,
            child: Text(
              'Index = $indexNumber',
              style: const TextStyle(fontSize: 16,color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
