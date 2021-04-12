#  less

### It's CSS, with just a little more.

Less (which stands for Leaner Style Sheets) is a backwards-compatible language extension for CSS. 

```less
//Variables
@width: 10px;
@height: @width + 10px;

#header {
  width: @width;
  height: @height;
}

//Mixins
.bordered {
  border-top: dotted 1px black;
  border-bottom: solid 2px black;
}
#menu a {
  color: #111;
  .bordered();
}

.post a {
  color: red;
  .bordered();
}

//Nesting
#header {
  color: black;
  .navigation {
    font-size: 12px;
  }
  .logo {
    width: 300px;
  }
}

.clearfix {
  display: block;
  zoom: 1;

  &:after {
    content: " ";
    display: block;
    font-size: 0;
    height: 0;
    clear: both;
    visibility: hidden;
  }
}
```

## Operations

`+`, `-`, `*`, `/` can operate on any number, color or variable.

For CSS compatibility, `calc()` does not evaluate math expressions, but will evaluate variables and math in nested functions.

```
@var: 50vh/2;
width: calc(50% + (@var - 20px));  // result is calc(50% + (25vh - 20px))
```

```
@min768: (min-width: 768px);
.element {
  @media @min768 {
    font-size: 1.2rem;
  }
}

@media (min-width: 768px) {
  .element {
    font-size: 1.2rem;
  }
}
```

## Functions

```
@base: #f04615;
@width: 0.5;

.class {
  width: percentage(@width); // returns `50%`
  color: saturate(@base, 5%);
  background-color: spin(lighten(@base, 25%), 8);
}
```

##  Namespaces and Accessors

```
#bundle() {
  .button {
    display: block;
    border: 1px solid black;
    background-color: grey;
    &:hover {
      background-color: white;
    }
  }
  .tab { ... }
  .citation { ... }
}

#header a {
  color: orange;
  #bundle.button();  // can also be written as #bundle > .button
}
```

## Maps

```
#colors() {
  primary: blue;
  secondary: green;
}

.button {
  color: #colors[primary];
  border: 1px solid #colors[secondary];
}
```

## Scope

```
@var: red;

#page {
  @var: white;
  #header {
    color: @var; // white
  }
}
```

## Comments

```
/* One heck of a block
 * style comment! */
@var: red;

// Get in line!
@var: white;
```

## Importing

You can import a `.less` file, and all the variables in it will be available. The extension is optionally specified for `.less` files.

```
@import "library"; // library.less
@import "typo.css";
```

# A Complete Guide to Grid

CSS Grid Layout (aka “Grid”), is a two-dimensional grid-based layout system .
Flexbox,is for simpler one-dimensional layouts.
Flexbox and Grid actually work very well together.
 Grid is the very first CSS module created specifically to solve the layout problems we’ve all been hacking our way around for as long as we’ve been making websites.

