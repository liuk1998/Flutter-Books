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
  List<IconData> iconList = [];

  @override
  void initState() {
    super.initState();
    retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '可滚动组件-网格列表',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('可滚动组件-网格列表'),
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        ),
        // ! 当子 widget 比较多时, 我们可以通过 GridView.builder 来动态创建子 widget.
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 每行三列
            childAspectRatio: 1, // 显示区域宽高相等
          ),
          itemCount: iconList.length,
          itemBuilder: (context, index) {
            // 如果显示到最后一个并且 Icon 总数小于200时继续获取数据
            if (index == iconList.length - 1 && iconList.length < 200) {
              retrieveIcons();
            }
            return Icon(iconList[index]);
          },
        ),
      ),
    );
  }

  // * 模拟异步获取数据
  void retrieveIcons() {
    Future.delayed(const Duration(milliseconds: 200)).then((value) => {
          setState(() => iconList.addAll([
                // 拼接数组
                Icons.ac_unit,
                Icons.airport_shuttle,
                Icons.all_inclusive,
                Icons.beach_access,
                Icons.cake,
                Icons.free_breakfast,
              ]))
        });
  }
}
