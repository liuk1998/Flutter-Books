import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ! 功能型组件-对话框状态管理

void main() {
  runApp(const MaterialApp(
    home: DialogTest(),
    title: '对话框',
  ));
}

// * 在用户选择了文件夹时避免二次弹窗确认是否删除子目录, 我们在确认对话框底部添加一个"同时删除子目录?"的复选框.

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
          ElevatedButton(
            onPressed: () async {
              // * 底部菜单列表
              int? type = await showModalBottom(context);
              print(type);
            },
            child: const Text('ModalBottomSheet'),
          ),
          ElevatedButton(
            onPressed: () async {
              // * Loading
              await showLoadingDialog(context);
            },
            child: const Text('LoadingDialog'),
          ),
          ElevatedButton(
            onPressed: () async {
              // * 日历选择器(安卓)
              await showDatePicker1(context);
            },
            child: const Text('DatePicker1'),
          ),
          ElevatedButton(
            onPressed: () async {
              // * 日历选择器(苹果)
              await showDatePicker2(context);
            },
            child: const Text('DatePicker2'),
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
        // * 展示一个列表, 用于列表选择的场景
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

  // * 底部菜单列表
  Future<int?> showModalBottom(BuildContext context) {
    return showModalBottomSheet<int>(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('$index'),
                onTap: () => Navigator.of(context).pop(index),
              );
            },
          );
        });
  }

  // * Loading框
  showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // 点击遮罩不关闭对话框
      builder: (context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(top: 26),
                child: Text('正在加载, 请稍后...'),
              )
            ],
          ),
        );
      },
    );
  }

  // * 日历选择器(安卓)
  Future<DateTime?> showDatePicker1(BuildContext context) {
    var date = DateTime.now();
    return showDatePicker(
      context: context,
      firstDate: date,
      initialDate: date,
      // 未来30天可选
      lastDate: date.add(
        const Duration(days: 30),
      ),
    );
  }

  // * 日历选择器(苹果)
  Future<DateTime?> showDatePicker2(BuildContext context) {
    var date = DateTime.now();
    return showCupertinoDialog(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(Duration(days: 30)),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              print(value);
            },
          ),
        );
      },
    );
  }
}
