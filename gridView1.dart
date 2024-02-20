import 'package:flutter/material.dart';

// ! 可滚动组件-网格列表

void main() {
  runApp(const GridViewBox());
}

class GridViewBox extends StatefulWidget {
  const GridViewBox({super.key});

  @override
  _GridViewBoxState createState() => _GridViewBoxState();
}

class _GridViewBoxState extends State<GridViewBox> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '可滚动组件-网格列表',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('可滚动组件-网格列表'),
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          ),
          // ! 这些方式都会提前将所有子 widget 都构建好, 所以只适用于子 widget 数量比较少时.
          // * GridView.extent 是 SliverGridDelegateWithMaxCrossAxisExtent 的简写方法: 横轴子元素为固定最大长度.
          body: GridView.extent(
            maxCrossAxisExtent: 120, // * 子元素在横轴上的最大长度
            childAspectRatio: 2, // * 子元素的宽高比
            children: const <Widget>[
              Icon(Icons.ac_unit),
              Icon(Icons.airport_shuttle),
              Icon(Icons.all_inclusive),
              Icon(Icons.beach_access),
              Icon(Icons.cake),
              Icon(Icons.free_breakfast)
            ],
          )
          // * GridView.count 是 SliverGridDelegateWithFixedCrossAxisCount 的简写方法: 横轴为固定数量子元素.
          // GridView.count(
          //   crossAxisCount: 3, // * 横轴子元素的数量
          //   childAspectRatio: 1, // * 子元素的宽高比
          //   children: const <Widget>[
          //     Icon(Icons.ac_unit),
          //     Icon(Icons.airport_shuttle),
          //     Icon(Icons.all_inclusive),
          //     Icon(Icons.beach_access),
          //     Icon(Icons.cake),
          //     Icon(Icons.free_breakfast)
          //   ],
          // )
          ),
    );
  }
}
