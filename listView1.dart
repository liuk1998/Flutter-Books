import 'package:flutter/material.dart';

// ! 可滚动组件-ListView: 最常用的可滚动组件之一, 它可以沿一个方向线性排布所有子组件, 并且它也支持列表项懒加载(在需要时才会创建).

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Widget blueDivider = const Divider(color: Colors.blue);
  Widget greenDivider = const Divider(color: Colors.green);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '可滚动组件-ListView',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Name'),
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        ),
        // * ListView.builder 适合列表项比较多或者列表项不确定的情况.
        body: ListView.builder(
            itemCount: 30, // * 列表项的数量, 如果为null, 则为无限列表.
            itemExtent: 50, // * 强制高度为50
            // * 列表项的构建器, 返回值为一个widget. 当列表滚动到具体的index位置时, 会调用该构建器构建列表项.
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('$index'),
              );
            }),
        // * ListView.separated 可以在生成的列表项之间添加一个分割组件, 它比ListView.builder多了一个separatorBuilder参数, 该参数是一个分割组件生成器.
        // body: ListView.separated(
        //   itemCount: 30,
        //   itemBuilder: (BuildContext context, int index) {
        //     return ListTile(
        //       title: Text('$index'),
        //     );
        //   },
        //   // * 分割器构造器
        //   separatorBuilder: (BuildContext context, int index) {
        //     return index % 2 == 0 ? blueDivider : greenDivider;
        //   },
        // ),
      ),
    );
  }
}