参考资料： [*Get Ready for CSS Grid Layout*.](https://abookapart.com/products/get-ready-for-css-grid-layout)    [“A Complete Guide to Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)

You’ll notice many similarities between his post and mine, because why not steal from the best?

> Grid Track 两条行线 或两条列线之间的区域，可以看作是某行或某列

#### Properties for the Grid container

```
display
grid-template-columns
grid-template-rows
grid-template-areas
grid-template:  A shorthand for setting grid-template-rows, grid-template-columns, and grid-template-areas in a single declaration.

column-gap: <line-size>;
row-gap: <line-size>
gap: <grid-row-gap> <grid-column-gap>;
justify-items
align-items
place-items: sets both the align-items and justify-items properties in a single declaration.
```

 

```css
.container {
  grid-template-columns: repeat(3, 20px [col-start]);
}
.container {
  grid-template-columns: 1fr 1fr 1fr; //三等分
}
  grid-template-columns: 1fr 50px 1fr 1fr;
```

The `fr` unit allows you to set the size of a track as a fraction of the free space of the grid container. 
//剩余空间fr等分

```css
.container {
  display: grid;
  grid-template-columns: 50px 50px 50px 50px;
  grid-template-rows: auto;
  grid-template-areas: 
    "header header header header"
    "main main . sidebar"
    "footer footer footer footer";
}
```

<img src="https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/04/0120210401201554.svg" alt="Example of grid-template-areas" style="zoom: 25%;" />

Since `grid-template` doesn’t reset the *implicit* grid properties (`grid-auto-columns`, `grid-auto-rows`, and `grid-auto-flow`), which is probably what you want to do in most cases, it’s recommended to use the `grid` property instead of `grid-template`.

```
.container {
  grid-template-columns: 100px 50px 100px;
  grid-template-rows: 80px auto 80px; 
  gap: 15px 10px; //If no row-gap is specified, it’s set to the same value as column-gap
}
```

**justify-items**
子元素默认拉伸占满横向空间，内容占不满空间时可以靠左靠右居中排列。
同理，竖向排列 align-items:stretch默认铺满，start end center

```
start – aligns items to be flush with the start edge of their cell
end – aligns items to be flush with the end edge of their cell
center – aligns items in the center of their cell
stretch – fills the whole width of the cell (this is the default)
```

##### justify-content







#### Propertis for Grid item

```css
.item {
  grid-column-start: col-start 2;
}	
```

 







# css 属性



## background-image

 are drawn on stacking context layers on top of each other. The first layer specified is drawn as if it is closest to the user.

## [sticky](http://www.ruanyifeng.com/blog/2019/11/css-position.html)

static是position属性的默认值。如果省略position属性，浏览器就认为该元素是static定位。
这时，浏览器会按照源码的顺序，决定每个元素的位置，这称为"正常的页面流"（normal flow）。每个块级元素占据自己的区块（block），元素与元素之间不产生重叠，这个位置就是元素的默认位置。
- relative、absolute、fixed这三个属性值有一个共同点，都是相对于某个基点的定位，不同之处仅仅在于基点不同.
- relative表示，相对于默认位置（即static时的位置）进行偏移，即定位基点是元素的默认位置。
- absolute表示，相对于上级元素（一般是父元素）进行偏移，即定位基点是父元素。它有一个重要的限制条件：定位基点（一般是父元素）不能是static定位，否则定位基点就会变成整个网页的根元素html。
- fixed表示，相对于视口（viewport，浏览器窗口）进行偏移，即定位基点是浏览器窗口。这会导致元素的位置不随页面滚动而变化，好像固定在网页上一样。
- sticky
，网页的搜索工具栏，初始加载时在自己的默认位置（relative定位）。页面向下滚动时，工具栏变成固定位置，始终停留在页面头部（fixed定位）。
```
#toolbar {
  position: -webkit-sticky; /* safari 浏览器 */
  position: sticky; /* 其他浏览器 */
  top: 20px;
}
```
页面向下滚动时，#toolbar的父元素开始脱离视口，一旦视口的顶部与#toolbar的距离小于20px（门槛值），#toolbar就自动变为fixed定位，保持与视口顶部20px的距离。页面继续向下滚动，父元素彻底离开视口（即整个父元素完全不可见），#toolbar恢复成relative定位。

表格的表头锁定
```
th {
  position: sticky;
  top: 0; 
}
不能设在<thead>和<tr>元素，因为这两个元素没有relative定位，也就无法产生sticky效果。
```

# 《CSS世界》

# 术语
功能符 rgba() hsla() url('.png') attr('href') scale(-1)
长度单位：相对字体长度单位 em ex rem ch(字符0的宽度)、相对视区长度单位vh vw vmin vmax。绝对单位px
变量 currentColor

##  选择器
#id 
.class 
属性选择器
```
[title]{}
[title='abc']{}
[title~='abc']{} 
[title^='abc']{}
[title$='abc']{}
```
伪类选择器 
```
:first-child
:last-child
```
伪元素选择器
```
::first-line
::first-letter
::before
::after
```
关系选择器
```
空格 后代选择器
>  相邻后代选择器
~ 兄弟选择器 ，后面的所有兄弟元素
+ 相邻兄弟选择器，相邻的那个兄弟元素
```

# 第三章 流、元素、基本尺寸
块级元素：一个水平流上只能单独显示一个元素，多个块级元素则换行显示。dispaly:block| list-item | table
```
.clear:after{
  content:'',
  display:block;
  //换行+clear 清除浮动
  clear:both;
}
```
## list-item 为什么有项目符号
生成了一个附加盒子 用来放项目符号

inline-block 
每个元素都有两个盒子：外在盒子(是否换行)、内在盒子|内容盒子|容器盒子(定义内容宽高显示效果)

## width 默认值 auto
1、充分利用可用空间，div p 默认100%于父容器  
2、包裹性
宽度由内容决定
浮动、绝对定位、inline-block 、table 
3、收缩到最小
 table-layout:auto;宽度不够时，一个文字一行

4、超出容器限制
 white-space:nowrap;

内部尺寸：尺寸由内部元素决定 包裹性
外部尺寸：尺寸由父级容器决定 ，如div、p。如水流自动铺满容器，表现为外部尺寸的块级元素一旦设置了宽度就丢失了流动性。
流动性：并不是看上去的100%这么简单，而是margin/border/padding/content的内容区域自动分配水平空间的机制。

格式化宽度
绝对定位(absolute、fixed)元素默认表现为 包裹性，宽度由内部尺寸决定，但是当 left/right 或 top/bottom对立方位的属性值同事存在时元素表现为 格式化宽度 或 格式化高度，宽度或高度 由外部尺寸(不是static定位的祖先元素)决定。


利用包裹性实现 一行文字居中显示 多行文字靠左显示
```
.box{
  text-align:center;
}
.content{
  display:inline-block;
  text-align:left;
}
```


## 内在盒子：content-box ,padding-box, border-box ,margin-box
margin的背景透明不可能作为background-origin background-clip 属性值出现，margin数值不会影响本身尺寸，所以不存在 border-box:margin-box;

css定义 content-box环绕着width和height给定的钜形。width作用在content-box上。
盒尺寸中的4个盒子都影响宽度，不方便确定布局，因此>>

## css流体布局 宽度分离原则
父元素定宽，子元素宽度auto
```
.father:{
  width:180px;
}
.child{
  margin
  padding
  border
}
```

## box-sizing
box-sizing:border-box 实现替换元素 input textarea 100%自适应于父容器宽度
替换元素的尺寸由内部元素决定，无论display：inline还是block;

textarea{
  display:block; //不受影响，无法100%于父元素
  width:100%;//只能通过width实现 100%于父元素
  //开始光标顶在边框 体验差，padding + border + boder-box 美化避免超出
  box-sizing:border-box;
  padding:5px;
  border:1px solid blue;
}


## height:auto 
css流默认水平方向，宽度是稀缺的，高度是无限的

## height:100%
width即便父级是auto也是支持百分比的

父元素是height:auto,只要子元素还在文档流中，在height百分比值被忽略。想要子元素高度百分比生效，则父元素必须有一个有效高度值。


浏览器渲染原理：
下载文档，加载头部样式文件，从上到下，自外而内 渲染DOM内容。
先渲染父元素再渲染子元素，父元素宽度auto则表现为图文内容的宽度，宽度固定为真实宽度数值，再渲染子元素宽度百分比有效。
css定义：包含块的高度没有显示指定，即高度由内容决定，且该元素不是绝对定位，则计算值为auto。包含块的宽度取决于该元素的宽度那么产生的布局在css中是未定义的，所有浏览器表现为 包含块的真实宽度计算值。
子元素高度百分比同auto无法计算，'auto'*100% = NaN 不生效。

html,body{
  height:100%;
}

div{
  position:absolute;
  height:100%;
}
##  绝对定位 padding-box
绝对定位的宽高百分比是相对于padding-box的，非绝对定位元素是相对于content-box计算的

## min-width max-width
```
.container{
  min-width:1200px;
  max-width:1400px;
}

避免移动端图片过大
img{
  max-width:100%:
  height:auto !important; //auto 保持宽高比
}
```

### min-width min-height 初始值 auto
```
<body style='min-width:auto;'>
document.body.style.minWidth;//输出 auto，则min-width:auto 有效



.box{
  transition: min-height .3s;
}
.box:hover{
  min-height:300px;
}
此动画突然增高 是因为min-height默认值auto 无法参与计算
```

### max-width max-height 初始值 none
假如 子元素的max-width默认值为auto 则表现为父元素的宽度，max-width会覆盖width，子元素永远不能比父元素宽，显然不合理，所以初始值none

min-width/max-width min-height/max-height
超越 !important , 超越最大
max-width 权重比 !important还大;
min-width 大于 max-width ，选取较大的那个数值。

### 任意高度元素的展开收起动画
```
.element{
  max-height:0;
  overflow:hidden;
  transition:max-height:.25s;
}
.element.active{
  max-height:666px;//足够安全的最小值，优化动画体验
}
```

## 内联元素
允许多个元素在一行，比如 
```
<button> 默认 display:inline-block
<img> 默认 display:inline
````
浮动元素在文档流之外，例如文字段落包围图片，文字并不在浮动元素的下面，而是在后面，不是在一行。

## 内联盒模型
```
<p>只是一段普通的文字，这里有个<em>em</em>标签.
lorem
lorem
</p>
```
内容区域：围绕文字看不见的盒子，仅受字符本身特性控制，表现为 文本选中的背景色。
内联盒子： `<span> <a> <em>`等内联标签 可以在同一行显示。 内联匿名盒子 "标签"
行框盒子：每一行就是一个“行框盒子” 如“只是...标签.”,由一个个 内联盒子 组成
包围盒子 `<p></p>` 由一行一行的行框盒子组成


## H5文档声明下的 幽灵空白节点
```
    <div style="background-color: #ccc;">
        <span style="display: inline-block;"></span>
    </div>
```
span没有任何内容，为何还有一个18px的灰色条？
> Each line box starts with a zero-width inline box width the element's font and line properties.We call that imaginary box a 'strut'.支柱



# 第四章 盒尺寸4大家族

## content与替换元素
替换元素：通过修改元素某个属性值呈现的内容就可以被替换的元素 ，如`<img> <object> <video> <iframe> <input> <textarea> <select>`

替换元素的display属性不影响元素的尺寸计算。
替换元素由默认尺寸。如`<input />`显示的默认尺寸。
替换元素的样式表现在css作用域外，如`input[type='check-box']{}`无法改变间距、背景色等。除了浏览器暴露的属性`-ms-check{}`

尺寸计算规则
1. 固有尺寸｜不加修饰的默认尺寸，如 图片视频自身的尺寸，input的默认尺寸 ,`<vedio></vedio>默认300高150宽`。所以 表单元素的font-size/padding/margin都是使用px单位，保持元素的固有尺寸不受外界css的影响。
2. HTML尺寸， HTML原生属性。如`<img width='' height=''> <input type='file' size='30'> <textarea cols='10' rows='5'></textarea`
3. CSS尺寸 
三者类似 蛋>蛋外层白色薄膜>蛋壳，CSS尺寸权重 > HTML尺寸>固有尺寸



### 图片根据宽高比自动计算缺失的高度或宽度
```
<img src='1.jpg'>
img{ width:200px; }
图片资源本身由宽高，css只设置了宽度或高度，则按照图片固有宽高比，计算出对应的高度或宽度。
```

### 首屏之下的图片滚屏时异步加载，
```
img{visibility:hidden;} //占位的标签不写src属性，占据空白 不可见
img[src]{visibility:visible;} 
```

### 无法改变元素的固有尺寸
图片css尺寸能够影响图片显示的宽高，是因为图片默认填充声明是 object-fit:fill. 如果修改为object-fill:none则图片尺寸完全不受控制。

boject-fit:contain ，保持图片比例 显示完整。




# css rest
```
img{display:inline-block;} //firefox <img> 图片占位

```

## padding 
很多人认为设置 box-sizing:border-box 元素的尺寸就不会再变化了。大多数情况适用。但是，当padding值足够大，则width无效
```
.box{
  display:block;
  width:80px;
  height:20px 60px;
  box-sizing:border-box;
}
表现为 宽度120px，内容 首选最小宽度
```


## css wiki
## background-size
/* 关键字 */
background-size: cover
background-size: contain

/* 一个值: 这个值指定图片的宽度，图片的高度隐式的为auto */
background-size: 50%
background-size: 3em
background-size: 12px
background-size: auto

/* 两个值 */
/* 第一个值指定图片的宽度，第二个值指定图片的高度 */
background-size: 50% auto
background-size: 3em 25%
background-size: auto 6px
background-size: auto auto

/* 逗号分隔的多个值：设置多重背景 */
background-size: auto, auto     /* 不同于background-size: auto auto */
background-size: 50%, 25%, 25%
background-size: 6px, auto, contain

percentage 值，指定背景图片相对背景区（background positioning area）的百分比。背景区由background-origin设置，默认为盒模型的内容区与内边距，也可设置为只有内容区，或者还包括边框。如果attachment 为fixed，背景区为浏览器可视区（即视口），不包括滚动条。不能为负值。
auto





# [Build Responsive Real World Websites with HTML5 and CSS3》](https://www.udemy.com/course/design-and-develop-a-killer-website-with-html5-and-css3/?utm_campaign=website1010&utm_medium=website1010&utm_source=mycoupon)

## response web design

fluid layout 
media queries 
responsive images
correct unit: font size ,element dimensions   
desktop-first vs mobile-first

### maintainable and scalable code 

clean code 
easy understand 
growth
resuabele
how to organize files 
how to name classes
how to sructure html 

### web performance

faster & smaller
less http request
less code 
compress code 
use a  css preprocessor ,sass
less image
compress images 

 

