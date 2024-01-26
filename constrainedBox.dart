import 'package:flutter/material.dart';

// ! 布局组件-布局原理与约束
// * 布局模型: 盒模型布局和按需加载列表布局.
// * 布局流程:
// 1.上层组件向下层组件传递约束条件.
// 2.下层组件确定自己的大小, 然后告诉上层组件. 注意下层组件的大小必须符合父组件的约束.
// 3.上层组件确定下层组件相对于自身的偏移和确定自身的大小.
// 例: 父组件传递给子组件的约束是"最大宽高不能超过100，最小宽高为0", 如果我们给子组件设置宽高都为200, 则子组件最终的大小是 100*100.

void main() {
  runApp(HomeWidget());
}

// ignore: must_be_immutable
class HomeWidget extends StatelessWidget {
  HomeWidget({super.key});

  // 定义一个背景颜色为红色的盒子.
  Widget redBox =
      const DecoratedBox(decoration: BoxDecoration(color: Colors.red));
  Widget orangeBox =
      const DecoratedBox(decoration: BoxDecoration(color: Colors.orange));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '布局组件-布局原理与约束',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('布局组件-布局原理与约束'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        // todo 实现一个最小高度为50, 宽度尽可能大的红色容器.
        // * ConstrainedBox: 用于对子组件添加额外的约束.
        body: ConstrainedBox(
            // * BoxConstraints: 盒模型布局中父渲染对象传递给子渲染对象的约束信息.
            constraints: const BoxConstraints(
              maxWidth: 500, // 宽度无限大
              minWidth: 100,
              minHeight: 100, // 最小高度为 50 像素
              maxHeight: 500,
            ),
            child:
                // * SizedBox用于给子元素指定固定的宽高.
                //     SizedBox(
                //   width: 40,
                //   height: 40,
                //   child: redBox,
                // ),

                // * 多重限制: 取父子中相应数值较大的.
                ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 150, minWidth: 150),
              child: orangeBox,
            )),
      ),
    );
  }
}
