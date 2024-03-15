import 'package:flutter/material.dart';

// ! 功能型组件-对话框

void main() {
  // ! 在 Flutter 中使用 showDialog() 类显示对话框时, 可能会出现 No MaterialLocalizations found错误. 问题是将子小部件放在 MaterialApp() 小部件的home属性上, 而不创建新的小部件类.
  // ! 一种解决方法是将 MaterialApp() 放入 runApp() 中, 并为 home 属性创建新的类.
  runApp(const MaterialApp(
    home: DialogTest(),
    title: '对话框',
  ));
}

class DialogTest extends StatelessWidget {
  const DialogTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('对话框'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              // * 常用的 Dialog
              bool? alertDialog = await showAlertDialog(context);
              if (alertDialog == null) {
                print('取消删除 ${alertDialog}');
              } else {
                print('已确认删除 ${alertDialog}');
              }
            },
            child: const Text('AlertDialog'),
          ),
          ElevatedButton(
            onPressed: () async {
              // * 可选项的一个弹窗
              await showSimpleDialog(context);
            },
            child: const Text('SimpleDialog'),
          ),
        ],
      ),
    );
  }

  // * 该方法返回一个 Future, 它正是用于接收对话框的返回值.
  Future<bool?> showAlertDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('提示'), // 标题
          content: const Text('您确定要删除当前文件吗?'), // 内容
          // 操作按钮组
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // 关闭对话框
              child: const Text('删除'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showSimpleDialog(BuildContext context) async {
    int i = await showDialog(
      context: context,
      builder: (BuildContext context) {
        // * 展示一个列表，用于列表选择的场景
        return SimpleDialog(
          title: const Text('请选择语言'),
          children: <Widget>[
            // * 列表选项
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 1); // 返回1
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('中文简体'),
              ),
            ),
            // * 列表选项
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 2); // 返回2
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('美国英语'),
              ),
            )
          ],
        );
      },
    );

    print('选择了：${i == 1 ? "中文简体" : "美国英语"}');
  }
}
