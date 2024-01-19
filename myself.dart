// * 导入了 Material UI 组件库
import 'package:flutter/material.dart';

// ! 状态管理: Widget管理自身状态、父 Widget 管理子 Widget 的状态、混合状态管理、全局状态管理.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyselfBox(),
    );
  }
}

// * Widget管理自身状态: 管理有关界面外观效果的状态, 例如颜色、动画.
// 创建一个盒子，当点击它时，盒子背景会在绿色与灰色之间切换。状态 _active确定颜色：绿色为 true ，灰色为 false
// ? MyselfBox 管理自身状态.
class MyselfBox extends StatefulWidget {
  const MyselfBox({super.key});

  @override
  _MyselfBoxState createState() => _MyselfBoxState();
}

class _MyselfBoxState extends State<MyselfBox> {
  bool _active = false; // ? 盒子的当前颜色

  // ? 更新盒子的颜色
  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _handleTap, // ? 绑定点击事件
        child: Container(
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[600],
          ),
          child: Center(
            child: Text(
              _active ? '选中' : '未选中',
              style: const TextStyle(fontSize: 32.0, color: Colors.white),
            ),
          ),
        ));
  }
}
