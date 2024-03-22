import 'package:flutter/material.dart';

// ! 事件处理与通知-手势识别: 用于处理手势的 GestureDetector 和 GestureRecognizer.

void main() {
  runApp(const MaterialApp(
    home: DragTest(),
    title: '手势识别',
  ));
}

// * 拖动、滑动, GestureDetector 会将要监听的组件的原点作为本次手势的原点, 当用户在监听的组件上按下手指时, 手势识别就会开始.
class DragTest extends StatefulWidget {
  const DragTest({super.key});

  @override
  DragTestState createState() => DragTestState();
}

class DragTestState extends State<DragTest> {
  double _top = 0; // * 距顶部的偏移
  double _left = 0; // * 距左边的偏移

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('手势识别'),
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: _top,
              left: _left,
              child: GestureDetector(
                child: const CircleAvatar(
                  child: Text('原点'),
                ),
                // * 手指按下时会触发此回调
                onPanDown: (DragDownDetails e) {
                  // 打印手指按下的位置(相对于屏幕)
                  print('用户手指按下: ${e.globalPosition}');
                },
                // * 手指滑动时会触发此回调
                onPanUpdate: (DragUpdateDetails e) {
                  setState(() {
                    // * 用户手指滑动时, 更新偏移, 重新构建. delta 指一次 Update 事件的滑动的偏移量.
                    _left += e.delta.dx;
                    _top += e.delta.dy;
                  });
                },
                // * 垂直方向拖动事件, 只想在水平方向滑动同理.
                // onVerticalDragUpdate: (DragUpdateDetails details) {
                //   setState(() {
                //     _top += details.delta.dy;
                //   });
                // },
                onPanEnd: (DragEndDetails e) {
                  // * 打印滑动结束时在x、y轴上的速度. 代表用户抬起手指时的滑动速度(包含x、y两个轴的), 这里并没有处理手指抬起时的速度, 常见的效果是根据用户抬起手指时的速度做一个减速动画.
                  print(e.velocity);
                },
              ),
            )
          ],
        ));
  }
}
