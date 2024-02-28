import 'package:flexible_scrollbar/flexible_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_photo/widgets/photo_item.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import 'controller/grouped_photo_controller.dart';

class GroupedPhotoScreen extends StatefulWidget {
  const GroupedPhotoScreen({super.key});

  @override
  State<GroupedPhotoScreen> createState() => _GroupedPhotoScreenState();
}

class _GroupedPhotoScreenState extends State<GroupedPhotoScreen> {
  final GroupedPhotoController c = Get.put(GroupedPhotoController());
  final ScrollController myScrollController = ScrollController();

  final screenheight = Get.height / 4;
  final double thumbWidth = 5;
  final double thumbDragWidth = 10;

  final _keys = {};

  var listViewKey = RectGetter.createGlobalKey();

  @override
  Widget build(BuildContext context) {
    c.createRandomList();

    return Scaffold(
      appBar: AppBar(),
      body: rectGetterMethod(),
    );
  }

  double getRenderHeight(int index) {
    var remainder = c.randomList[index].length % 3;
    var row = c.randomList[index].length / 3;
    var height = 0.0;

    if (remainder == 0) {
      if (row * (Get.width * 0.3) < Get.height / 4) {
        height = Get.height / 4;
      } else {
        height = row * (Get.width * 0.5);
      }
    } else {
      if ((row + 1) * (Get.width * 0.3) < Get.height / 4) {
        height = Get.height / 4;
      } else {
        height = (row + 1) * (Get.width * 0.5);
      }
    }

    return height;
  }

  Widget rectGetterMethod() {
    return FlexibleScrollbar(
      alwaysVisible: true,
      controller: myScrollController,
      scrollLabelBuilder: (info) {
        return AnimatedContainer(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(info.isDragging ? 1 : 0.6),
            borderRadius: BorderRadius.circular(15),
          ),
          duration: const Duration(milliseconds: 300),
          child: Obx(() {
            return Text(
              'Index #${c.index.value}',
              style: const TextStyle(
                color: Colors.white,
              ),
            );
          }),
        );
      },
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          c.index(getVisible().first);
          return false;
        },
        child: RectGetter(
          key: listViewKey,
          child: ListView.builder(
            controller: myScrollController,
            itemCount: c.randomList.length,
            itemBuilder: (BuildContext context, int index) {
              _keys[index] = RectGetter.createGlobalKey();
              return RectGetter(
                key: _keys[index],
                child: StickyHeader(
                    header: Container(
                      height: 50.0,
                      color: Colors.blueGrey[700],
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Index #$index',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    content: SizedBox(
                      height: getRenderHeight(index),
                      child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: Get.width * 0.25 / (Get.width * 0.25 + 50),
                          ),
                          children: <Widget>[
                            for (var i = 0; i < c.randomList[index].length; i++)
                              PhotoItem(
                                indexNumber: index,
                                number: c.randomList[index][i],
                              )
                          ]),
                    )),
              );
            },
          ),
        ),
      ),
    );
  }

  List<int> getVisible() {
    var rect = RectGetter.getRectFromKey(listViewKey);
    var items = <int>[];
    _keys.forEach((index, key) {
      var itemRect = RectGetter.getRectFromKey(key);
      if (itemRect != null && !(itemRect.top > rect!.bottom || itemRect.bottom < rect.top)) items.add(index);
    });

    items.sort();
    return items;
  }
}
