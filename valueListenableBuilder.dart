import 'package:flutter/material.dart';

// ! 功能型组件-按需rebuild(ValueListenableBuilder): InheritedWidget 提供一种在 widget 树中从上到下共享数据的方式, 但是也有很多场景数据流向并非从上到下, 比如从下到上或者横向等. 为了解决这个问题, Flutter 提供了一个 ValueListenableBuilder 组件, 它的功能是监听一个数据源, 如果数据源发生变化, 则会重新执行其 builder

// * 实现一个路由换肤功能.
void main() {
  runApp(const ValueListenableRoute());
}

class ValueListenableRoute extends StatefulWidget {
  const ValueListenableRoute({super.key});

  @override
  ValueListenableRouteState createState() => ValueListenableRouteState();
}

class ValueListenableRouteState extends State<ValueListenableRoute> {
  // * 定义一个 ValueNotifier, 当数字变化时会通知 ValueListenableBuilder
  final ValueNotifier<int> counter = ValueNotifier<int>(0);
  static const double textScaleFactor = 1.5;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ValueListenableBuilder 测试',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ValueListenableBuilder 测试'),
        ),
        body: Center(
          child: ValueListenableBuilder<int>(
            // * 数据源发生变化通知时, 会重新调用 builder 重新 build 子组件树
            builder: (BuildContext context, int value, Widget? child) {
              // * builder 方法只会在 counter 变化时被调用
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  child!,
                  Text(
                    '$value 次',
                    // ignore: deprecated_member_use
                    textScaleFactor: textScaleFactor,
                  )
                ],
              );
            },
            valueListenable: counter, // * 类型为 ValueListenable<T>, 表示一个可监听的数据源
            // * 当子组件不依赖变化的数据, 且子组件收件开销比较大时, 指定 child 属性来缓存子组件非常有用
            child: const Text(
              '点击了 ',
              // ignore: deprecated_member_use
              textScaleFactor: textScaleFactor,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // * 点击后值 +1, 触发 ValueListenableBuilder 重新构建
          onPressed: () => counter.value += 1,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
