import 'package:flutter/material.dart';

// ! 容器组件-填充

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '容器组件-填充',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('容器组件-填充'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            // * Padding 可以给其子节点添加填充(留白).
            body: const Padding(
              padding: EdgeInsets.all(16), // all: 所有方向均使用相同数值的填充.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    // only: 可以设置具体某个方向的填充(可以同时指定多个方向).
                    padding: EdgeInsets.only(left: 8),
                    child: Text('padding-left: 8px'),
                  ),
                  Padding(
                    // symmetric: 用于设置对称方向的填充, vertical 指top和bottom, horizontal指left和right.
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('padding: 8px 0px'),
                  ),
                  Padding(
                    // fromLTRB: 分别指定四个方向的填充.
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Text('padding: 0 20px 10px 20px'),
                  )
                ],
              ),
            )));
  }
}
