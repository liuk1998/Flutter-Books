### 1.技术特点

```
1.跨平台自绘引擎: 使用自己的高性能渲染引擎来绘制 Widget(组件), 不仅可以保证在 Android 和 iOS 上 UI 的一致性, 也可以避免对原生控件依赖而带来的限制及高昂的维护成本.
2.采用Dart语言开发.
3.高性能.
```

### 2.为什么采用 Dart 语言开发而不是 JavaScript 或者其他语言?

```
程序主要有两种运行方式：静态编译(AOT)与动态解释(JIT).
AOT 的程序在执行前程序会被提前编译为机器码. 举例: C/C++
JIT 在运行时将源码实时翻译为机器码来执行. 举例: JavaScript、python等

原因:
1.开发效率高: Flutter 在开发阶段采用 JIT 模式, 在发布时可以通过 AOT 生成高效的机器码以保证应用性能.
2.高性能.
3.快速内存分配.
4.类型安全和空安全: Dart 支持静态类型检测, 可以在编译前发现一些类型的错误. JavaScript 是一个弱类型语言.
```

### 3.框架结构

```
![](./img/img1.png)
三层：框架层、引擎层和嵌入层.

框架层: 纯 Dart实现的 SDK, 它实现了一套基础库.
1.底下两层(Foundation 和 Animation、Painting、Gestures), 底层UI库, 提供动画、手势及绘制能力.
2.Rendering 层(渲染层), 依赖于 Dart UI 层, 渲染层会构建一棵由可渲染对象组成的渲染树, 当动态更新这些对象时, 渲染树会找出变化的部分, 然后更新渲染.
3.Widgets 层(基础组件库).
4.Material 和 Cupertino 层(两种视觉风格的组件库).
```
