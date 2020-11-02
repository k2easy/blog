

# npm



# NPM

```
默认 npm config set registry https://registry.npmjs.org
npm config set registry https://registry.npm.taobao.org
npm config list
 
```

#  [json-server](http://zetcode.com/javascript/jsonserver/)

 json-server is a JavaScript library to create testing REST API.

```
npm install -g json-server 
users.json
{
  "users": [
    {
      "id": 1,
      "first_name": "Robert",
      "last_name": "Schwartz",
      "email": "rob23@gmail.com"
    },
    {
      "id": 2,
      "first_name": "Lucy",
      "last_name": "Ballmer",
      "email": "lucyb56@gmail.com"
    },
    {
      "id": 3,
      "first_name": "Anna",
      "last_name": "Smith",
      "email": "annasmith23@gmail.com"
    },
    {
      "id": 4,
      "first_name": "Robert",
      "last_name": "Brown",
      "email": "bobbrown432@yahoo.com"
    },
    {
      "id": 5,
      "first_name": "Roger",
      "last_name": "Bacon",
      "email": "rogerbacon12@yahoo.com"
    }
  ]
}   
json-server --watch user.json 


axios.get('http://localhost:3000/users?q=yahoo')
    .then(resp => {
        console.log(resp.data)
    }).catch(error => {
        console.log(error);
    });
axios.delete('http://localhost:3000/users/1/')

axios.get('http://localhost:3000/users?_sort=last_name&_order=asc')
    .then(resp => {
        data = resp.data;
        data.forEach(e => {
            console.log(`${e.first_name}, ${e.last_name}, ${e.email}`)
        });
    }).catch(error => {
        console.log(error);
    });    
    
```

