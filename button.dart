import 'package:flutter/material.dart';

// ! 基础组件-按钮

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
          title: const Text('基础组件-按钮'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              // ! Material 库中的按钮都有如下相同点: 1.按下时都会有"水波动画". 2.onPressed 属性来设置点击回调.
              // * "漂浮"按钮, 默认带有阴影和灰色背景. 按下后阴影会变大.
              ElevatedButton(onPressed: () {}, child: const Text('漂浮按钮')),
              // * 文本按钮, 默认背景透明. 按下后会有背景色.
              TextButton(onPressed: () {}, child: const Text('文本按钮')),
              // * 默认有一个边框, 不带阴影且背景透明. 按下后边框颜色会变亮、同时出现背景和阴影(较弱).
              OutlinedButton(
                  onPressed: () {}, child: const Text('OutlinedButton')),
              // * 一个可点击的Icon, 不包括文字, 默认没有背景, 点击后会出现背景.
              IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up)),
              // * ElevatedButton、TextButton、OutlinedButton 都有一个 icon 构造函数, 通过它可以创建带图标的按钮.
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.send),
                label: const Text('发送'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
