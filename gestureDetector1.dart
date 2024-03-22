import 'package:flutter/material.dart';

// ! 事件处理与通知-手势识别: 用于处理手势的 GestureDetector 和 GestureRecognizer.

void main() {
  runApp(const MaterialApp(
    home: GestureDetectorTest(),
    title: '手势识别',
  ));
}

// * 点击、双击、长按, 通过 GestureDetector 对 Container 进行手势识别, 触发相应事件后, 在Container上显示事件名.
class GestureDetectorTest extends StatefulWidget {
  const GestureDetectorTest({super.key});

  @override
  GestureDetectorTestState createState() => GestureDetectorTestState();
}

class GestureDetectorTestState extends State<GestureDetectorTest> {
  String operation = '未检测到手势!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('手势识别'),
      ),
      body: Center(
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 200,
            height: 100,
            child: Text(
              operation,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          onTap: () => updateText('点击'),
          onDoubleTap: () => updateText('双击'),
          onLongPress: () => updateText('长按'),
        ),
      ),
    );
  }

  void updateText(String text) {
    // 更新显示的事件名
    setState(() {
      operation = text;
    });
  }
}
