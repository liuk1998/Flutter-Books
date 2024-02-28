import 'package:flutter/material.dart';

// ! 功能型组件-数据共享: 提供了一种在 widget 树中从上到下共享数据的方式, 比如我们在应用的根 widget 中通过 InheritedWidget 共享了一个数据, 那么我们便可以在任意子 widget 中来获取该共享的数据.
// * "计数器"示例应用程序的 InheritedWidget 版本
void main() {
  runApp(InheritedWidgetTestRoute());
}

// * 共享数据组件
class ShareDataWidget extends InheritedWidget {
  const ShareDataWidget({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final int data; // 需要在子树中共享的数据, 保存点击次数.

  // 定义一个便捷方法, 方便子树中的 widget 获取共享数据.
  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  // 该回调决定当 data 发生变化时, 是否通知子树中依赖 data 的 Widget 重新 build.
  @override
  bool updateShouldNotify(ShareDataWidget old) {
    return old.data != data;
  }
}

// * 子组件 需要使用 InheritedWidget 中的共享数据
class TestWidget extends StatefulWidget {
  @override
  TestWidgetState createState() => TestWidgetState();
}

class TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    // 使用 InheritedWidget 中的共享数据
    return Text(ShareDataWidget.of(context)!.data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 父或祖先 widget 中的 InheritedWidget 改变 (updateShouldNotify 返回 true) 时会被调用.
    // 如果 build 中没有依赖 InheritedWidget, 则此回调不会被调用.
    print('Dependencies change');
  }
}

// * 可视化的父组件
class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  InheritedWidgetTestRouteState createState() =>
      InheritedWidgetTestRouteState();
}

class InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '功能型组件-数据共享',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('功能型组件-数据共享'),
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        ),
        body: Center(
          // 使用 ShareDataWidget
          child: ShareDataWidget(
            data: count,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TestWidget(), // 子 widget 中依赖 ShareDataWidget
                ),
                ElevatedButton(
                  // 每点击一次, 将 count 自增, 然后重新 build, ShareDataWidget的 data 将被更新.
                  onPressed: () => setState(() => ++count),
                  child: const Text('增加'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
