import 'package:flutter/material.dart';

// ! 基础组件-图片及ICON

void main() {
  runApp(const TextWidget());
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('基础组件-图片及ICON'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              // * 从 asset 中加载图片.
              Image.asset(
                'images/head.jpg',
                width: 100,
              ),
              // * 从网络加载图片.
              Image.network(
                'https://avatars2.githubusercontent.com/u/20411648?s=460&v=3',
                width: 100,
              ),
              // * 使用 Material Design 字体图标.
              const Icon(
                Icons.sensors,
                color: Colors.orange,
              )
            ],
          ),
        ),
      ),
    );
  }
}
