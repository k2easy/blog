


# [CSS Grid 网格布局教程](http://www.ruanyifeng.com/blog/2019/03/grid-layout-tutorial.html)

容器>项目
```
.container {
  display: grid;//inline-grid
  grid-template-columns: 100px 100px 100px;
  grid-template-rows: 100px 100px 100px;
}

grid-template-columns: 33.33% 33.33% 33.33%;
grid-template-columns: repeat(3, 33.33%);
grid-template-columns: repeat(2, 100px 20px 80px)
grid-template-columns: repeat(auto-fill, 100px)

grid-template-columns: 1fr 1fr;
```
- `设为网格布局以后，容器子元素（项目）的float、display: inline-block、display: table-cell、vertical-align和column-*等设置都将失效`

- auto-fill 单元格的大小是固定的，但是容器的大小不确定,希望每一行（或每一列）容纳尽可能多的单元格

- fr关键字（fraction 的缩写，意为"片段"）。如果两列的宽度分别为1fr和2fr，就表示后者是前者的两倍。fr可以与绝对长度的单位结合使用，这时会非常方便。grid-template-columns: 150px 1fr 2fr;第一列的宽度为150像素，第二列的宽度是第三列的一半。

- minmax(min,max)函数产生一个长度范围，表示长度就在这个范围之中。grid-template-columns: 1fr 1fr minmax(100px, 1fr);

- auto由浏览器自己决定长度
 grid-template-columns: 100px auto 100px;
 第二列的宽度，基本上等于该列单元格的最大宽度，除非单元格内容设置了min-width，且这个值大于最大宽度。



```
grid-template-columns: repeat(auto-fill,180px) 该行填充方块，还有剩余宽度(大于180px 小于1个方块宽度)，想要填满使用minmax()
grid-template-columns: repeat(auto-fill, minmax(180px, 1fr))
            
```


 
## 网格线的名称
```
.container {
  display: grid;
  grid-template-columns: [c1] 100px [c2] 100px [c3] auto [c4];
  grid-template-rows: [r1] 100px [r2] 100px [r3] auto [r4];
}
```
使用方括号，指定每一根网格线的名字，方便以后的引用。
网格布局允许同一根线有多个名字，比如[fifth-line row-5]

## grid-gap 
```
.container {
   grid-row-gap: 20px;//行间距 row-gap
   grid-column-gap: 20px; //column-gap
}

gap: <grid-row-gap> <grid-column-gap>;
如果grid-gap省略了第二个值，浏览器认为第二个值等于第一个值。
```
## grid-template-areas
```
.container {
  display: grid;
  grid-template-columns: 100px 100px 100px;
  grid-template-rows: 100px 100px 100px;
  grid-template-areas: 'a b c'
                       'd e f'
                       'g h i';
}

划分出9个单元格，然后将其定名为a到i的九个区域.
多个单元格合并成一个区域的写法如下。
grid-template-areas: "header header header"
                     "main main sidebar"
                     "footer footer footer";

grid-template-areas: 'a . c'
                     'd . f'
                     'g . i';
中间一列为点，表示没有用到该单元格，或者该单元格不属于任何区域
```
`区域的命名会影响到网格线。每个区域的起始网格线，会自动命名为区域名-start，终止网格线自动命名为区域名-end,例如header-start、header-end`

## grid-auto-flow
row 默认值 "先行后列"，即先填满第一行，再开始放入第二行。
column 先列后行
row dense  // row dense，表示"先行后列"，并且尽可能紧密填满，尽量不出现空格。
column dense
dense 愚钝的，某些项目指定位置以后，剩下的项目怎么自动放置。


## justify-items align-items place-items
justify-items属性设置单元格内容的水平位置（左中右），align-items属性设置单元格内容的垂直位置（上中下）

  justify-items: start | end | center | stretch;
  align-items: start | end | center | stretch;
stretch：拉伸，占满单元格的整个宽度（默认值）

`place-items: <align-items> <justify-items>;`

## justify-content align-content place-content
>content属性调整的是项目(容器>项目) items属性调整的是项目里的元素(默认stretch) 

justify-content属性是整个内容区域在容器里面的水平位置（左中右）
![justify-content start](./img/justify-content-start.png)

