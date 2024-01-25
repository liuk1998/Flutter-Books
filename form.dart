import 'package:flutter/material.dart';

// ! 基础组件-表单

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FormWidget(),
      title: '基础组件-表单',
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormState();
}

class _FormState extends State<FormWidget> {
  // * 编辑框的控制器. 通过它可以设置/获取编辑框的内容、选择编辑内容、监听编辑文本改变事件.
  final _unameController = TextEditingController();
  final _pwdController = TextEditingController();

  // * FormState 为 Form 的 State 类, 可以通过它来对 Form 的子孙 FormField 进行统一操作. 通过 Form.of() 或 GlobalKey 获得.
  // 1.FormState.validate(): 校验表单. 会调用 Form 子孙 FormField 的 validate 回调.
  // 2.FormState.save(): 保存表单. 会调用 Form 子孙 FormField 的 save 回调.
  // 1.FormState.reset(): 清空表单. 将子孙 FormField 的内容清空.
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('基础组件-表单'),
        ),
        body: Form(
            key: _formKey, // todo 设置 globalKey, 用于后面获取 FormState.
            // todo 表单何时自动进行验证: always(发生变化立即验证) / onUserInteraction(当与表单字段进行交互时验证) / disabled(不进行自动验证)
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: <Widget>[
                TextFormField(
                  autofocus: true, // 自动获取焦点
                  controller: _unameController, // 设置控制器
                  // 输入框的外观显示
                  decoration: const InputDecoration(
                      labelText: '用户名', // title
                      hintText: '用户名或邮箱', // placeholder
                      prefixIcon: Icon(Icons.person)), // 头部图标
                  // todo 校验
                  validator: (v) {
                    // 判断是否为空字符串.
                    return v!.trim().isNotEmpty ? null : '用户名不能为空';
                  },
                ),
                TextFormField(
                  controller: _pwdController,
                  decoration: const InputDecoration(
                      labelText: '密码',
                      hintText: '您的登录密码',
                      prefixIcon: Icon(Icons.lock)),
                  obscureText: true, // 控制文本框内输入的内容是否被遮蔽
                  validator: (v) {
                    return v!.trim().length > 5 ? null : '密码不能少于6位';
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('登录'),
                          ),
                          onPressed: () {
                            // * 通过 _formKey.currentState 获取 FormState 后, 调用 validate() 方法校验用户名密码是否合法.
                            if ((_formKey.currentState as FormState).validate()) {
                              print('验证通过');
                            }
                          },
                        )
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
