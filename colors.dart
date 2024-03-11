import 'package:flutter/material.dart';

// ! 功能型组件-颜色和主题

// * 实现一个背景颜色和Title可以自定义的导航栏, 并且背景色为深色时我们应该让Title显示为浅色. 背景色为浅色时, Title 显示为深色.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '颜色和主题',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('颜色和主题'), // 页面标题
        ),
        body: Column(
          children: <Widget>[
            NavBar(color: Colors.blue, title: '标题'),
            NavBar(color: Colors.white, title: '标题'),
          ],
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  final String title;
  final Color color; //背景颜色

  NavBar({
    Key? key,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 52,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: color,
        boxShadow: const [
          //阴影
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          // * computeLuminance()方法, 它可以返回一个[0-1]的一个值, 数字越大颜色就越浅, 我们可以根据它来动态确定Title的颜色.
          color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
