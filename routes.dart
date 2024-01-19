import 'package:flutter/material.dart';

// ! Flutter 中万物皆为 Widget (组件). 可以理解为搭积木.

// * 应用程序的入口
void main() {
  // * 启动 Flutter 应用.
  runApp(const MyApp());
}

// * 根组件, 无状态的组件
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // * 构建方法
  @override
  Widget build(BuildContext context) {
    // * Flutter 框架.
    return MaterialApp(
      // ? 应用名称
      title: 'Flutter Demo',
      // ? 主题
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // ? 首页
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// * 应用首页, 有状态的组件.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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

  // * 构建方法.
  @override
  Widget build(BuildContext context) {
    // * Scaffold 是 Material 库中提供的页面脚手架.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // * body组件树.
      body: Center(
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
                    // ? 获取父组件上下文对象.
                    ScaffoldState? state = Scaffold.of(context);
                    state.openDrawer();
                  },
                  child: const Text('打开抽屉菜单'));
            }),
            // ? 路由按钮
            TextButton(
              child: const Text('open new route'),
              onPressed: () async {
                // ! 跳转新路由
                // ! MaterialPageRoute 是 Material 组件库提供的组件. 路由切换动画(可根据安卓或IOS切换对应得动画).
                // MaterialPageRoute 可以接收的四个参数:
                // 1.builder(具体的路由页面, 返回值为 widget).
                // 2.settings(路由的配置信息).
                // 3.maintainState(bool类型, 跳转到新路由后是否释放掉原路由的内存, false 为释放).
                // 4.fullscreenDialog(bool类型, 新的路由页面是否是一个全屏的模态对话框).
                // ! Navigator 是路由管理的组件, 提供了打开(push)和退出(pop)路由页方法.
                var result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const NewRoute(text: 'This is new route'); // ? 路由传参
                }));
                print('路由返回值: $result');
              },
            )
          ],
        ),
      ),
      drawer: const Drawer(),
      // * 页面右下角的带 + 的悬浮按钮.
      floatingActionButton: FloatingActionButton(
        // ? 点击事件.
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ! 新路由
class NewRoute extends StatelessWidget {
  const NewRoute({super.key, required this.text});

  final String text; // ? 必填参数

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Route'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(text),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, 'I am back!'), // ? 路由回退并携带参数
                  child: const Text('Go Back'),
                )
              ],
            )
          ),
        ));
  }
}
