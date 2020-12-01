

# SUMIFS

SUMIFS 函数计算一区域中符合多个指定条件的数字的和。

```excel
=SUMIFS(sum_range, criteria_range1, criteria1,[criteria_range2, criteria2], ...)
=SUMIFS(求和区域, 条件区域1, 条件1, [条件区域2, 条件2], ...)
```

$A$1（引用是绝对的）

![SUMIFS 函数](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/2420201124150446.png)

### excel单元格引用 

相对引用  引用格式形如“A1”。

单元格B1中输入公式“=A1*2”，最后把B1单元格中的公式分别复制到B2至B5，则会发现B2至B5单元格中的结果均等于对左侧单元格的数值乘以2。

![Excel如何引用单元格](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/2420201124115314.jpg)

 绝对引用   引用格式形如“$A$1”

在单元格B1中输入公式“=$A$1*2”，最后把B1单元格中的公式分别复制到B2至B5处，则会发现B2至B5单元格中的结果均等于A1单元格的数值乘以2。

![Excel如何引用单元格](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/2420201124115404.jpg)





混合引用

引用格式形如“A$1”

新公式对列的引用将会发生变化，而对行的引用则固定不变

通过名称来引用：
![Excel如何引用单元格](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/2420201124115625.jpg)![Excel如何引用单元格](https://exp-picture.cdn.bcebos.com/3761a73acd8920c58a46e886568a59de4407889c.jpg?x-bce-process=image%2Fresize%2Cm_lfit%2Cw_500%2Climit_1)



# COUNTIFS

统计指定单元格区域中符合多个指定条件的单元格个数。

```excel
=COUNTIFS(criteria_range1, criteria1,[criteria_range2, criteria2]…)
=COUNTIFS(条件区域1, 条件1, [条件区域2, 条件2]…)
```





### IF

```
=IF(Info!$D$7="Metric","m3/h","gpm")
```

`Info` is the name of the sheet, `$D$7` is the cell.

The formula is saying that if the value of D7 on the Info sheet is  "Metric" then the value of the cell should be m3/h. If it is not, the  value of the cell should be gpm.



快速跳列，跳到某个单元格

***Ctrl+G\*** 鍵 V5



smartbi =SUM(A7) 相对引用，复制该单元格内容到另外单于格 即可自适应





smartbi 数据集 右键插入 参数，sql复制自动格式化，自动文本转换成参数控件。
减少拖拽，{{ 参数名称或ID }}

属性》别名，名称都可以再次编辑。

减少弹出框 ，如预览 可以放在右半边，输出字段、私有参数、输出参数作为tab页 放在下方，可以拖拽伸缩窗格大小

宏代码智能提醒

echart 提示(tooltip 英文名称) trigger无法设置，应该把配置好的option直接显示出来 允许编辑运行，UI配置编辑/代码编辑

产品力太弱

UI参数控件 可以预览

echarts结合不好，geo是数组 不是{ }

新建原生数据集 语法高亮 函数提醒

尽量分离，以便前端更新升级JS库 如echarts新版本

 支持markdown 报告
支持 在线ppt编辑

支持JS自定义参数，如最近30天日期选择框

下拉框数据JS自定义，现在新建参数都是直接选择数据源 ，如 上个月最后一天 ，最近30天数据

自动检测输出字段

vscode 就是最好的设计，节省时间的设计就是最好的设计

参数控件：tab切换 sql类型、静态数据列表 ，tab页标签上绿色对号 代表使用当前页，可以暂存sql语句，方便使用静态数值开发测试使用



新建参数保存的时候提示已存在同名的对象，无法保存；但实际这个文件夹下并没有这个参数。
 参数保存出现不允许同名的对象是正常的，因为参数定义在知识库t_restree表的c_resid 字段记录的方式是 PARAM.数据源.参数名称 ，这就表明参数的区分是以数据源来区分的，同一个数据源下不允许存在相同名称的参数。



数据集中 更话参数控件，没有生效，关闭浏览器 清理缓存 才能生效。



# [Excel 函数大全](https://www.lanrenexcel.com/excel-functions-list/)



发布时提示 请退出其他单元格编辑状态 ，ctrl+S保存一下即可。