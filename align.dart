import 'package:flutter/material.dart';

// ! 布局组件-对齐与相对定位

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '布局组件-对齐与相对定位',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('布局组件-对齐与相对定位'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: Container(
              height: 120,
              width: 120,
              color: Colors.blue.shade50,
              // Align只能有一个子元素, 不存在堆叠
              // 可以认为 Center 组件其实是对齐方式确定(Alignment.center)了的 Align.
              child: const Align(
                alignment: Alignment.topRight, // 子组件在父组件中的起始位置
                // Flutter 的 logo
                child: FlutterLogo(
                  size: 60,
                ),
              ),
            )));
  }
}
