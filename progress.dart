import 'package:flutter/material.dart';

// ! 基础组件-进度指示器

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FormWidget(),
      title: '基础组件-进度指示器',
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormState();
}

class _FormState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('基础组件-进度指示器'),
        ),
        body: Column(
          children: <Widget>[
            // * 进度指示器(线性、条状的进度条)
            LinearProgressIndicator(
              backgroundColor: Colors.grey[200], // 背景
              valueColor: const AlwaysStoppedAnimation(Colors.green), // 进度条颜色
            ),
            LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation(Colors.red),
              // 当前的进度, 取值范围为[0,1], 为 null 时则指示器会执行一个循环动画(模糊进度), 不为null时, 指示器为一个具体进度的进度条.
              value: .5,
            ),
            // * 进度指示器(圆形进度条)
            CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation(Colors.orange),
            ),
            // ! 大小取自父容器的尺寸
            SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                value: .5,
              ),
            )
          ],
        ));
  }
}
