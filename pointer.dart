import 'package:flutter/material.dart';

// ! 事件处理与通知-触摸事件(原始指针事件处理): 一次完整的事件分为三个阶段: 手指按下、手指移动、和手指抬起, 而更高级别的手势(如点击、双击、拖动等)都是基于这些原始事件的.
// ! 当指针按下时, Flutter会对应用程序执行命中测试, 以确定指针与屏幕接触的位置存在哪些组件,  指针按下事件(以及该指针的后续事件)然后被分发到由命中测试发现的最内部的组件, 然后从那里开始, 事件会在组件树中向上冒泡, 这些事件会从最内部的组件被分发到组件树根的路径上的所有组件, 这和Web开发中浏览器的事件冒泡机制相似, 但是Flutter中没有机制取消或停止"冒泡"过程, 而浏览器的冒泡是可以停止的. 注意, 只有通过命中测试的组件才能触发事件.
// ! 假如我们不想让某个子树响应PointerEvent的话, 我们可以使用IgnorePointer和AbsorbPointer, 这两个组件都能阻止子树接收指针事件, 不同之处在于AbsorbPointer本身会参与命中测试, 而IgnorePointer本身不会参与
void main() {
  runApp(const MaterialApp(
    home: PointerTest(),
    title: '触摸事件(原始指针事件处理)',
  ));
}

// * 手指在一个容器上移动时查看手指相对于容器的位置.

class PointerTest extends StatefulWidget {
  const PointerTest({super.key});

  @override
  PointerTestState createState() => PointerTestState();
}

class PointerTestState extends State<PointerTest> {
  PointerEvent? event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('触摸事件(原始指针事件处理)'),
      ),
      // * 可以使用 Listener 来监听原始触摸事件.
      body: Listener(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 300,
          height: 150,
          child: Text(
            '${event?.localPosition ?? ''}', // localPosition: 它是指针相对于当对于本身布局坐标的偏移.
            style: const TextStyle(color: Colors.white),
          ),
        ),
        // * 手指按下回调
        onPointerDown: (PointerDownEvent e) => setState(() {
          event = e;
        }),
        // * 手指移动回调
        onPointerMove: (PointerMoveEvent e) => setState(() {
          event = e;
        }),
        // * 手指抬起回调
        onPointerUp: (PointerUpEvent e) => setState(() {
          event = e;
        }),
      ),
    );
  }
}
