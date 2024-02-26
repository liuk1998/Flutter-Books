import 'package:flutter/material.dart';

// ! 可滚动组件-CustomScrollView 和 Slivers: CustomScrollView 组件可以创建一个公共的 Scrollable 和 Viewport, 然后它的 slivers 参数接受一个 Sliver 数组, 这样在一个页面中, 同时包含多个可滚动组件, 且使它们的滑动效果能统一起来.
void main() {
  runApp(const CustomScrollViewBox());
}

class CustomScrollViewBox extends StatefulWidget {
  const CustomScrollViewBox({super.key});

  @override
  _CustomScrollViewBoxState createState() => _CustomScrollViewBoxState();
}

class _CustomScrollViewBoxState extends State<CustomScrollViewBox> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '可滚动组件-CustomScrollView 和 Slivers',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('可滚动组件-CustomScrollView 和 Slivers'),
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        ),
        body: buildTwoSliverList(),
      ),
    );
  }

  Widget buildTwoSliverList() {
    // * SliverFixedExtentList 高度固定的列表. 对应为 ListView, 指定 itemExtent 时.
    var listView = SliverFixedExtentList(
      // * 类似 ListView.build 构造函数. 主要参数是 builder, 返回值为 Widget 函数.
      delegate: SliverChildBuilderDelegate(
        (_, index) => ListTile(title: Text('$index')),
        childCount: 10,
      ),
      itemExtent: 56, // * 设置 item 高度.
    );

    // * CustomScrollView 可以将两个滚动组件合并为一个.
    return CustomScrollView(
      slivers: [
        listView,
        listView,
      ],
    );
  }
}
