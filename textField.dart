import 'package:flutter/material.dart';

// ! 基础组件-输入框及表单

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SwitchAndCheckBox(),
      title: '基础组件-输入框及表单',
    );
  }
}

class SwitchAndCheckBox extends StatefulWidget {
  const SwitchAndCheckBox({super.key});

  @override
  State<SwitchAndCheckBox> createState() => _SwitchAndCheckBoxState();
}

class _SwitchAndCheckBoxState extends State<SwitchAndCheckBox> {
  // todo 创建焦点控制范围
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  // * 编辑框的控制器. 通过它可以设置/获取编辑框的内容、选择编辑内容、监听编辑文本改变事件.
  final _unameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // * 设置默认值
    _unameController.text = 'hello world';
    // * 从第三个字符开始选中后面的字符
    _unameController.selection = TextSelection(
        baseOffset: 2, extentOffset: _unameController.text.length);
    // * 监听文本变化
    _unameController.addListener(() {
      print('监听文本变化: ${_unameController.text}');
    });
    // todo 监听焦点状态
    focusNode1.addListener(() {
      print('监听用户名焦点: ${focusNode1.hasFocus}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('基础组件-输入框及表单'),
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
              inputDecorationTheme: const InputDecorationTheme(
                  labelStyle: TextStyle(color: Colors.orange), // 自定义label字体样式
                  hintStyle: TextStyle(
                      color: Colors.green, fontSize: 14))), // 自定义提示文本样式
          child: Column(
            children: <Widget>[
              // * 用于文本输入
              TextField(
                  autofocus: true, // 是否自动获取焦点
                  controller: _unameController, // * 设置控制器.
                  focusNode: focusNode1, // todo 关联焦点
                  // ? 输入框的外观显示
                  decoration: const InputDecoration(
                      labelText: '用户名', // 输入框的名称
                      hintText: '用户名或邮箱', // placeholder
                      prefixIcon: Icon(Icons.person), // 输入框的头部图标
                      // 自定义样式 - 未获得焦点下划线设为灰色
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      // 自定义样式 - 获得焦点下划线设为蓝色
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)))),
              TextField(
                focusNode: focusNode2, // todo 关联焦点
                decoration: const InputDecoration(
                  labelText: '密码',
                  hintText: '您的登录密码',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              Builder(builder: (ctx) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      ElevatedButton(
                          onPressed: () {
                            print(
                                '获取输入内容: ${_unameController.text}'); // ? 获取输入内容
                          },
                          child: const Text('提交')),
                      ElevatedButton(
                          onPressed: () {
                            // todo 将焦点移到密码框
                            FocusScope.of(context).requestFocus(focusNode2);
                          },
                          child: const Text('移动焦点')),
                      ElevatedButton(
                          onPressed: () {
                            // todo 失去焦点
                            focusNode1.unfocus();
                            focusNode2.unfocus();
                          },
                          child: const Text('隐藏键盘')),
                    ],
                  ),
                );
              })
            ],
          ),
        ));
  }
}
