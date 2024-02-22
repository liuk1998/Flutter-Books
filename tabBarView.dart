import 'package:flutter/material.dart';

// ! 可滚动组件-TabBarView 与 TabBar: TabBarView 是 Material 组件库中提供了 Tab 布局组件, 通常和 TabBar(为 TabBarView 的导航标题) 配合使用.
void main() {
  runApp(const TabBarViewBox());
}

class TabBarViewBox extends StatefulWidget {
  const TabBarViewBox({super.key});

  @override
  _TabBarViewBoxState createState() => _TabBarViewBoxState();
}

class _TabBarViewBoxState extends State<TabBarViewBox> {
  List tabs = ['新闻', '历史', '图片'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '可滚动组件-TabBarView 与 TabBar',
      // * 为了使所选的 tab 与它对应的内容能同步化, 需要用 TabController 控制, 既可以手动创建一个 TabController, 也可以直接使用 DefaultTabController 父组件(能够创建出可供所有子组件使用的 TabController ).
      home: DefaultTabController(
        length: tabs.length, // * 导航长度
        child: Scaffold(
          appBar: AppBar(
            title: const Text('可滚动组件-TabBarView 与 TabBar'),
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
            // * 导航标题
            bottom: TabBar(
              tabs: tabs.map((e) => Tab(text: e)).toList(),
            ),
          ),
          // * 导航内容
          body: TabBarView(
            children: tabs.map((e) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  e,
                  // ignore: deprecated_member_use
                  textScaleFactor: 5,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