justify-content: start | end | center | stretch | space-around | space-between | space-evenly;
align-content: start | end | center | stretch | space-around | space-between | space-evenly;  
- stretch - 项目大小没有指定时，拉伸占据整个网格容器。
- space-around - 每个项目两侧的间隔相等。所以，项目之间的间隔比项目与容器边框的间隔大一倍
- space-between - 项目与项目的间隔相等，项目与容器边框之间没有间隔。
- space-evenly - 项目与项目的间隔相等，项目与容器边框之间也是同样长度的间隔。

`place-content: <align-content> <justify-content>`

## grid-auto-columns  grid-auto-rows 
比如网格只有3行，但是某一个项目指定在第5行。这时，浏览器会自动生成多余的网格，以便放置项目。
```
<div id="container">
  <div class="item item-1">1</div> 
  ...
  <div class="item item-8">8</div>
  <div class="item item-9">9</div>
</div>
#container{
  display: grid;
  grid-template-columns: 100px 100px 100px;
  grid-template-rows: 100px 100px 100px;
  grid-auto-rows: 50px; 
}

.item-8 {
  background-color: #d0e4a9;
  grid-row-start: 4;
  grid-column-start: 2;
}

.item-9 {
  background-color: #4dc7ec;
  grid-row-start: 5;
  grid-column-start: 3;
}
```
## 项目位置
项目的位置是可以指定的，具体方法就是指定项目的四个边框，分别定位在哪根网格线。
```
.item-1 {
  grid-column-start: 1;// header-start;
  grid-column-end: 3;
  grid-row-start: 2;
  grid-row-end: 4;
}
```
grid-column-start属性：左边框所在的垂直网格线
grid-column-end属性：右边框所在的垂直网格线
grid-row-start属性：上边框所在的水平网格线
grid-row-end属性：下边框所在的水平网格线
//通过设置 star end 可以实现 rowspan colspan 效果


```
.item-1 {
  grid-column-start: span 2;
}
```
- span关键字，表示"跨越"，即左右边框（上下边框）之间跨越多少个网格
- 如果产生了项目的重叠，则使用z-index属性指定项目的重叠顺序

## grid-column grid-row
grid-column:grid-column-start/grid-column-end
grid-row:grid-row-start/grid-row-end
```
grid-row:span 6;
```
## grid-area
指定项目放在哪一个区域
```
.item-1 {
  grid-area: e;
}

.item {
  grid-area: <row-start> / <column-start> / <row-end> / <column-end>;
}
```
## self
justify-self属性设置单元格内容的水平位置（左中右），跟justify-items属性的用法完全一致，但只作用于单个项目。

align-self属性设置单元格内容的垂直位置（上中下），跟align-items属性的用法完全一致，也是只作用于单个项目。

  justify-self: start | end | center | stretch;
  align-self: start | end | center | stretch;
  `place-self: <align-self> <justify-self>;`


# [Flex 布局教程：语法篇](http://www.ruanyifeng.com/blog/2015/07/flex-grammar.html)

布局的传统解决方案，基于盒状模型，依赖 display 属性 + position属性 + float属性。它对于那些特殊布局非常不方便，比如，垂直居中就不容易实现。

Flex 是 Flexible Box 的缩写，意为"弹性布局",用来为盒状模型提供最大的灵活性。
```
.box{
  display: flex;//inline-flex// -webkit-flex;
}
```
`注意，设为 Flex 布局以后，子元素的float、clear和vertical-align属性将失效。`

>采用 Flex 布局的元素，称为Flex 容器（flex container)它的所有子元素自动成为容器成员，称为 Flex 项目（flex item）。

## 容器的属性
- flex-direction
- flex-wrap
- flex-flow
- justify-content
- align-items
- align-content 

### flex-direction
定义：主轴的方向（即项目的排列方向）
flex-direction: row | row-reverse | column | column-reverse;

### flex-wrap
定义：多个项目在一条轴线排不下，如何换行
flex-wrap: nowrap | wrap | wrap-reverse;
wrap：换行，第一行在上方，
wrap-reverse :换行 第一行在下方
//wrap 在当前行下方插入项目
//wrap-reverse 在当前行上发插入项目

`flex-flow: <flex-direction> || <flex-wrap>;`

