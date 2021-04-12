# stylus

```
$ npm install stylus -g
```

```
border-radius()
  -webkit-border-radius: arguments
  -moz-border-radius: arguments
  border-radius: arguments

body
  font: 12px Helvetica, Arial, sans-serif

a.button
  border-radius: 5px
```

###  Create & Share

```
@import 'vendor'

body
  font: 12px Helvetica, Arial, sans-serif

a.button
  border-radius: 5px
```

```
fonts = Helvetica, Arial, sans-serif

body {
  padding: 50px;
  font: 14px/1.4 fonts;
}
```



The `&` character references the parent selector(s).

```
textarea
input
  color #A7A7A7
  &:hover
    color #000
```

```
textarea,
input {
  color: #a7a7a7;
}
textarea:hover,
input:hover {
  color: #000;
}
```











