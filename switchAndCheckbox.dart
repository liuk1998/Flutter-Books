import 'package:flutter/material.dart';

// ! 基础组件-单选开关和复选框

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SwitchAndCheckBox(),
      title: '基础组件-单选开关和复选框',
    );
  }
}

class SwitchAndCheckBox extends StatefulWidget {
  const SwitchAndCheckBox({super.key});

  @override
  State<SwitchAndCheckBox> createState() => _SwitchAndCheckBoxState();
}

class _SwitchAndCheckBoxState extends State<SwitchAndCheckBox> {
  bool _switchSelected = true; // ? 单选开关
  bool _checkboxSelected = true; // ? 复选开关

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('基础组件-单选开关和复选框'),
        ),
        body: Column(
          children: <Widget>[
            // * 单选开关
            Switch(
                value: _switchSelected,
                onChanged: (value) {
                  setState(() {
                    _switchSelected = value;
                  });
                }),
            // * 复选框
            Checkbox(
                value: _checkboxSelected,
                onChanged: (value) {
                  setState(() {
                    _checkboxSelected = value as bool;
                  });
                },
                activeColor: Colors.red)
          ],
        ));
  }
}
