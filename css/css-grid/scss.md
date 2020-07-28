

# [SCSS简明上手指南](https://uinika.github.io/web/broswer/scss.html)
Sass是成熟、稳定、强大的CSS预处理器,SCSS是Sass3版本当中引入的新语法特性，完全兼容CSS3的同时继承了Sass强大的动态功能。
新项目全部基于Webpack的node-sass和sass-loader作为预处理工具。

npm install -g sass
sass source/stylesheets/index.scss build/stylesheets/index.css

## 编码规则
文件头部添加 `@charset 'utf-8';`

## 变量 $name
```
$font-stack:    Helvetica, sans-serif;
$primary-color: #333;

body {
  font: 100% $font-stack;
  color: $primary-color;
}
```
上面例子中变量$font-stack和$primary-color的值将会替换所有引用他们的位置。

## 嵌套
不要过度嵌套让产生的CSS难以维护
```
nav {
  ul {
    margin: 0;
    padding: 0;
    list-style: none;
  }

  li { display: inline-block; }

  a {
    display: block;
    padding: 6px 12px;
    text-decoration: none;
  }
}
```

## @import
CSS原生的@import会通过额外的HTTP请求获取引入的样式片段，而SASS的@import则会直接将这些引入的片段合并至当前CSS文件，并且不会产生新的HTTP请求。
```
// _reset.scss SASS片断使用下划线前缀命名
html, body, ul, ol {
  margin:  0;
  padding: 0;
}

// base.scss
@import 'reset';
body {
  font: 100% Helvetica, sans-serif;
  background-color: #efefef;
}
```
导入的文件将合并、编译到一个CSS文件，文件中的变量和mixin都可以在导入的主文件当中使用
ASS会基于当前目录查找其它文件，可以通过:load_paths或--load-path选项指定额外的搜索目录。
@import 'base', 'reset', 'app'; 同时导入多个文件




## @minxin
@minxin 用来分组那些需要在页面中复用的CSS声明,接收变量参数
```
@mixin border-radius($radius) {
          border-radius: $radius;
      -ms-border-radius: $radius;
     -moz-border-radius: $radius;
  -webkit-border-radius: $radius;
}

.box {
  @include border-radius(10px);
}

.box {
  border-radius: 10px;
  -ms-border-radius: 10px;
  -moz-border-radius: 10px;
  -webkit-border-radius: 10px; 
}
```

## 继承
通过@extend指令在选择器之间复用CSS属性，
```
%message-common {
  border: 1px solid #ccc;
  padding: 10px;
  color: #333;
}

.message {
  @extend %message-common;
}

.success {
  @extend %message-common;
  border-color: green;
}

.error {
  @extend %message-common;
  border-color: red;
}

.warning {
  @extend %message-common;
  border-color: yellow;
}

生成
.message, .success, .error, .warning {
  border: 1px solid #ccc;
  padding: 10px;
  color: #333; 
}

.success {
  border-color: green;
}

```

## 操作符
算术运算符，例如+、-、*、/、%
```
.container { width: 100%; }

article[role="main"] {
  float: left;
  width: 600px / 960px * 100%;
}
更容易的将像素值转换为百分比
```

## 引用父级选择器&
```
a {
  font-weight: bold;
  text-decoration: none;
  &:hover { text-decoration: underline; }
  body.firefox & { font-weight: normal; }//  body.firefox a {}
}
```
无论CSS规则嵌套的深度怎样，关键字&都会使用父级选择器级联替换全部其出现的位置

## 嵌套属性
CSS许多属性都位于相同的命名空间（例如font-family、font-size、font-weight都位于font命名空间下），Scss当中只需要编写命名空间一次，后续嵌套的子属性都将会位于该命名空间之下
```
.demo {
  font: {   // 命令空间后带有冒号:
    family: fantasy;
    size: 30em;
    weight: bold;
  }
}
```

## 占位符选择器%
占位符选择器与id或者class选择器的用法类似，只是#和.需要替换成为%，占位符选择器必须通过@extend指令进行调用。

## 注释
多行注释会完整输出到编译后的CSS文件，而单行注释则不会
插值语句#{$variable}可以应用在多行注释当中。
$version: "3.5.5";
/* 这段CSS是通过SASS #{$version}生成的。*/
/* 这段CSS是通过SASS 3.5.5生成的。*/




