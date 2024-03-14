import 'package:flutter/material.dart';

// ! 功能型组件-颜色和主题

// * 实现一个路由换肤功能.
void main() {
  runApp(ThemeTestRoute());
}

class ThemeTestRoute extends StatefulWidget {
  @override
  ThemeTestRouteState createState() => ThemeTestRouteState();
}

class ThemeTestRouteState extends State<ThemeTestRoute> {
  var themeColor = Colors.teal; // 当前路由主题色

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return MaterialApp(
      title: '颜色和主题',
      home: Theme(
        data: ThemeData(
            // * primarySwatch: 主题颜色的一个"样本色", 通过这个样本色可以在一些条件下生成一些其他的属性, 例如, 如果没有指定primaryColor, 并且当前主题不是深色主题, 那么primaryColor就会默认为primarySwatch指定的颜色.
            primarySwatch: themeColor, // 用于导航栏、FloatingActionButton的背景色等
            iconTheme: IconThemeData(color: themeColor) // 用于Icon颜色
            ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('主题'),
            // 导航栏背景颜色
            backgroundColor: themeColor,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 第一行Icon使用主题中的iconTheme
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("  颜色跟随主题"),
                ],
              ),
              // 为第二行Icon自定义颜色(固定为黑色)
              Theme(
                  data: themeData.copyWith(
                    iconTheme:
                        themeData.iconTheme.copyWith(color: Colors.black),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.favorite),
                      Icon(Icons.airport_shuttle),
                      Text("  颜色固定黑色"),
                    ],
                  ))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => setState(() {
              themeColor =
                  themeColor == Colors.teal ? Colors.blue : Colors.teal;
            }),
            child: const Icon(Icons.palette),
          ),
        ),
      ),
    );
  }
}
