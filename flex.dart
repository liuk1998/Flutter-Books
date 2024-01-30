import 'package:flutter/material.dart';

// ! 布局组件-弹性布局: Flex组件可以沿着水平或垂直方向排列子组件. 因为Row和Column都继承自Flex, 参数基本相同, 所以能使用Flex的地方基本上都可以使用Row或Column.

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '布局组件-弹性布局',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('布局组件-弹性布局'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flex(
              direction: Axis.horizontal, // 弹性布局的方向, Row默认为水平方向, Column默认为垂直方向
              children: <Widget>[
                // * Expanded 只能作为 Flex 的孩子
                Expanded(
                  // 弹性系数, 如果为 0 或 null, 则 child 是没有弹性的, 即不会被扩伸占用的空间. 如果大于0, 所有的 Expanded 按照其 flex 的比例来分割主轴的全部空闲空间
                  flex: 1,
                  child: Container(
                    height: 30,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30,
                    color: Colors.green,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