[Can I apply CSS to the elements within an iframe?](https://stackoverflow.com/questions/3286178/can-i-apply-css-to-the-elements-within-an-iframe)

No, not from *outside* the iframe. An `<iframe>` is its own world. If the domains etc. match, then Javascript can  communicate in and out, and could (if it wanted to) inject CSS into a  child frame.

If the `<iframe>` contains content from a different  domain, there's pretty much nothing you can do. The parent page controls the size of the frame and whether it's visible, and can put its own  content *over* the frame by positioning etc, but it can't directly effect the way the actual frame content is rendered. 

# layer

layer.load('数据加载中',{zIndex:layer.zIndex})

# 动态搜索框

```js
var li = $('li');
var liSelected;
$(window).keydown(function(e) {
    if(e.which === 40) { //arrow down
        if(liSelected) {
            liSelected.removeClass('selected');
            next = liSelected.next();
            if(next.length > 0) {
                liSelected = next.addClass('selected');
            } else {
                liSelected = li.eq(0).addClass('selected');
            }
        } else {
            liSelected = li.eq(0).addClass('selected');
        }
    } else if(e.which === 38) {// arrow up
        if(liSelected) {
            liSelected.removeClass('selected');
            next = liSelected.prev();
            if(next.length > 0) {
                liSelected = next.addClass('selected');
            } else {
                liSelected = li.last().addClass('selected');
            }
        } else {
            liSelected = li.last().addClass('selected');
        }
    }
});

JSFiddle: http://jsfiddle.net/Vtn5Y/	
```

keycode  13 = Enter

#常用函数

 `**concat()**` 方法用于合并两个或多个数组。此方法不会更改现有数组，而是返回一个新数组。const array3 = array1.concat(array2);

`**sort()**` 方法用[原地算法](https://en.wikipedia.org/wiki/In-place_algorithm)对数组的元素进行排序，并返回数组。默认排序顺序是在将元素转换为字符串，然后比较它们的UTF-16代码单元值序列时构建的

```
var arr = [2,3,13,17,4,19,1];
arr.sort() // 结果：[1, 13, 17, 19, 2, 3, 4]
var arr = [2,3,13,17,4,19,1];
arr.sort(function(a,b){ // 这是比较函数
    return b - a;    // 降序
})
console.log(arr) // 结果：[19, 17, 13, 4, 3, 2, 1]

const months = ['March', 'Jan', 'Feb', 'Dec'];
months.sort();
console.log(months);
// expected output: Array ["Dec", "Feb", "Jan", "March"]


```



`**slice()**` 方法返回一个新的数组对象，这一对象是一个由 `begin` 和 `end` 决定的原数组的**浅拷贝**（包括 `begin`，不包括`end`）。原始数组不会被改变。arr.slice([begin[, end]])

const animals = ['ant', 'bison', 'camel', 'duck', 'elephant'];

console.log(animals.slice(2));
console.log(animals)

> Array ["camel", "duck", "elephant"] > Array ["ant", "bison", "camel", "duck", "elephant"]

`**reverse()**` 方法将数组中元素的位置颠倒，并返回该数组。数组的第一个元素会变成最后一个，数组的最后一个元素变成第一个。该方法会改变原数组。



`**Math.max()**` 函数返回一组数中的最大值。
console.log(Math.max(1, 3, 2));// 3
作用于数组:

```js
Math.max.apply(null, numArray);//

var arr = [1, 2, 3];
var max = Math.max(...arr);
```



```js
if ('membername' in object) // With inheritance
if (object.hasOwnProperty('membername')) // Without inheritance
```

```js
if (typeof yourvar !== 'undefined') // Any scope
```

to check if a variable is declared *and* is not `undefined`:

```js
if (yourvar !== undefined) // Any scope
```

ou can now safely use `===` and `!==` to test for `undefined` without using `typeof` as `undefined` has been read-only for some time.

# [ find element by text](https://stackoverflow.com/questions/7321896/jquery-find-element-by-text)

```js
$('div:contains("test")').css('background-color', 'red');
<div>This is a test</div>
<div>Another Div</div>
```

 

# apply、call

在 javascript 中，call 和 apply 都是为了改变某个函数运行时的上下文（context）而存在的，换句话说，就是为了改变函数体内部 this 的指向。

```
function` `fruits() {}
```

 

```
fruits.prototype = {
  ``color: ``"red"``,
  ``say: ``function``() {
    ``console.log(``"My color is "` `+ ``this``.color);
  ``}
}
```

 

```
var` `apple = ``new` `fruits;
apple.say();  ``//My color is red

banana = {
    color: "yellow"
}
apple.say.call(banana);     //My color is yellow
apple.say.apply(banana);    //My color is yellow

```

apply、call  ，作用完全一样，只是接受参数的方式不太一样。

```
func.call(``this``, arg1, arg2); 
func.apply(``this``, [arg1, arg2])
```

call 需要把参数按顺序传递进去，而 apply 则是把参数放在数组里。　　



#  防抖 节流

节流:一段时间内只执行一次,//持续出发并不会执行多次,到一定时间再去执行;
防抖:

**`apply()`** 方法调用一个具有给定`this`值的函数，以及作为一个数组（或[类似数组对象](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Indexed_collections#Working_with_array-like_objects)）提供的参数。

`call()`方法接受的是**参数列表**，而`apply()`方法接受的是**一个参数数组**。

```
const numbers = [5, 6, 2, 3, 7];
const max = Math.max.apply(null, numbers);//7
```







# axios文件下载

axios返回结果可能是： excel文件流 或 json格式校验结果信息(记录数为0或超过10万条最大下载限制)

 

```
axios({
  url:url,
  method:'get',
  responseType:'blob'
}).then(function(resp){
var headers = resp.headers;
var data = resp.data;
if(headers['content-type'].indexOf('json')>=0){
  var reader = new FileReader();
  reader.onload = function(){
   var json = JSON.parse(this.result);
   let {retCode,retMsg} = json;
   if(retCode!='200'){
    layer.msg(retMsg,{icon:2,zIndex:layer.zIndex})
   }
   reader.readAsText(data)
  }
}else{
     var fileName = headers['content-disposition'].math(/filename=(.*)/)[1];
     // 二进制流转换为blob
     var blob = new Blob([data],{type:'applicaiton/vdn.ms-excel;charset=utf-8'})
  if (typeof window.navigator.msSaveBlob !== 'undefined') {
      // 兼容IE，window.navigator.msSaveBlob：以本地方式保存文件
      window.navigator.msSaveBlob(blob, decodeURI(filename))
  }else{
     var blobURL = window.URL.createObjectURL(blob)
     var eleLink = document.createElement('a')
     eleLink.download = decodeURI(fileName);
     eleLink.href = blobURL;

     if(typeof eleLink.download === 'undefined'){
       // 兼容 某些浏览器不支持 html5 download 属性
       eleLink.setAttrribute('target','_blank');
     }
     document.body.appendChild(eleLink)
     eleLink.click();
     document.body.removeChild(eleLink)
     window.URL.revokeObjectURL(blobURL);
  }   
} 
})
 
```



# IntersectionObserver  

常常需要了解某个元素是否进入了"视口"（viewport），即用户能不能看到它。

​        [IntersectionObserver](https://github.com/w3c/IntersectionObserver)/**polyfill**/      

# [ES6](https://es6.ruanyifeng.com/)

https://babeljs.io/ 支持js新语法的编译器，在线运行js代码

## Promise

所谓`Promise`，简单说就是一个容器，里面保存着某个未来才会结束的事件（通常是一个异步操作）的结果。从语法上说，Promise 是一个对象，从它可以获取异步操作的消息。Promise 提供统一的 API，各种异步操作都可以用同样的方法进行处理。

（1）对象的状态不受外界影响。`Promise`对象代表一个异步操作，有三种状态：`pending`（进行中）、`fulfilled`（已成功）和`rejected`（已失败）。只有异步操作的结果，可以决定当前是哪一种状态，任何其他操作都无法改变这个状态。这也是`Promise`这个名字的由来，它的英语意思就是**“承诺”，表示其他手段无法改变**

（2）一旦状态改变，就不会再变，任何时候都可以得到这个结果。`Promise`对象的状态改变，只有两种可能：从`pending`变为`fulfilled`和从`pending`变为`rejected`。只要这两种情况发生，状态就凝固了，不会再变了，会一直保持这个结果，这时就称为 resolved（已定型）。如果改变已经发生了，你再对`Promise`对象添加回调函数，也会立即得到这个结果。这与事件（Event）完全不同，事件的特点是，如果你错过了它，再去监听，是得不到结果的。
为了行文方便，本章后面的`resolved`统一只指`fulfilled`状态，不包含`rejected`状态。

有了`Promise`对象，就可以将异步操作以同步操作的流程表达出来，避免了层层嵌套的回调函数。

`Promise`也有一些缺点。首先，无法取消`Promise`，**一旦新建它就会立即执行，无法中途取消**。其次，如果不设置回调函数，`Promise`内部抛出的错误，不会反应到外部。第三，当处于`pending`状态时，无法得知目前进展到哪一个阶段（刚刚开始还是即将完成）。

如果某些事件不断地反复发生，一般来说，使用 [Stream](https://nodejs.org/api/stream.html) 模式是比部署`Promise`更好的选择。

### 基本用法 [§](https://es6.ruanyifeng.com/#docs/promise#基本用法) [⇧](https://es6.ruanyifeng.com/#docs/promise)

ES6 规定，`Promise`对象是一个构造函数，用来生成`Promise`实例。
`Promise`构造函数接受一个函数作为参数，该函数的两个参数分别是`resolve`和`reject`。它们是两个函数，由 JavaScript 引擎提供，不用自己部署。

```javascript
const promise = new Promise(function(resolve, reject) {
  // ... some code

  if (/* 异步操作成功 */){
    resolve(value);
  } else {
    reject(error);
  }
});
```

`resolve`函数的作用是，将`Promise`对象的状态从“未完成”变为“成功”（即从 pending 变为 resolved），在异步操作成功时调用，并将异步操作的结果，作为参数传递出去；`Promise`实例生成以后，可以用`then`方法分别指定`resolved`状态和`rejected`状态的回调函数。

```javascript
promise.then(function(value) {
  // success
}, function(error) {
  // failure
});
```

```javascript
//用Promise对象实现的 Ajax 操作的例子
const getJSON = function(url) {
  const promise = new Promise(function(resolve, reject){
    const handler = function() {
      if (this.readyState !== 4) {
        return;
      }
      if (this.status === 200) {
        resolve(this.response);
      } else {
        reject(new Error(this.statusText));
      }
    };
    const client = new XMLHttpRequest();
    client.open("GET", url);
    client.onreadystatechange = handler;
    client.responseType = "json";
    client.setRequestHeader("Accept", "application/json");
    client.send();

  });

  return promise;
};

getJSON("/posts.json").then(function(json) {
  console.log('Contents: ' + json);
}, function(error) {
  console.error('出错了', error);
});
```



























# URLSearchParams

```
const query = new URLSearchParams();
query.append("a", 1);
query.append("b", 2);
const queryString = query.toString(); // "a=1&b=2"
const url = `https://www.abc.com?${query}`; // 将自动调用query的toString()方法

// current url: https://www.abc.com?a=1&b=2 
const query = new URLSearchParams(location.search);
query.get("a"); // "1"
query.get("b"); // "2" 
query.getAll("a"); // ["1"]

URLSearchParams.delete()从搜索参数列表里删除指定的搜索参数及其对应的值。
URLSearchParams.entries() 返回一个iterator可以遍历所有键/值对的对象。 
URLSearchParams.getAll() 获取指定搜索参数的所有值，返回是一个数组。 
URLSearchParams.has() 返回 Boolean 判断是否存在此搜索参数。 
URLSearchParams.keys() 返回iterator 此对象包含了键/值对的所有键名。 
URLSearchParams.set() 设置一个搜索参数的新值，假如原来有多个值将删除其他所有的值。 
URLSearchParams.sort() 按键名排序。 
URLSearchParams.toString() 返回搜索参数组成的字符串，可直接使用在URL上。
URLSearchParams.values() 返回iterator 此对象包含了键/值对的所有值。

兼容性较差
建议使用polyfill:https://github.com/WebReflection/url-search-params
```

# jquery 
.parent() 方法允许我们在 DOM 树中搜索这些元素的父元素，并用匹配元素构造一个新的 jQuery 对象。.parents() 和 .parent() 方法类似，不同的是后者沿 DOM 树向上遍历单一层级。

## index()
总是返回值为-1，可能是因为动态渲染的dom未加载完成。
```
<ul>
  <li id="foo">foo</li>
  <li id="bar">bar</li>
  <li id="baz">baz</li>
</ul>
var listItem = document.getElementById( "bar" );
alert( "Index: " + $( "li" ).index( listItem ) ); //1


var listItem = $( "#bar" );
alert( "Index: " + listItem.index( "li" ) );//1

alert( "Index: " + $( "#bar" ).index() );//1 
If we omit the argument, .index() will return the position of the first element within the set of matched elements in relation to its siblings:


```
$(this).text() === "hello";

## eq()
$('div:eq(0), div:eq(1), div:eq(5)')

## toogleClass()
toggleClass() 对设置或移除被选元素的一个或多个类进行切换。
$(selector).toggleClass(function(index,class),switch)
switch	可选。布尔值。规定是否添加(true)或移除(false)类。

# [Axios](http://www.kancloud.cn:8080/yunye/axios/234845)
是一个基于 promise 的 HTTP 库，可以用在浏览器和 node.js 中.
```
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
axios.post('/user', {
    firstName: 'Fred',
    lastName: 'Flintstone'
  })
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });

```
## 执行多个并发请求
```
function getUserAccount() {
  return axios.get('/user/12345');
}

function getUserPermissions() {
  return axios.get('/user/12345/permissions');
}

axios.all([getUserAccount(), getUserPermissions()])
  .then(axios.spread(function (acct, perms) {
    // 两个请求现在都执行完成
  }));
```
## axios(url[, config])
可以通过向 axios 传递相关配置来创建请求
```
axios({
  method: 'post',
  url: '/user/12345',
  data: {
    firstName: 'Fred',
    lastName: 'Flintstone'
  }
});
```
## 请求方法的别名
为方便起见，为所有支持的请求方法提供了别名

axios.request(config)
axios.get(url[, config])
axios.delete(url[, config])
axios.head(url[, config])
axios.post(url[, data[, config]])
axios.put(url[, data[, config]])
axios.patch(url[, data[, config]])
在使用别名方法时， url、method、data 这些属性都不必在配置中指定。
## 创建实例
```
var instance = axios.create({
  baseURL: 'https://some-domain.com/api/',
  timeout: 1000,
  headers: {'X-Custom-Header': 'foobar'}
});
```
以下是可用的实例方法。指定的配置将与实例的配置合并
axios#request(config)
axios#get(url[, config])
axios#delete(url[, config])
axios#head(url[, config])
axios#post(url[, data[, config]])
axios#put(url[, data[, config]])
axios#patch(url[, data[, config]])

## 请求配置
```
{
  // `url` 是用于请求的服务器 URL
  url: '/user',

  // `method` 是创建请求时使用的方法
  method: 'get', // 默认是 get

  // `baseURL` 将自动加在 `url` 前面，除非 `url` 是一个绝对 URL。
  // 它可以通过设置一个 `baseURL` 便于为 axios 实例的方法传递相对 URL
  baseURL: 'https://some-domain.com/api/',

  // `transformRequest` 允许在向服务器发送前，修改请求数据
  // 只能用在 'PUT', 'POST' 和 'PATCH' 这几个请求方法
  // 后面数组中的函数必须返回一个字符串，或 ArrayBuffer，或 Stream
  transformRequest: [function (data) {
    // 对 data 进行任意转换处理

    return data;
  }],

  // `transformResponse` 在传递给 then/catch 前，允许修改响应数据
  transformResponse: [function (data) {
    // 对 data 进行任意转换处理

    return data;
  }],

  // `headers` 是即将被发送的自定义请求头
  headers: {'X-Requested-With': 'XMLHttpRequest'},

  // `params` 是即将与请求一起发送的 URL 参数
  // 必须是一个无格式对象(plain object)或 URLSearchParams 对象
  params: {
    ID: 12345
  },

  // `paramsSerializer` 是一个负责 `params` 序列化的函数
  // (e.g. https://www.npmjs.com/package/qs, http://api.jquery.com/jquery.param/)
  paramsSerializer: function(params) {
    return Qs.stringify(params, {arrayFormat: 'brackets'})
  },

  // `data` 是作为请求主体被发送的数据
  // 只适用于这些请求方法 'PUT', 'POST', 和 'PATCH'
  // 在没有设置 `transformRequest` 时，必须是以下类型之一：
  // - string, plain object, ArrayBuffer, ArrayBufferView, URLSearchParams
  // - 浏览器专属：FormData, File, Blob
  // - Node 专属： Stream
  data: {
    firstName: 'Fred'
  },

  // `timeout` 指定请求超时的毫秒数(0 表示无超时时间)
  // 如果请求话费了超过 `timeout` 的时间，请求将被中断
  timeout: 1000,

  // `withCredentials` 表示跨域请求时是否需要使用凭证
  withCredentials: false, // 默认的

  // `adapter` 允许自定义处理请求，以使测试更轻松
  // 返回一个 promise 并应用一个有效的响应 (查阅 [response docs](#response-api)).
  adapter: function (config) {
    /* ... */
  },

  // `auth` 表示应该使用 HTTP 基础验证，并提供凭据
  // 这将设置一个 `Authorization` 头，覆写掉现有的任意使用 `headers` 设置的自定义 `Authorization`头
  auth: {
    username: 'janedoe',
    password: 's00pers3cret'
  },

  // `responseType` 表示服务器响应的数据类型，可以是 'arraybuffer', 'blob', 'document', 'json', 'text', 'stream'
  responseType: 'json', // 默认的

  // `xsrfCookieName` 是用作 xsrf token 的值的cookie的名称
  xsrfCookieName: 'XSRF-TOKEN', // default

  // `xsrfHeaderName` 是承载 xsrf token 的值的 HTTP 头的名称
  xsrfHeaderName: 'X-XSRF-TOKEN', // 默认的

  // `onUploadProgress` 允许为上传处理进度事件
  onUploadProgress: function (progressEvent) {
    // 对原生进度事件的处理
  },

  // `onDownloadProgress` 允许为下载处理进度事件
  onDownloadProgress: function (progressEvent) {
    // 对原生进度事件的处理
  },

  // `maxContentLength` 定义允许的响应内容的最大尺寸
  maxContentLength: 2000,

  // `validateStatus` 定义对于给定的HTTP 响应状态码是 resolve 或 reject  promise 。如果 `validateStatus` 返回 `true` (或者设置为 `null` 或 `undefined`)，promise 将被 resolve; 否则，promise 将被 rejecte
  validateStatus: function (status) {
    return status >= 200 && status < 300; // 默认的
  },

  // `maxRedirects` 定义在 node.js 中 follow 的最大重定向数目
  // 如果设置为0，将不会 follow 任何重定向
  maxRedirects: 5, // 默认的

  // `httpAgent` 和 `httpsAgent` 分别在 node.js 中用于定义在执行 http 和 https 时使用的自定义代理。允许像这样配置选项：
  // `keepAlive` 默认没有启用
  httpAgent: new http.Agent({ keepAlive: true }),
  httpsAgent: new https.Agent({ keepAlive: true }),

  // 'proxy' 定义代理服务器的主机名称和端口
  // `auth` 表示 HTTP 基础验证应当用于连接代理，并提供凭据
  // 这将会设置一个 `Proxy-Authorization` 头，覆写掉已有的通过使用 `header` 设置的自定义 `Proxy-Authorization` 头。
  proxy: {
    host: '127.0.0.1',
    port: 9000,
    auth: : {
      username: 'mikeymike',
      password: 'rapunz3l'
    }
  },

  // `cancelToken` 指定用于取消请求的 cancel token
  // （查看后面的 Cancellation 这节了解更多）
  cancelToken: new CancelToken(function (cancel) {
  })
}
```
## 配置的默认值/defaults
```
全局的 axios 默认值
axios.defaults.baseURL = 'https://api.example.com';
axios.defaults.headers.common['Authorization'] = AUTH_TOKEN;
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
自定义实例默认值
// 创建实例时设置配置的默认值
var instance = axios.create({
  baseURL: 'https://api.example.com'
});

// 在实例已创建后修改默认值
instance.defaults.headers.common['Authorization'] = AUTH_TOKEN;
```
## 响应结构
```
{
  // `data` 由服务器提供的响应
  data: {},

  // `status` 来自服务器响应的 HTTP 状态码
  status: 200,

  // `statusText` 来自服务器响应的 HTTP 状态信息
  statusText: 'OK',

  // `headers` 服务器响应的头
  headers: {},

  // `config` 是为请求提供的配置信息
  config: {}
}

axios.get('/user/12345')
  .then(function(response) {
    console.log(response.data);
    console.log(response.status);
    console.log(response.statusText);
    console.log(response.headers);
    console.log(response.config);
  });
```
## 拦截器
在请求或响应被 then 或 catch 处理前拦截它们。
```
// 添加请求拦截器
axios.interceptors.request.use(function (config) {
    // 在发送请求之前做些什么
    return config;
  }, function (error) {
    // 对请求错误做些什么
    return Promise.reject(error);
  });

// 添加响应拦截器
axios.interceptors.response.use(function (response) {
    // 对响应数据做点什么
    return response;
  }, function (error) {
    // 对响应错误做点什么
    return Promise.reject(error);
  });

如果你想在稍后移除拦截器，可以这样：
var myInterceptor = axios.interceptors.request.use(function () {/*...*/});
axios.interceptors.request.eject(myInterceptor);

为自定义 axios 实例添加拦截器
var instance = axios.create();
instance.interceptors.request.use(function () {/*...*/});
```
## 错误处理
```
axios.get('/user/12345')
  .catch(function (error) {
    if (error.response) {
      // 请求已发出，但服务器响应的状态码不在 2xx 范围内
      console.log(error.response.data);
      console.log(error.response.status);
      console.log(error.response.headers);
    } else {
      // Something happened in setting up the request that triggered an Error
      console.log('Error', error.message);
    }
    console.log(error.config);
  });
```

## 跨域
开发环境的话只需要在浏览器设置一下允许跨域就行了。
chrome拓展程序安装个小插件：Allow-Control-Allow-Origin: *

设置了 Access-Control-Allow-Origin:*
根据报错提示，你还需要添加 "Access-Control-Allow-Headers":"Authorization,Origin, X-Requested-With, Content-Type, Accept"来设置允许跨域的http请求头(具体根据你的代码来定)
类似的还有"Access-Control-Allow-Methods":"GET,POST"

## 使用示例
axios.get('../../basicTheme/figures.do',{params:param})//参数拼接到url中
axios.post('../../basicTheme/figures.do',param) //payload {}

# JS
## tag
new Date().getTime() 方法可返回距 1970 年 1 月 1 日之间的毫秒数。

var s = document.createElement("script");
s.type = "text/javascript";
s.src = "http://somedomain.com/somescript";
$("head").append(s);

## splice
array.splice(start[, deleteCount[, item1[, item2[, ...]]]])
通过删除或替换现有元素或者原地添加新的元素来修改数组,并以数组形式返回被修改的内容。此方法会改变原数组。
```
const months = ['Jan', 'March', 'April', 'June'];
months.splice(1, 0, 'Feb');
// inserts at index 1
console.log(months);
// expected output: Array ["Jan", "Feb", "March", "April", "June"]
```
## find 
find() 方法返回数组中满足提供的测试函数的第一个元素的值。否则返回 undefined。
```
const array1 = [5, 12, 8, 130, 44];

const found = array1.find(element => element > 10);

console.log(found);
// expected output: 12
```
findIndex() 找到索引

## Map has 
var myMap = new Map();
myMap.set("bar", "foo");
myMap.has("bar");  // returns true

hasOwnProperty

if ('X' in mmap)
{
    // ...
}


## Array map() 方法
map() 方法返回一个新数组，数组中的元素为原始数组元素调用函数处理后的值。
map() 方法按照原始数组元素顺序依次处理元素。
```
var numbers = [4, 9, 16, 25];

function myFunction() {
    x = document.getElementById("demo")
    x.innerHTML = numbers.map(Math.sqrt);
}
输出结果为:

2,3,4,5
```

data.map(item=>item.type=type); 不可以写成  data = data.map(item=>item.type=type);  map返回值undefined


## slice 
slice() 方法返回一个新的数组对象，这一对象是一个由 begin 和 end 决定的原数组的浅拷贝（包括 begin，不包括end）。原始数组不会被改变。
arr.slice([begin[, end]])


## ... 数组赋值
(...args)
es6 语法 多个变量赋值给args数组

快速声明一个数组，长度为 100，元素全是 0

var arr=new Array(100).fill(0);

shift() 方法从数组中删除第一个元素，并返回该元素的值。此方法更改数组的长度。



# dayjs
 unpkg.com/dayjs 
 dayjs()
 dayjs('2018-08-08') // parse

dayjs().format('{YYYY} MM-DDTHH:mm:ss SSS [Z] A') // display

dayjs().set('month', 3).month() // get & set

dayjs().add(1, 'year') // manipulate

dayjs().isBefore(dayjs()) // query

# 常用JS
dayjs


# chrome 
控制台可以测试使用页面中的函数，引用的第三方js


# echarts 
## tab切换内容的图形加载变形
```
    element.on('tab(rtTab)',function (data) {
        var index =data.index;
        //echarts 兼容处理
        $(".right1 .layui-tab-content .layui-tab-item ").eq(index).find('.chart>div').each(function(){
            var chartId = $(this).attr("id");
            var chart = echarts.getInstanceByDom(document.getElementById(chartId));
            chart.resize();
        })
    })
```



加减乘除 Addition, subtraction, multiplication and division






function onlyUnique(value, index, self) { 
    return self.indexOf(value) === index;
}

// usage example:
var a = ['a', 1, 'a', 2, '1'];
var unique = a.filter( onlyUnique ); // returns ['a', 1, 2, '1'] 