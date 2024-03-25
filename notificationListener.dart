import 'package:flutter/material.dart';

// ! 事件处理与通知-通知 Notification: 在 widget 树中, 每一个节点都可以分发通知, 通知会沿着当前节点向上传递, 所有父节点都可以通过 NotificationListener 来监听通知.Flutter 中将这种由子向父的传递通知的机制称为通知冒泡. 通知冒泡和用户触摸事件冒泡是相似的, 但有一点不同: 通知冒泡可以中止, 但用户触摸事件不行.

void main() {
  runApp(const MaterialApp(
    home: NotificationTest(),
    title: '通知 Notification',
  ));
}

// * 自定义通知

// * 定义一个通知类
class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}

class NotificationTest extends StatefulWidget {
  const NotificationTest({super.key});

  @override
  NotificationTestState createState() => NotificationTestState();
}

class NotificationTestState extends State<NotificationTest> {
  String _msg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知 Notification识别'),
      ),
      // 监听通知
      body: NotificationListener<MyNotification>(
        // onNotification 回调为通知处理回调.
        onNotification: (notification) {
          setState(() {
            _msg += notification.msg + '   ';
            print('收到通知, ${_msg}');
          });
          // 返回值类型为布尔值, 当返回值为 true 时, 阻止冒泡, 其父级Widget将再也收不到该通知: 当返回值为 false 时继续向上冒泡通知.
          return true;
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // 通过 Builder 来构建 ElevatedButton, 来获得按钮位置的 context. 不加 Builder 不行, 因为这个 context 是根 Context, 而 NotificationListener 是监听的子树.
              Builder(builder: (context) {
                return ElevatedButton(
                  // 按钮点击时分发通知.
                  // Notification有一个 dispatch(context) 方法, 它是用于分发通知的, context实际上与 Element 树上的节点是对应的, 通知会从 context 对应的 Element 节点向上冒泡.
                  onPressed: () => MyNotification('Hi').dispatch(context),
                  child: const Text('发送通知'),
                );
              }),
              Text(_msg)
            ],
          ),
        ),
      ),
    );
  }
}