### justify-content
定义：项目在主轴上的对齐方式
justify-content: flex-start | flex-end | center | space-between | space-around;

### align-items
定义： 项目在交叉轴上如何对齐
 align-items: flex-start | flex-end | center | baseline | stretch;

###  align-content
定义： 多根轴线的对齐方式
align-content: flex-start | flex-end | center | space-between | space-around | stretch;

## 项目的属性
- order 
- flex-grow
- flex-shrink
- flex-basis
- flex
- align-self 

### order
定义:项目的排列顺序。数值越小，排列越靠前，默认为0
```
.item {
  order: <integer>;
}
```
###  flex-grow
定义：项目的放大比例，默认为0，即如果存在剩余空间，也不放大。
>如果所有项目的flex-grow属性都为1，则它们将等分剩余空间（如果有的话）。如果一个项目的flex-grow属性为2，其他项目都为1，则前者占据的剩余空间将比其他项多一倍

### flex-shrink
定义: 项目的缩小比例，默认为1，即如果空间不足，该项目将缩小。
>如果所有项目的flex-shrink属性都为1，当空间不足时，都将等比例缩小。如果一个项目的flex-shrink属性为0，其他项目都为1，则空间不足时，前者不缩小。

### flex-basis
定义: 在分配多余空间之前，项目占据的主轴空间（main size）。浏览器根据这个属性，计算主轴是否有多余空间。它的默认值为auto，即项目的本来大小。
 flex-basis: <length> | auto; /* default auto */
 //100px 则项目将占据固定空间

### flex
 flex: none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]
 快捷值：auto (1 1 auto) 和 none (0 0 auto)。
 //auto 扩大缩写
 //0 不扩大不缩小
 flex:1 // 1 1 0% 
>建议优先使用这个属性，而不是单独写三个分离的属性，因为浏览器会推算相关值。

>单值语法: 值必须为以下其中之一:
一个无单位数(<number>): 它会被当作<flex-grow>的值。
一个有效的宽度(width)值: 它会被当作 <flex-basis>的值。
关键字none，auto或initial.


### align-self
允许单个项目有与其他项目不一样的对齐方式，可覆盖align-items属性。默认值为auto，表示继承父元素的align-items属性，如果没有父元素，则等同于stretch。
  align-self: auto | flex-start | flex-end | center | baseline | stretch;

# [Flex 布局教程：实例篇](http://www.ruanyifeng.com/blog/2015/07/flex-examples.html)

