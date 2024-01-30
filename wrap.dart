import 'package:flutter/material.dart';

// ! 布局组件-流式布局: 因为 Row 默认只有一行, 如果超出屏幕不会折行会报错. 所以通过 Wrap 和 Flow 来支持流式布局, 溢出部分则会自动折行. 很少会使用 Flow(过于复杂, 不能自适应子组件大小).

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '布局组件-流式布局',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('布局组件-流式布局'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: const Wrap(
            spacing: 8, // 主轴(水平)方向间距
            runSpacing: 4, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.center, // 沿主轴方向居中
            children: <Widget>[
              Chip(
                label: Text('Hamilton'),
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('A'),
                ),
              ),
              Chip(
                label: Text('Lafayette'),
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('M'),
                ),
              ),
              Chip(
                label: Text('Mulligan'),
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('H'),
                ),
              ),
              Chip(
                label: Text('Laurent'),
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('J'),
                ),
              ),
            ],
          )),
    );
  }
}
