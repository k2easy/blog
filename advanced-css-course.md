# [Advanced CSS and Sass: Flexbox, Grid, Animations and More!](https://www.udemy.com/course/advanced-css-and-sass/)

>blog, http://codingheroes.io/resources/
>
>github,    [jonasschmedtmann](https://github.com/jonasschmedtmann)    /      **[advanced-css-course](https://github.com/jonasschmedtmann/advanced-css-course)**  
>
>twitter,https://twitter.com/jonasschmedtman
>
>codepen.io,The best place to build, test, and discover front-end code.
>

## VSCode setup used in the course


vscode-icons // ext install vscode-icons , `MacOS` `=>` **Code > Preferences > File Icon Theme > VSCode Icons**.

## Material Theme

```shell
ext install material theme 
```

### Activate theme

Type `theme`, choose `Preferences: Color Theme`,  and select one of the Material Theme variants from the list. After  activation, the theme will set the correct icon theme based on your  active theme variant.

### Override theme colors

```js
"editor.tokenColorCustomizations": {
    "[Material Theme VARIANT]": {
        "textMateRules": [
            {
                "scope": [
                    "punctuation.definition.comment",
                    "comment.block",
                    "comment.line",
                    "comment.block.documentation"
                ],
                "settings": {
                    "foreground": "#FF0000"
                }
            }
        ]
    },
},

"workbench.colorCustomizations": {
	"[Material Theme VARIANT]": {
		"sideBar.background": "#ff0000",
	}
},
```

```js
Recommended settings for a better experience，
//命令面板搜索settting即可
{
    // Controls the font family.
    "editor.fontFamily": "Operator Mono",//推荐
    // Controls the line height. Use 0 to compute the lineHeight from the fontSize.
    "editor.lineHeight": 24,
    // Enables font ligatures
    "editor.fontLigatures": true,
    // Controls if file decorations should use badges.
    "explorer.decorations.badges": false
}
```

## Auto Rename Tag

When you rename one HTML/XML tag, automatically rename the paired HTML/XML tag

```json
{
  "auto-rename-tag.activationOnLanguage": ["html", "xml", "php", "javascript"]
}
```

## Project Manager

easy switch between project

# html5 css3

```
*{
 margin:0;
 padding:0;
 box-sizing:border-box;
}
```

|                                                              |                                                              |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| <img src="/Users/demo/Library/Application Support/typora-user-images/image-20200617213509406.png" alt="image-20200617213509406" style="zoom: 33%;" /> | <img src="/Users/demo/Desktop/Screen Shot 2020-06-28 at 13.05.50.png" alt="Screen Shot 2020-06-28 at 13.05.50" style="zoom: 25%;" /> | <img src="/Users/demo/Desktop/Screen Shot 2020-06-28 at 13.06.25.png" alt="Screen Shot 2020-06-28 at 13.06.25" style="zoom: 25%;" /> |



## nomalize.css 

git.io/normalize

```css

```





1. item 1



[] item1



# media queries and breakpoints

0px 480px(small phone) 768px() 1024px(平板) 1200px

```css

/* big tablet  */
@media only screen and (max-width:1200px){
  
}

/* small tablet to big table: 768px to 1023px */
@media only screen and (max-width:1023){
  
}

/* small phone to small tablets : 481px ~ 767px */
@mdedia only screen and (max-width:767px){
  
}

/* small phone : 0 ~ 480px */
@mdedia only screen and (max-width:480px){
  
}
```



```
<meta name='viewport' content='width=device-width,initial-scale=1.0' >
```





# grid 语法学习

https://css-tricks.com/snippets/css/complete-guide-grid/





# emmet 快捷键

`html:5` 或者 `!` 生成 HTML5 结构
`html:xt` 生成 HTML4 过渡型
`html:4s` 生成 HTML4 严格型

```
div#header.section

p>span

p+div

ul>li>a^div //^^ 
// ^ 使该符号前的标签提升一行

ul>li*5

ul>(li>a)*5  // 生成分组的标签（） 

生成递增的属性标签等: $
ul>li.item$*5
  <ul>
      <li class="item1"></li>
      <li class="item2"></li>
      <li class="item3"></li>
      <li class="item4"></li>
      <li class="item5"></li>
  </ul>

$$$多位
ul>li.item$$$*5 则生成
  <ul>
      <li class="item001"></li>
      <li class="item002"></li>
      <li class="item003"></li>
      <li class="item004"></li>
      <li class="item005"></li>
  </ul>


从某个特定的顺序开始呢：@N
例如输入ul>li.item$@10*5 则生成
<ul>
   <li class="item10"></li>
   <li class="item11"></li>
   <li class="item12"></li>
   <li class="item13"></li>
   <li class="item14"></li>
</ul>

生成文本内容：{}
p{我是paddingme} 则生成
  <p>我是paddingme</p>




缺省元素:

    声明一个带class的div 可以不用输入div；
    .header+.footer 则生成:

<div class="header"></div>
<div class="footer"></div>

    Emmet 还会根据父标签进行判定
    例如输入ul>.item*3 则生成：

<ul>
   <li class="item"></li>
   <li class="item"></li>
   <li class="item"></li>
</ul>

下面是所有的隐式标签名称：
    li：用于 ul 和 ol 中
    tr：用于 table、tbody、thead 和 tfoot 中
    td：用于 tr 中
    option：用于 select 和 optgroup 中

```

lorem10 10个拉丁单词

> Lorem ipsum是指一篇常用于排版设计领域的拉丁文文章，主要的目的为测试文章或文字在不同字型、版型下看起来的效果。中文的类似用法则称为乱数假文、随机假文

p>lorem*10 //  p标签下有10个span内容为lorem

(p>lorem)*10  // 10个p标签内容为lorem



# [Browser Preview for VS Code](https://css-tricks.com/snippets/css/complete-guide-grid/)

Browser Preview for VS Code enables you to open a real browser preview  inside your editor that you can debug. Browser Preview is powered by [Chrome Headless](https://developers.google.com/web/updates/2017/04/headless-chrome), and works by starting a headless Chrome instance in a new process.

Click the new "Browser Preview" button in the Side Bar to the left or run the command `Browser View: Open Preview`

The **fr** unit allows you to set the size of a track as a fraction of the free space of the grid container .

```
.container{
	grid-template-columns:1fr 1fr 1fr;
	// one third the width of the grid container 
}
```



grid-template-areas

Repeating the name of a grid area causes the content to span those cells.

```
.container {
  grid-template-areas: 
    " | . | none | ..."
    "...";
}

. – a period signifies an empty grid cell
none – no grid areas are defined

.item-a {
  grid-area: header;
}

}

.container {
  display: grid;
  grid-template-columns: 50px 50px 50px 50px;
  grid-template-rows: auto;
  grid-template-areas: 
    "header header header header"
    "main main . sidebar"
    "footer footer footer footer";
}

area-name => line-name
header-start header-end 


```



#### grid-template

A shorthand for setting `grid-template-rows`, `grid-template-columns`, and `grid-template-areas` in a single declaration.

```css
.container {
  grid-template: none | <grid-template-rows> / <grid-template-columns>;
}
```

```css
.container {
  grid-template:
    [row1-start] "header header header" 25px [row1-end]
    [row2-start] "footer footer footer" 25px [row2-end]
    / auto 50px auto;
}
```

```css
.container {
  grid-template-rows: [row1-start] 25px [row1-end row2-start] 25px [row2-end];
  grid-template-columns: auto 50px auto;
  grid-template-areas: 
    "header header header" 
    "footer footer footer";
}
```

Since `grid-template` doesn’t reset the *implicit* grid properties (`grid-auto-columns`, `grid-auto-rows`, and `grid-auto-flow`), which is probably what you want to do in most cases, it’s recommended to **use the `grid` property instead of `grid-template`.**



```css
  column-gap: <line-size>;
  row-gap: <line-size>;
```

 gap  A shorthand for `row-gap` and `column-gap`

```css
  gap: <grid-row-gap> <grid-column-gap>;
```

#### justify-items

Aligns grid items along the *inline (row)* axis (as opposed to `align-items` which aligns along the *block (column)* axis).  

- **stretch** – fills the whole width of the cell (this is the default)

```css
.container {
  justify-items: start | end | center | stretch;
  align-items: start | end | center | stretch;
}
```



`place-items` sets both the `align-items` and `justify-items` properties in a single declaration.



#### justify-content

Sometimes the total size of your grid might be less than the size of  its grid container. This could happen if all of your grid items are  sized with non-flexible units like `px`. 

```html
.container {
  justify-content: start;
  // align-content
}
```

<img src="https://css-tricks.com/wp-content/uploads/2018/11/justify-content-start.svg" alt="Example of justify-content set to start" style="zoom:50%;" />

`place-content` sets both the `align-content` and `justify-content` properties in a single declaration.

#### grid-auto-columns grid-auto-rows

Specifies the size of any auto-generated grid tracks (aka *implicit grid tracks*).

```css
.container {
  grid-template-columns: 60px 60px;
  grid-template-rows: 90px 90px;
}

.item-a {
  grid-column: 1 / 2;
  grid-row: 2 / 3;
}
.item-b {
  grid-column: 5 / 6;
  grid-row: 2 / 3;
}
```

并不存在竖线5、6，自动生成

<img src="https://css-tricks.com/wp-content/uploads/2018/11/grid-auto-columns-rows-02.svg" alt="Example of implicit tracks" style="zoom:50%;" />

 *we never defined a column line 5 or 6*. Because we referenced lines that don’t exist, implicit tracks with widths of 0 are created to fill in the gaps. We can use `grid-auto-columns` and `grid-auto-rows` to specify the widths of these implicit tracks:

```css
.container {
  grid-auto-columns: 60px;
}
```

![grid-auto-columns-rows](https://css-tricks.com/wp-content/uploads/2018/11/grid-auto-columns-rows-03.svg)



#### grid-auto-flow

If you have grid items that you don’t explicitly place on the grid, the *auto-placement algorithm* kicks in to automatically place the items. 

```css
.container {
  grid-auto-flow: row | column | row dense | column dense;
}
```

```html
<section class="container">
  <div class="item-a">item-a</div>
  <div class="item-b">item-b</div>
  <div class="item-c">item-c</div>
  <div class="item-d">item-d</div>
  <div class="item-e">item-e</div>
</section>
```

```css
.container {
  display: grid;
  grid-template-columns: 60px 60px 60px 60px 60px;
  grid-template-rows: 30px 30px;
  grid-auto-flow: row;
}
```

```css
.item-a {
  grid-column: 1;
  grid-row: 1 / 3;
}
.item-e {
  grid-column: 5;
  grid-row: 1 / 3;
}
```

![Example of grid-auto-flow set to row](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/09/2020200920165815.svg)

![Example of grid-auto-flow set to column](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/09/2020200920170000.svg)

#### grid

A shorthand for setting all of the following properties in a single declaration: `grid-template-rows`, `grid-template-columns`, `grid-template-areas`, `grid-auto-rows`, `grid-auto-columns`, and `grid-auto-flow` (Note: You can only specify the explicit or the implicit grid properties in a single grid declaration).  



### Special Functions and Keywords

size unit : px rem % auto   `min-content`, `max-content`,
grid-template-columns: 200px 1fr 2fr min-content;

set a column to be 1fr, but shrink no further than 200px: `grid-template-columns: 1fr minmax(200px, 1fr); `

```
grid-template-columns: repeat(10, 1fr);
```

```
grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
```

**animation**

## Properties for the Children (Grid Items)

`float`, `display: inline-block`, `display: table-cell`, `vertical-align` and `column-*` properties have no effect on a grid item.

```
grid-column-start
grid-column-end
grid-row-start
grid-row-end

: <number> | <name> | span <number> | span <name> | auto;


.item-b {
  grid-column-start: 1;
  grid-column-end: span col4-start;
  grid-row-start: 2;
  grid-row-end: span 2;
}
```

#### grid-column grid-row

Shorthand for `grid-column-start` + `grid-column-end`, and `grid-row-start` + `grid-row-end`, respectively.

```
.item {
  grid-column: <start-line> / <end-line> | <start-line> / span <value>;
  grid-row: <start-line> / <end-line> | <start-line> / span <value>;
}	
```

```css
.item-c {
  grid-column: 3 / span 2;
  grid-row: third-line / 4;
}
```

![Example of grid-column/grid-row](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/09/2020200920213112.svg)



#### grid-area

Gives an item a name so that it can be referenced by a template created with the `grid-template-areas` property

```
Values: 
    <name> – a name of your choosing
    <row-start> / <column-start> / <row-end> / <column-end> – can be numbers or named lines
    
    
```

```css
.item-d {
  grid-area: header;
}
.item-d {
  grid-area: 1 / col4-start / last-line / 6;
}

```

![Example of grid-area](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/09/2020200920213356.svg)

#### justify-self

Aligns a grid item inside a cell along the *inline (row)* axis (as opposed to `align-self` which aligns along the *block (column)* axis). 

```css
.item {
  justify-self: start | end | center | stretch;
}
```

![Example of justify-self set to start](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/09/2020200920213502.svg)

#### align-self

#### place-self

`place-self` sets both the `align-self` and `justify-self` properties in a single declaration.

```
.item-a {
  place-self: center stretch;
}

.item-a {
  place-self: center;
}
```

![place set set to center stretch](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/09/2020200920213604.svg)



# FAQ

1. background  背景色 背景图片

   ```
   header {
     background: #334C23 url(plants.jpg);
     color: white;
   }
   ```

   慢速网络下图片尚未加载出现时，让白色文字在背景色下可见。

   



# [The Greatest CSS Tricks](https://css-tricks.com/books/greatest-css-tricks/)

 



# [CSS Almanac](https://css-tricks.com/almanac/)

```
body {
  background:
     url(sweettexture.jpg)    /* image */
     top center / 200px 200px /* position / size */
     no-repeat                /* repeat */
     fixed                    /* attachment */
     padding-box              /* origin */
     content-box              /* clip */
     red;                     /* color */
}
```







# wiki

# CSS

no `:blur` pseudo-class in CSS.

`:focus` pseudo-class represents an element that *is in* focus; If you need to apply styles to an element that *is not in* focus, you have two choices:

1. Use `:not(:focus)` (with less browser support):

   ```
   input:not(:focus), button:not(:focus) {
       /* Styles for only form inputs and buttons that do not have focus */
   }
   ```

2. Declare a rule that applies to any element regardless of its focus state, and override for elements that have focus:

   ```
   input, button {
       /* Styles for all form inputs and buttons */
   }
   
   input:focus, button:focus {
       /* Styles for only form inputs and buttons that have focus */
   }
   ```

`:empty` [CSS](https://developer.mozilla.org/en-US/docs/Web/CSS) [伪类](https://developer.mozilla.org/zh-CN/CSS/Pseudo-classes) 代表没有子元素的元素。子元素只可以是元素节点或文本（包括空格



how-do-i-detect-a-click-outside-an-element

```
$(window).click(function() {
//Hide the menus if visible
});

$('#menucontainer').click(function(event){
    event.stopPropagation();
});
```

You need the [`:not()`](http://api.jquery.com/not-selector/) selector:

```js
$('div[class^="first-"]:not(.first-bar)')
```

or, alternatively, the [`.not()`](http://api.jquery.com/not/) method:

```js
$('div[class^="first-"]').not('.first-bar');
```