[骰子布局](https://codepen.io/LandonSchropp/pen/KpzzGo)
```
[.   .]
[     ]
[.   .]
<div class="fourth-face">
  <div class="column">
    <span class="pip"></span>
    <span class="pip"></span>
  </div>
  <div class="column">
    <span class="pip"></span>
    <span class="pip"></span>
  </div>
</div>

.fourth-face, .sixth-face {
  display: flex;
  justify-content: space-between;
}

.fourth-face .column, .sixth-face .column {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
```

圣杯布局
![圣杯布局](img/holyGrail.png)
```
<body class="HolyGrail">
  <header>...</header>
  <div class="HolyGrail-body">
    <main class="HolyGrail-content">...</main>
    <nav class="HolyGrail-nav">...</nav>
    <aside class="HolyGrail-ads">...</aside>
  </div>
  <footer>...</footer>
</body>

.HolyGrail {
  display: flex;
  min-height: 100vh;
  flex-direction: column;
}

header,
footer {
  flex: 1;
}

.HolyGrail-body {
  display: flex;
  flex: 1;
}

.HolyGrail-content {
  flex: 1;
}

.HolyGrail-nav, .HolyGrail-ads {
  /* 两个边栏的宽度设为12em */
  flex: 0 0 12em;
}

.HolyGrail-nav {
  /* 导航放到最左边 */
  order: -1;
}


如果是小屏幕，躯干的三栏自动变为垂直叠加。
@media (max-width: 768px) {
  .HolyGrail-body {
    flex-direction: column;
    flex: 1;
  }
  .HolyGrail-nav,
  .HolyGrail-ads,
  .HolyGrail-content {
    flex: auto;
  }
}
```


```
.item {flex: 1;}// 1 1 0%
等同
.item {
    flex-grow: 1;
    flex-shrink: 1;
    flex-basis: 0%;
}


.item-1 {flex: 0%;}
.item-1 {
    flex-grow: 1;
    flex-shrink: 1;
    flex-basis: 0%;
}

.item {flex: 2 3;}
.item {
    flex-grow: 2;
    flex-shrink: 3;
    flex-basis: 0%;
}
```

flex-basis 规定的是子元素的基准值。所以是否溢出的计算与此属性息息相关。flex-basis 规定的范围取决于 box-sizing。这里主要讨论以下 flex-basis 的取值情况：

auto：首先检索该子元素的主尺寸，如果主尺寸不为 auto，则使用值采取主尺寸之值；如果也是 auto，则使用值为 content。

content：指根据该子元素的内容自动布局。有的用户代理没有实现取 content 值，等效的替代方案是 flex-basis 和主尺寸都取 auto。

百分比：根据其包含块（即伸缩父容器）的主尺寸计算。如果包含块的主尺寸未定义（即父容器的主尺寸取决于子元素），则计算结果和设为 auto 一样。
//flex-basis 定义该元素的基本宽度，有剩余空间还可以扩大



# [CSS Multiple-column 分栏布局](https://www.zhangxinxu.com/wordpress/2019/01/css-css3-columns-layout/)
分栏布局IE10+都可以使用，API稳定，移动端兼容性比flex布局要好，虽然设计初衷不一样，但很多布局都可以实现。

- 直接相关属性
column-width column-count columns 
column-rule-color column-rule-style column-rule-width column-rule
column-span column-fill column-gap 
- 间接相关属性
break-after break-before break-inside 

##  column-width
`column-width: <length> | auto` 表示每一栏/列的最佳宽度
auto:默认值。表示每一栏的宽度由其它CSS属性决定，例如column-count。
如果我们只设定column-width，浏览器会自动根据现有容器宽度划分栏目的个数。
length:表示设定的最佳列宽值。实际呈现的每一栏的宽度可能与指定值不同，不支持负值，也不支持百分比值。
>例如容器宽度400像素，设定的每一栏宽度是300像素，不足以分栏，此时内容填充填充表现为充分利用可用空间，最终呈现的列宽比设定的更宽。又例如容器宽度400像素，column-width设置为500像素，则最终分栏宽度不会超过容器宽度，比设定的500像素要小。

## column-count
`column-count: <integer> | auto` 表示理想的分栏数目
auto 默认值。表示分栏数目由其它CSS属性决定，例如column-width。
ineger 不支持负值，也不支持0
>column-count与column-width都有可能有更高的优先级，要看具体场景。优先级计算诀窍就是统一转换column-count值，哪个小就使用哪一个。

`columns: column-width column-count`

## column-rule
```
column-rule-style: dotted;//none ,同border-style
column-rule-color: red; //表示每个栏目中间分隔线的颜色,默认值是当前color属性的计算值
column-rule-width: medium //1px ,同 border-width
```
`column-rule:column-rule-width column-rule-style column-rule-color`

## column-span
类似于表格布局中的colspan这个HTML属性，表示某一个内容是否跨多栏显示。
column-span: none; 默认值   
column-span: all; 表示横跨所有垂直列。

## column-fill
当内容分栏的时候，如何平衡每一栏填充的内容
column-fill:auto 按顺序填充每一列。内容只占用它需要的空间。
balance 默认值。尽可能在列之间平衡内容。

## column-gap
`column-gap: normal | <length-percentage>;`
normal 默认值。在多栏布局中为1em，在其它类型的布局中为0。

## 间接相关CSS属性 
每个可能的断点（每个元素边界）受三个属性的影响：前一个元素的break-after值，下一个元素的break-before值，以及包含元素的break-inside值。
break-after: auto|avoid 
auto 允许但不强制在主框之后插入任何中断（page，column或region布局下
avoid 避免在主体框后插入任何分隔符（page，column或region布局下）

break-before:auto|avoid
auto 允许但不强制在主框之前插入任何中断（page，column或region布局下）
avoid 避免在主体框前插入任何分隔符（page，column或region布局下）

break-inside: auto|avoid
定义页面、列或区域发生中断时候的元素该如何表现。如果没有中断，则忽略该属性。
auto 元素可以中断
avoid 元素不可以中断




## dashboard example








