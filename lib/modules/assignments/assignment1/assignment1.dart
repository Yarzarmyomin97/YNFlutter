import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yn_flutter/modules/assignments/assignment1/utils/common_utils.dart';

import 'models/image_model.dart';
import 'widgets/image_item.dart';

class Assignment1 extends StatefulWidget {
  const Assignment1({Key? key}) : super(key: key);

  @override
  _Assignment1State createState() => _Assignment1State();
}

class _Assignment1State extends State<Assignment1> {
  final _headerStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final _answerStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  String title = "Image Select Game";
  String pleaseSelect = "Please select ";
  String answer = "Your answer is ";
  String next = "Next";
  String score = "Score: ";
  String correct = "correct";
  String wrong = "wrong";
  String restart = "RESTART";
  String ok = "OK";

  int totalImages = 9;
  int scoreResult = 0;
  int count = 1;
  int selectedNumber = 0;
  bool isCorrect = false;
  bool nextBtnEnable = true;
  bool isResultVisible = false;

  List<ImageModel> imageList = [];
  List<ImageModel> shuffleImageList = [];
  List<int> resultList = [];

  @override
  void initState() {
    _shuffleList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text("$count /$totalImages"),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(pleaseSelect + selectedNumber.toString(),
                      style: _headerStyle),
                  Text(
                    "$score $scoreResult",
                    style: _headerStyle.copyWith(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: shuffleImageList
                      .map((item) => ImageItem(
                          onTap: item.clickable
                              ? () {
                                  checkValid(item, shuffleImageList);
                                }
                              : null,
                          imageModel: item))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              if (isResultVisible)
                Text(
                  isCorrect ? answer + correct : answer + wrong,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: nextBtnEnable
                        ? () {
                            _nextClick();
                          }
                        : null,
                    child: Text(
                      "Next",
                      style: _answerStyle,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _nextClick() {
    if (count < totalImages) {
      count++;
      // print("count: $count of $totalImages");
      isResultVisible = false;
      nextBtnEnable = false;
      if (!isCorrect) {
        resultList.add(0);
      }
      _shuffleList();
      setState(() {});
    } else {
      Map<int, int> map = resultList.asMap();
      // print(map);
      _showResult();
    }
  }

  void checkValid(ImageModel imageModel, List<ImageModel> imageList) {
    // print("selected no: ${imageModel.id}");
    if (selectedNumber == imageModel.id) {
      // print("true");
      isCorrect = true;
      imageModel.bgColor = Colors.green;
      resultList.add(1);
      for (var image in imageList) {
        if (image.clickable != false) image.clickable = false;
      }
      scoreResult++;
    } else {
      // print("false");
      isCorrect = false;
      imageModel.clickable = false;
      imageModel.bgColor = Colors.red;
    }
    imageModel.textColor = Colors.white;
    isResultVisible = true;
    nextBtnEnable = true;
    setState(() {});
  }

  _shuffleList() {
    imageList.clear();
    shuffleImageList.clear();
    for (int i = 1; i < totalImages; i++) {
      imageList.add(ImageModel(
        id: i,
        image: CommonUtils.imagePath(i),
        clickable: true,
        bgColor: Colors.grey.shade200,
        textColor: Colors.black,
      ));
    }
    imageList.shuffle();
    shuffleImageList = imageList.sublist(0, 3);
    selectedNumber = shuffleImageList[Random().nextInt(3)].id;
    // print("correct no: $selectedNumber");
    if (resultList.length == scoreResult) nextBtnEnable = false;
  }

  Future _showResult() async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: _headerStyle,
            ),
            content: Text(score + "$scoreResult out of $totalImages"),
            actions: [
              TextButton(
                onPressed: () {
                  count = 1;
                  scoreResult = 0;
                  isResultVisible = false;
                  resultList.clear();
                  _shuffleList();
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Text(restart),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(ok),
              ),
            ],
          );
        });
  }
}
