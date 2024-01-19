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
      home: const ParentWidget(),
    );
  }
}

// * 父 Widget 管理子 Widget 的状态: 管理用户数据, 如复选框的选中状态、滑块的位置.
// 创建一个盒子，当点击它时，盒子背景会在绿色与灰色之间切换。状态 _active确定颜色：绿色为 true ，灰色为 false
// ? ParentWidget 管理 Tapbox 的状态.
class ParentWidget extends StatefulWidget {
  const ParentWidget({super.key});

  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false; // ? 盒子的当前颜色

  // ? 更新盒子的颜色
  void _handleTap(bool newValue) {
    print('子组件传入的状态, $newValue');
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Tapbox(
      active: _active,
      onChanged: _handleTap,
    ));
  }
}

// ? 所有状态都由其父组件处理, 当检测到点击时, 它会通知父组件.
class Tapbox extends StatelessWidget {
  const Tapbox({super.key, this.active = false, required this.onChanged});

  final bool active;
  final ValueChanged<bool> onChanged;

  void handleTap() {
    onChanged(!active);
    print('检测到点击事件, 通知父组件, ${!active}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
        child: Center(
          child: Text(
            active ? '选中' : '未选中',
            style: const TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
