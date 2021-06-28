# webpack》

```
mkdir webpack-demo
cd webpack-demo
npm init -y
npm install webpack webpack-cli --save-dev

package.json
-  "main": "index.js",
+ "private": true,
防止意外发布你的代码

创建目录
tldr tree
  - Print the tree ignoring the given directories:
    tree -I 'directory_name1|directory_name2'
$ tree -I 'node_modules'
.
├── dist
│   ├── index.html
│   ├── main.js
│   └── main.js.LICENSE.txt
├── package-lock.json
├── package.json
└── src
    └── index.js
```

```
npm install --save lodash

# index.js
import _ from 'lodash'
function component(){
    var elm = document.createElement('div')
    elm.innerHTML=_.join(['hello','lodash'],'s')
    return elm
}
document.body.appendChild(component())
```

> 执行 `npx webpack`，会将我们的脚本 `src/index.js` 作为 [入口起点](https://webpack.docschina.org/concepts/entry-points)，也会生成 `dist/main.js` 作为 [输出](https://webpack.docschina.org/concepts/output)。Node 8.2/npm 5.2.0 以上版本提供的 `npx` 命令，可以运行在初次安装的 webpack package 中的 webpack 二进制文件（即 `./node_modules/.bin/webpack`）

```
npx webpack
open dist/index.html
```

使用配置文件实现复杂配置

webpack.config.js

```
const path =require('path')
module.exports={
    entry:"./src/index.js",
    output:{
        filename:'main.js',
        path:path.resolve(__dirname,'dist')
    }
}
```

```
$ npx webpack --config webpack.config.js  //默认配置文件名称
```

修改package.json 

```
"scripts":{
    "build": "webpack"
}
npm run build 
```

# 管理资源

> webpack 除了引入 JavaScript，还可以通过 loader 或内置的 [Asset Modules](https://webpack.docschina.org/guides/asset-modules/) *引入任何其他类型的文件*。

```
import './style.css';
element.classList.add('hello');
```

能够按需处理依赖的资源，没有使用到的css文件会被优化掉

如果不安装css处理模块，直接在index.js中 import style.css，编译报错,js无法识别css语法，因此需要预处理

>ERROR in ./src/style.css 1:0
>Module parse failed: Unexpected token (1:0)
>You may need an appropriate loader to handle this file type, currently no loaders are configured to process this file. See https://webpack.js.org/concepts#loaders
>.hello{
>|     color:red
>| }s

```bash
npm install --save-dev style-loader css-loader
```

```bash
npm install --save-dev csv-loader xml-loader
```

`import Data from './data.json'` 能够正常运行不需要预处理，适合d3等静态数据图形渲染。

```bash
npm install toml yamljs json5 --save-dev
```

json5支持注释的json格式

```
      {
        test: /\.json5$/i,
        type: 'json',
        parser: {
          parse: json5.parse,
        },
      },
```

```
import json from './data.json5';
console.log(json.title); // output `JSON5 Example`
console.log(json.owner.name); // output `Tom Preston-Werner`
```

以这种方式加载资源，你可以以更直观的方式将模块和资源组合在一起。

```
 |- /assets
 |– /components
 |  |– /my-component
 |  |  |– index.jsx
 |  |  |– index.css
 |  |  |– icon.svg
 |  |  |– img.png
```

这种配置方式会使你的代码更具备可移植性，

安装 vscode path intelligent 插件

# 管理输出

**src/print.js**

```js
export default function printMe() {
  console.log('I get called from print.js!');
}
```

**rc/index.js**

```diff
 import _ from 'lodash';
+import printMe from './print.js';
```

动态构建index.html

```bash
npm install --save-dev html-webpack-plugin
```

```diff
  plugins: [
+    new HtmlWebpackPlugin({
+      title: '管理输出',
+    }),
+  ],
```

每次构建前清理 `/dist` 文件夹，这样只会生成用到的文件。让我们使用 [`output.clean`](https://webpack.docschina.org/configuration/output/#outputclean) 配置项实现这个需求。

```diff
   output: {
     filename: '[name].bundle.js',
     path: path.resolve(__dirname, 'dist'),
+    clean: true,
   },
```

# 开发环境

```diff
 module.exports = {
+  mode: 'development',
```

**source map**

> 当 webpack 打包源代码时，可能会很难追踪到 error(错误) 和 warning(警告) 在源代码中的原始位置。例如，如果将三个源文件（`a.js`, `b.js` 和 `c.js`）打包到一个 bundle（`bundle.js`）中，而其中一个源文件包含一个错误，那么堆栈跟踪就会直接指向到 `bundle.js`。你可能需要准确地知道错误来自于哪个源文件，所以这种提示这通常不会提供太多帮助。
>
> JavaScript 提供了 [source maps](http://blog.teamtreehouse.com/introduction-source-maps) 功能，可以将编译后的代码映射回原始源代码。如果一个错误来自于 `b.js`，source map 就会明确的告诉你。
>
> 

```diff
  module.exports = {
  	devtool: 'inline-source-map',
```



在每次编译代码时，手动运行 `npm run build` 会显得很麻烦。
webpack 提供几种可选方式，帮助你在代码发生变化后自动编译代码。
多数场景中，你可能需要使用 `webpack-dev-server`

1.  使用 watch mode(观察模式),唯一的缺点是，为了看到修改后的实际效果，你需要刷新浏览器。
2.  `webpack-dev-server` 为你提供了一个简单的 web server，并且具有 live reloading(实时重新加载) 功能。

```bash
npm install --save-dev webpack-dev-server
```

```diff
   devtool: 'inline-source-map',
+  devServer: {
+    contentBase: './dist',
+  },
```

8080端口，

> webpack-dev-server 在编译之后不会写入到任何输出文件。而是将 bundle 文件保留在内存中，然后将它们 serve 到 server 中，就好像它们是挂载在 server 根路径上的真实文件一样。如果你的页面希望在其他不同路径中找到 bundle 文件，则可以通过 dev server 配置中的 [`publicPath`](https://webpack.docschina.org/configuration/dev-server/#devserverpublicpath-) 选项进行修改。

```diff
package.json
    "start": "webpack serve --open",
```

使用自动编译代码时，可能会在保存文件时遇到一些问题。某些编辑器具有 "safe write(安全写入)" 功能，会影响重新编译。vscode 关闭自动保存功能？

# 代码分离

> 代码分离是 webpack 中最引人注目的特性之一。此特性能够把代码分离到不同的 bundle 中，然后可以按需加载或并行加载这些文件。代码分离可以用于获取更小的 bundle，以及控制资源加载优先级，如果使用合理，会极大影响加载时间。

常用的代码分离方法有三种：

- **入口起点**：使用 [`entry`](https://webpack.docschina.org/configuration/entry-context) 配置手动地分离代码。
- **防止重复**：使用 [Entry dependencies](https://webpack.docschina.org/configuration/entry-context/#dependencies) 或者 [`SplitChunksPlugin`](https://webpack.docschina.org/plugins/split-chunks-plugin) 去重和分离 chunk。
- **动态导入**：通过模块的内联函数调用来分离代码。

### 入口起点

```diff
  entry: {
+    index: './src/index.js',
+    another: './src/another-module.js',
+  },
```

这种方式存在一些隐患：

- 如果入口 chunk 之间包含一些重复的模块，那些重复模块都会被引入到各个 bundle 中。

  两个入口js文件都引入了lodash，那么lodash会被打包两次到各个bundle中

- 这种方法不够灵活，并且不能动态地将核心应用程序逻辑中的代码拆分出来。



### 防止重复(prevent duplication)

[`SplitChunksPlugin`](https://webpack.docschina.org/plugins/split-chunks-plugin) 插件可以将公共的依赖模块提取到已有的入口 chunk 中，或者提取到一个新生成的 chunk

```diff
   optimization: {
+     splitChunks: {
+       chunks: 'all',
+     },
+   },
```

- [`mini-css-extract-plugin`](https://webpack.docschina.org/guides/code-splitting/plugins/mini-css-extract-plugin): 用于将 CSS 从主应用程序中分离。

## prefetch/preload module

在声明 import 时，使用下面这些内置指令，可以让 webpack 输出 "resource hint(资源提示)"，来告知浏览器：

- **prefetch**(预获取)：将来某些导航下可能需要的资源
- **preload**(预加载)：当前导航下可能需要资源

**LoginButton.js**

```js
//...
import(/* webpackPrefetch: true */ './path/to/LoginModal.js');
```

这会生成 `<link rel="prefetch" href="login-modal-chunk.js">` 并追加到页面头部，指示着浏览器在闲置时间预取 `login-modal-chunk.js` 文件。

- preload chunk 会在父 chunk 加载时，以并行方式开始加载，用于当下。prefetch chunk 会在父 chunk 加载结束后开始加载，用于将来某个时刻。
- preload chunk 具有中等优先级，并立即下载。prefetch chunk 在浏览器闲置时下载。

示例：

图表组件 `ChartComponent` 组件需要依赖一个体积巨大的 `ChartingLibrary` 库。它会在渲染时显示一个 `LoadingIndicator(加载进度条)` 组件，然后立即按需导入 `ChartingLibrary`：

```js
import(/* webpackPreload: true */ 'ChartingLibrary');
```

不正确地使用 `webpackPreload` 会有损性能，请谨慎使用。



## bundle 分析(bundle analysis)



 













