// * 导入了 Material UI 组件库
import 'package:flutter/material.dart';

// ! Flutter 中万物皆为 Widget (组件). 可以理解为搭积木.

// * 应用程序的入口
void main() {
  // * 启动 Flutter 应用, 接收一个 Widget 参数, 在本示例中它是一个MyApp对象, MyApp()是 Flutter 应用的根组件.
  runApp(const MyApp());
}

// * MyApp 类代表 Flutter 应用, 它继承了 StatelessWidget 类(无状态的组件)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // * Flutter 在构建页面时, 会调用组件的 build 方法
  @override
  Widget build(BuildContext context) {
    // * MaterialApp 是 Material 库中提供的 Flutter APP 框架, 通过它可以设置应用的名称、主题、语言、首页及路由列表等. MaterialApp也是一个 widget.
    return MaterialApp(
      // ? 应用名称
      title: 'Flutter Demo',
      // ? 主题
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // ? 首页, 它也是一个 widget.
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// * 应用首页, 它继承自 StatefulWidget 类, 表示它是一个有状态的组件(Stateful widget).
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  // * _MyHomePageState 类是 MyHomePage 类对应的状态类
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// * MyHomePage 类对应的状态类(一个 StatefulWidget 类会对应一个 State 类)
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // ? 用于记录按钮点击的总次数

  // ? 次数增加函数
  void _incrementCounter() {
    // * 通知 Flutter 框架, 有状态发生了改变, Flutter 框架收到通知后, 会执行 build 方法来根据新的状态重新构建界面.
    setState(() {
      _counter++;
    });
  }

  // ! Flutter 生命周期
  // ! initState: 初始化状态. 当 widget 第一次插入到 widget 树时会被调用, 只会调用一次.
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  // ! didChangeDependencies: 当State对象的依赖发生变化时会被调用.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  // ! build: 在调用 initState() / didUpdateWidget() / setState() / didChangeDependencies() 之后都会调用.
  // * 当 MyHomePage 第一次创建时, _MyHomePageState 类会被创建, 初始化完成后, Flutter框架会调用 widget 的 build 方法来构建 widget 树, 最终将 widget 树渲染到设备屏幕上.
  @override
  Widget build(BuildContext context) {
    print('build');
    // * Scaffold 是 Material 库中提供的页面脚手架, 它提供了默认的导航栏、标题和包含主屏幕 widget 树的 body 属性.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // * body的组件树中包含了一个Center 组件, Center 可以将其子组件树对齐到屏幕中心.
      body: Center(
        // * Center 子组件是一个 Column 组件, Column的作用是将其所有子组件沿屏幕垂直方向依次排列.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ? 显示固定文本
            const Text(
              'You have clicked the button this many times:',
            ),
            // ? 显示_counter状态的数值
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // ? 抽屉按钮
            Builder(builder: (context) {
              return ElevatedButton(
                  onPressed: () {
                    // ? 可以从当前节点沿着 widget 树向上查找指定类型的 StatefulWidget 对应的 State 对象的方式有哪些? 此示例是查找父级最近的 Scaffold 对应的 ScaffoldState 对象.
                    // ? 1.通过Context获取: findAncestorStateOfType() / of()
                    // ? 2.通过GlobalKey, 但开销较大应尽量避免, 同一个 GlobalKey 在整个 widget 树中必须是唯一的, 不能重复.
                    // ScaffoldState? state =
                    //     context.findAncestorStateOfType<ScaffoldState>();
                    ScaffoldState? state = Scaffold.of(context);
                    state.openDrawer();
                  },
                  child: const Text('打开抽屉菜单'));
            })
          ],
        ),
      ),
      drawer: const Drawer(),
      // * 页面右下角的带 + 的悬浮按钮.
      floatingActionButton: FloatingActionButton(
        // ? 点击后执行的函数.
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  // ! reassemble: 专门为了开发调试而提供的, 在热重载时会被调用.
  @override
  void reassemble() {
    super.reassemble();
    print('reassemble');
  }

  // ! didUpdateWidget: 在 widget 重新构建时, 检测 widget 树中同一位置的新旧节点需要更新时调用.
  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  // ! deactivate: 当 State 对象从树中被移除时调用.
  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  // ! dispose: 当 State 对象从树中被永久移除时调用, 释放资源.
  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }
}
