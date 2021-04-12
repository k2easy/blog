![image-20201105205915646](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/0520201105205915.png)



navigation 
cmd+T show all symbols
 ^G goto line 
cmd+P goto file 

cmd+ \ split  ,或者 cmd+2 切换

cmd+0 跳到explore  cmd+shift+E





ctrl+j       Join Lines  ,多行转成一行

cmd+key clear terminal



prefrences>key map> 顶部按钮 open in json ,新增自定义快捷键，方便编辑区域和命令区域导航

本义cmd+j toggle terminal(使用 ctrl+` or 使用命令面板 toggle terminal),cmd+k terminal clear（使用clear命令清理，ctrl+L ） 

```
    {
      "key": "alt+cmd+k",
      "command": "workbench.action.focusActiveEditorGroup",
      "when": "terminalFocus"
    }, 
      {
        "key": "alt+cmd+j",
        "command": "workbench.action.terminal.focus",
        "when": "!terminalFocus"
      } 
```

