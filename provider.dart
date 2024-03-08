import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ! 功能型组件-跨组件状态共享: Provider 是 Flutter 官方出的状态管理包, 基于将需要跨组件共享的状态保存在 InheritedWidget 中, 然后在子组件中引用 InheritedWidget 即可这个思想实现的.

// * 如何在两个独立的页面中共享计数器的状态: 两个页面中心字体共用了同一个字体大小. 第二个页面的按钮将会让数字增加, 第一个页面的数字将会同步增加.

// * ChangeNotifier 类: 实现了一个 Flutter 风格的发布者-订阅者模式. 通过调用 addListener() 和 removeListener() 来添加、移除监听器(订阅者), 通过调用 notifyListeners() 可以触发所有监听器回调.
// todo 创建数据类: 管理共享状态
class CounterModel extends ChangeNotifier {
  int _count = 0; // 数据(私有)
  int get count => _count; // 数据(暴露)

  // 用于更改数据
  void increment() {
    _count++;
    notifyListeners();
  }
}

// todo 初始化全局数据
void main() {
  final counter = CounterModel();
  const textSize = 48;

  // 通过 Provider<T>.value 能够管理一个恒定的数据, 并提供给子孙节点使用.
  runApp(Provider<int>.value(
    value: textSize,
    // ChangeNotifierProvider<T>.value 不仅能够提供数据供子孙节点使用, 还可以在数据改变的时候通知所有订阅者刷新.
    child: ChangeNotifierProvider.value(
      value: counter,
      child: MyApp(),
    ),

    // 除了上述几个属性之外 Provider<T>.value 还提供了 UpdateShouldNotify Function, 用于控制刷新时机.
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: FirstScreen(),
    );
  }
}

// todo 子页面 1
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取顶层数据最简单的方法就是 Provider.of<T>(context); 这里的范型 <T> 指定了获取 FirstScreen 向上寻找最近的储存了 T 的祖先节点的数据.
    // 通过这个方法获取了顶层的 CounterModel 及 textSize. 并在 Text 组件中进行使用.
    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<int>(context).toDouble();

    return Scaffold(
      appBar: AppBar(
        title: const Text('FirstPage'),
      ),
      body: Center(
        child: Text(
          'value: ${_counter.count}',
          style: TextStyle(fontSize: textSize),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SecondScreen())),
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

// todo 子页面 2
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SecondPage'),
      ),
      // Consumer2<A,B>. 使用方式基本上和 Consumer<T> 一致, 只不过范型改为了两个.
      body: Consumer2<CounterModel, int>(
        // builder 方法变成了 Function(BuildContext context, A value, B value2, Widget child).
        builder: (context, CounterModel counter, int textSize, _) => Center(
          child: Text(
            'value: ${counter.count}',
            style: TextStyle(fontSize: textSize.toDouble()),
          ),
        ),
      ),
      // Consumer 使用了 Builder 模式, 收到更新通知就会通过 builder 重新构建. Consumer<T> 代表了它要获取哪一个祖先中的 Model.
      floatingActionButton: Consumer<CounterModel>(
        // Consumer 的 builder 实际上就是一个 Function, 它接收三个参数 (BuildContext context, T model, Widget child).
        builder: (context, CounterModel counter, child) => FloatingActionButton(
          onPressed: counter.increment,
          child: child,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
