# [TypeScript](https://www.typescriptlang.org/docs/handbook/typescript-in-5-minutes.html)

```
function greeter(person: string) {
    return "Hello, " + person;
}
let user = "Jane User";
document.body.textContent = greeter(user);


interface Person {
    firstName: string;
    lastName: string;
}
function greeter(person: Person) {
    return "Hello, " + person.firstName + " " + person.lastName;
}
let user = { firstName: "Jane", lastName: "User" };
document.body.textContent = greeter(user);


class Student {
    fullName: string;
    constructor(public firstName: string, public middleInitial: string, public lastName: string) {
        this.fullName = firstName + " " + middleInitial + " " + lastName;
    }
}
interface Person {
    firstName: string;
    lastName: string;
}
function greeter(person: Person) {
    return "Hello, " + person.firstName + " " + person.lastName;
}
let user = new Student("Jane", "M.", "User");
document.body.textContent = greeter(user); 

```


# 快速上手》

```sh
npm install -g @angular/cli
ng new my-app
cd my-app
ng server --open // -o open browser,http://localhost:4200/
```

## 基本概念

Angular 是一个用 HTML 和 TypeScript 构建客户端应用的平台与框架。 Angular 本身就是用 TypeScript 写成的。它将核心功能和可选功能作为一组 TypeScript 库进行实现，你可以把它们导入你的应用中。

### 模块

Angular 的基本构造块是 *NgModule*，NgModule 为一个组件集声明了编译的上下文环境，它专注于某个应用领域、某个工作流或一组紧密相关的能力。 NgModule 可以将其组件和一组相关代码（如服务）关联起来，形成功能单元。

每个 Angular 应用都有一个*根模块*，通常命名为 `AppModule`。根模块提供了用来启动应用的引导机制。 一个应用通常会包含很多特性模块。比如，要在你的应用中使用路由器（Router）服务，就要导入 `Router` 这个 NgModule。

### 组件

`@Component()` 装饰器表明紧随它的那个类是一个组件，并提供模板和该组件专属的元数据。

#### 模板、指令和数据绑定

模板会把 HTML 和 Angular 的标记（markup）组合起来，这些标记可以在 HTML 元素显示出来之前修改它们。 模板中的*指令*会提供程序逻辑，而*绑定标记*会把你应用中的数据和 DOM 连接在一起。

数据绑定：事件绑定、属性绑定

Angular 支持*双向数据绑定*，这意味着 DOM 中发生的变化（比如用户的选择）同样可以反映回你的程序数据中。

模板也可以用*管道*转换要显示的值以增强用户体验。比如，可以使用管道来显示适合用户所在本地环境的日期和货币格式

### 服务与依赖注入

对于与特定视图无关并希望跨组件共享的数据或逻辑，可以创建*服务*类。 服务类的定义通常紧跟在 “@Injectable()” 装饰器之后。该装饰器提供的元数据可以让你的服务作为依赖*被注入到*客户组件中。

*依赖注入*（或 DI）让你可以保持组件类的精简和高效。有了 DI，组件就不用从服务器获取数据、验证用户输入或直接把日志写到控制台，而是会把这些任务委托给服务。

1. ### 路由

 `Router` 模块提供了一个服务，它可以让你定义在应用的各个不同状态和视图层次结构之间导航时要使用的路径。 它的工作模型基于人们熟知的浏览器导航约定。

# 模版语法

```jsx
// product-list.component.ts
export class ProductListComponent {
  products = products;

  share() {
    window.alert('The product has been shared!');
  }

  onNotify() { 
    window.alert('You will be notified when the product goes on sale');
  }
}
// product-list.component.html
<div *ngFor="let product of products">
  <h3>
    <a [title]="product.name + ' details'">
      {{ product.name }}
    </a>
  </h3>

  <p *ngIf="product.description">
    Description: {{ product.description }}
  </p>

  <button (click)="share()">
    Share
  </button>
  <app-product-alerts
  [product]="product"
  (notify)="onNotify()">
    >
</app-product-alerts>
</div>
```

*ngFor，这个 <div> 就会被列表中的每个商品都重复渲染一次。
`*ngFor` 是一个 "结构型指令"。结构型指令会通过添加、删除和操纵它们的宿主元素等方式塑造或重塑 DOM 的结构。带有星号 `*` 的指令都是结构型指令。

插值语法 `{{}}`。插值会把属性的值作为文本渲染出来。
属性绑定语法 `[]`  

 `*ngIf` 指令，这样 Angular 只会在当前商品有描述信息的情况下创建这个 `<p>` 元素。

事件绑定 `()`

  **product-alerts.component.ts**

```jsx
import { Component, OnInit } from '@angular/core';
import { Input } from '@angular/core'; 
import { Output, EventEmitter } from '@angular/core';
export class ProductAlertsComponent implements OnInit {
  @Input() product;
  @Output() notify = new EventEmitter();//发出notify事件，对应到父组件onNotify()
  constructor() { }

  ngOnInit() {
  } 
}
```

`@Input()` 装饰器指出其属性值是从该组件的父组件商品列表组件中传入的。

**product-alerts.component.html**

```
<p *ngIf="product.price > 700">
   <button (click)="notify.emit()">Notify Me</button>
</p>
```

# 路由

app.module.ts

```jsx
@NgModule({
  imports:[
   	BrowserModule,
    ReactiveFormsModule,
    RouterModule:forRoot([
     {path:'',component:ProductListComponent},
     {path:'products/:productId',component:ProductDetailsomponent}
  ])
  ]
})
```

product-list.component.html

```jsx
<div *ngFor="let product of products; index as productId">
	<a [title]="product.name +'details'" [routerLink]="['/products',productId]">
	{{ product.name }}
	</a>
</div>
```

Angular 的路由器会根据浏览器的 URL 和你定义的这些路由来决定如何显示组件。

product-detial.component

```jsx
import {Component,OnInit} from '@angular/core';
import {ActivatedRouter} from '@angular/router';
export class ProductDetailComponent implements onInit{
	 product;
   constructor(
  	 private route : ActivatedRouter 
  ){}
  ngOnInit(){
    this.route.paramMap.subscribe(params=>{
      this.product = products[+params.get('productId')];
    })
  }
}



```





```js
$('div:contains("test")').css('background-color', 'red');
```



```js
$("#iFrame").contents().find("#someDiv").removeClass("hidden");
```







# angular.cn

```
npm install -g @angular/cli
ng new learn-angular 
cd learn-angular
ng serve -o 
```

`ng serve` 命令会启动开发服务器、监视文件，并在这些文件发生更改时重建应用。

`--open`（或者只用 `-o` 缩写）选项会自动打开你的浏览器，并访问 `http://localhost:4200/`

# 主要概念

### 组件

#### 概览

组件是 Angular 应用的主要构造块。每个组件包括如下部分：

- 一个 HTML 模板，用于声明页面要渲染的内容
- 一个用于定义行为的 Typescript 类
- 一个 CSS 选择器，用于定义组件在模板中的使用方式,  
- （可选）要应用在模板上的 CSS 样式

```shell
ng generate component app-hello-world
```

默认情况下，该命令会创建以下内容：

- 一个以该组件命名的文件夹
- 一个组件文件 `<component-name>.component.ts`
- 一个模板文件 `<component-name>.component.html`
- 一个 CSS 文件， `<component-name>.component.css`
- 测试文件 `<component-name>.component.spec.ts`

```
@Component({
  selector: 'app-component-overview',
  templateUrl: './component-overview.component.html',
  	或者	template: `<h1>Hello World!</h1>
               <p>This template definition spans
                multiple lines.</p>`
  styleUrls: ['./component-overview.component.css']
   或者   styles: ['h1 { font-weight: normal; }']
})
export class AppHelloWorld {

}
```

  当 `<app-hello-world>` 出现在模板中时，这个选择器就会让 Angular 使用AppHelloWorld组件类来实例化。

### 生命周期钩子

当 Angular 实例化组件类并渲染组件视图及其子视图时，组件实例的生命周期就开始了。生命周期一直伴随着变更检测，Angular 会检查数据绑定属性何时发生变化，并按需更新视图和组件实例。当 Angular 销毁组件实例并从 DOM 中移除它渲染的模板时，生命周期就结束了。当 Angular 在执行过程中创建、更新和销毁实例时，指令就有了类似的生命周期。

##### 响应生命周期事件

 Angular `core` 库中定义了*生命周期钩子*接口来响应组件或指令生命周期中的事件

 每个接口都有唯一的一个钩子方法，它们的名字是由接口名再加上 `ng` 前缀构成的。比如，`OnInit` 接口的钩子方法叫做 `ngOnInit()`。

`ngOnInit() ` ,Angular 就会在首次检查完组件或指令的输入属性后，紧接着调用它。

```
@Directive()
export. class PeekABooDirective implements OnInit{
	constructor(private logger:LoggerService){}
	ngOnInit(){
		this.logIt(`OnInit`);
	}
	logIt(msg:string){
		this.logger.log(`#${nextId++} ${msg}`)
	}
}
```



##### 生命周期的顺序

Angular 会按以下顺序执行钩子方法

| 钩子方法                  | 用途                                                         | 时机                                                         |
| :------------------------ | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `ngOnChanges()`           | 当 Angular 设置或重新设置数据绑定的输入属性时响应。 该方法接受当前和上一属性值的 `SimpleChanges` 对象注意，这发生的非常频繁，所以你在这里执行的任何操作都会显著影响性能。 欲知详情，参阅本文档的[使用变更检测钩子](https://angular.cn/guide/lifecycle-hooks#onchanges)。 | 在 `ngOnInit()` 之前以及所绑定的一个或多个输入属性的值发生变化时都会调用。注意，如果你的组件没有输入，或者你使用它时没有提供任何输入，那么框架就不会调用 `ngOnChanges()`。 |
| `ngOnInit()`              | 在 Angular 第一次显示数据绑定和设置指令/组件的输入属性之后，初始化指令/组件。 欲知详情，参阅本文档中的[初始化组件或指令](https://angular.cn/guide/lifecycle-hooks#oninit)。 | 在第一轮 `ngOnChanges()` 完成之后调用，只调用**一次**。      |
| `ngDoCheck()`             | 检测，并在发生 Angular 无法或不愿意自己检测的变化时作出反应。 欲知详情和范例，参阅本文档中的[自定义变更检测](https://angular.cn/guide/lifecycle-hooks#docheck)。 | 紧跟在每次执行变更检测时的 `ngOnChanges()` 和 首次执行变更检测时的 `ngOnInit()` 后调用。 |
| `ngAfterContentInit()`    | 当 Angular 把外部内容投影进组件视图或指令所在的视图之后调用。欲知详情和范例，参阅本文档中的[响应内容中的变更](https://angular.cn/guide/lifecycle-hooks#aftercontent)。 | 第一次 `ngDoCheck()` 之后调用，只调用一次。                  |
| `ngAfterContentChecked()` | 每当 Angular 检查完被投影到组件或指令中的内容之后调用。欲知详情和范例，参阅本文档中的[响应被投影内容的变更](https://angular.cn/guide/lifecycle-hooks#aftercontent)。 | `ngAfterContentInit()` 和每次 `ngDoCheck()` 之后调用         |
| `ngAfterViewInit()`       | 当 Angular 初始化完组件视图及其子视图或包含该指令的视图之后调用。欲知详情和范例，参阅本文档中的[响应视图变更](https://angular.cn/guide/lifecycle-hooks#afterview)。 | 第一次 `ngAfterContentChecked()` 之后调用，只调用一次。      |
| `ngAfterViewChecked()`    | 每当 Angular 做完组件视图和子视图或包含该指令的视图的变更检测之后调用。 | `ngAfterViewInit()` 和每次 `ngAfterContentChecked()` 之后调用。 |
| `ngOnDestroy()`           | 每当 Angular 每次销毁指令/组件之前调用并清扫。 在这儿反订阅可观察对象和分离事件处理器，以防内存泄漏。 欲知详情，参阅本文档中的[在实例销毁时进行清理](https://angular.cn/guide/lifecycle-hooks#ondestroy)。 | 在 Angular 销毁指令或组件之前立即调用。                      |

#####  初始化组件或指令

使用 `ngOnInit()` 方法执行以下初始化任务。

- 在构造函数外部执行复杂的初始化。组件的构造应该既便宜又安全。比如，你不应该在组件构造函数中获取数据。当在测试中创建组件时或者决定显示它之前，你不应该担心新组件会尝试联系远程服务器。`ngOnInit()` 是组件获取初始数据的好地方。

- 在 Angular 设置好输入属性之后设置组件。构造函数应该只把初始局部变量设置为简单的值。

  请记住，只有*在构造完成之后*才会设置指令的数据绑定输入属性。如果要根据这些属性对指令进行初始化，请在运行 `ngOnInit()` 时设置它们。

`ngOnChanges()` 方法是你能访问这些属性的第一次机会。Angular 会在调用 `ngOnInit()` 之前调用 `ngOnChanges()`，而且之后还会调用多次。但它只调用一次 `ngOnInit()`。

##### 在实例销毁时进行清理

把清理逻辑放进 `ngOnDestroy()` 中，这个逻辑就必然会在 Angular 销毁该指令之前运行。

这里是释放资源的地方，这些资源不会自动被垃圾回收。如果你不这样做，就存在内存泄漏的风险。

- 取消订阅可观察对象和 DOM 事件。
- 停止 interval 计时器。
- 反注册该指令在全局或应用服务中注册过的所有回调。

`ngOnDestroy()` 方法也可以用来通知应用程序的其它部分，该组件即将消失。

### 视图包装

通过在组件的元数据上设置*视图封装模式*，你可以分别控制*每个组件*的封装模式。

```
src/app/quest-summary.component.ts
// warning: few browsers support shadow DOM encapsulation at this time
encapsulation: ViewEncapsulation.ShadowDom
```

- `ShadowDom` 模式使用浏览器原生的 Shadow DOM 实现（参阅 [MDN](https://developer.mozilla.org/) 上的 [Shadow DOM](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Shadow_DOM)）来为组件的宿主元素附加一个 Shadow DOM。组件的视图被附加到这个 Shadow DOM 中，组件的样式也被包含在这个 Shadow DOM 中。(译注：不进不出，没有样式能进来，组件样式出不去。)

- `Emulated` 模式（**默认值**）通过预处理（并改名）CSS 代码来模拟 Shadow DOM 的行为，以达到把 CSS 样式局限在组件视图中的目的。(译注：只进不出，全局样式能进来，组件样式出不去)

  **查看生成的css**
  在启用了仿真模式的 Angular 应用的 DOM 树中，每个 DOM 元素都被加上了一些额外的属性。

  ```
  <hero-details _nghost-pmm-5>
    <h2 _ngcontent-pmm-5>Mister Fantastic</h2>
    <hero-team _ngcontent-pmm-5 _nghost-pmm-6>
      <h3 _ngcontent-pmm-6>Team</h3>
    </hero-team>
  </hero-detail>
  ```

  一个元素在原生封装方式下可能是 Shadow DOM 的宿主，在这里被自动添加上一个 `_nghost` 属性。组件视图中的每一个元素，都有一个 `_ngcontent` 属性，它会标记出该元素属于哪个宿主的模拟 Shadow DOM。

  这些属性的具体值并不重要。它们是自动生成的，并且你永远不会在程序代码中直接引用到它们。 但它们会作为生成的组件样式的目标，就像 DOM 的 `<head>` 中一样：

  ```
  [_nghost-pmm-5] {
    display: block;
    border: 1px solid black;
  }
  
  h3[_ngcontent-pmm-6] {
    background-color: white;
    border: 1px solid #777;
  }
  ```

  每个选择器都被增加了 `_nghost` 或 `_ngcontent` 属性选择器。 这些额外的选择器实现了本文所描述的这些作用域规则。

- `None` 意味着 Angular 不使用视图封装。 Angular 会把 CSS 添加到全局样式中。而不会应用上前面讨论过的那些作用域规则、隔离和保护等。 从本质上来说，这跟把组件的样式直接放进 HTML 是一样的。(译注：能进能出。)

### 组件交互

1. 通过@Input把数据从父组件传到子组件

   ```
   //hero-parent.components.ts
   @Component({
   	 selector:'app-hero-parent',
   	 template:`
   	 		<h2>{{master}} controls {{heroes.length}} heroes</h2>
   			<app-hero-child *ngFor="let hero of heroes" [hero]="hero" [master]="master"></app-hero-child>
   	 `
   })
   export class HeroParentComponent{
   	 heroes = HEROES;
   	 master = 'Master';
   }
   
   //hero-child.compoonent.ts
   @Component({
   	selector:'app-hero-child',
   	template:`
   		<h3>{{hero.name}} says:</h3>
   		<p>I,{{hero.name}} , am at your service,{{master}}.</p>
   	`
   })
   export class HeroChildComponent{
     @Input hero:Hero;
     @Input('master') master:string;
   }
   ```

2. 通过set监听@Input输入属性值的变化

   //对输入值进行处理，赋给其他变量

   ```
   @Component({
   	selector:'app-name-child',
   	template:'<h3>"{{_name}}"</h3>'
   })
   export class NameChildComponent{
   	@Input()
   	get name():string {return this._name}
   	set name(name:string){
   		this._name=(name && name.trim()) || '<no name set>';
   	}
   	
   	private _name='';
   }
   
   <app-name-child *ngFor="let name of names" [name]="name"></app-name-child>
   ```

3. 通过ngOnChanges()监听多个输入属性的变化
   //监听输入属性变化做些额外处理：记录日志...

   ```
   //version-child.component.ts
   import {Component,Input,OnChanges,SimpleChanges} from '@angular/core';
   @Component({
   	selector:'app-version-child',
   	template:`
   			<h3>Version {{major}}.{{minor}}</h3>
   			<h4>Change log:</h4>
   			<ul>
   				<li *ngFor="let change of changeLog">{{change}}</li>
   			</ul>
   	`
   })
   export class VersionChildComponent implements OnChanges{
   	@Input() major: number;
   	@Input() minor: number;
   	changeLog: string[] = [];
   	ngOnChanges(changes:SimpleChanges){
   		const log: string[] =[];
   		for(const propName in changes){
   			const changeProp = changes[propName];
   			const  to = JSON.stringify(changeProp.currentValue);
   			if(changedProp.isFirstChange()){
   				log.push(`Initial value of ${propName} set to ${to}`)
   			}else{
   				const from = JSON.stringify(changeProp.previousValue);
   				log.push(`${propName} changed from ${from} to ${to}`)
   			}
   		}
   		this.changeLog.push(log.join(','))
   	}
   }
   
   //version-parent.component.ts
   @Component({
   	selector:'app-version-parent',
   	template:`
   		<h2>Source code version</h2>
   		<button (click)="newMinor()">New minor version</button>
   		<button (click)="newMajor()">New major version</button>>
   		<app-version-child [major]="major" [minor]="minor"></app-version-child>
   	`
   })
   expoert class VersionParentComponent{
   	major =1;
   	minor = 23;
   	newMinor(){
   		this.minor++
   	}
   	newMajor(){
   		this.major++
   		this.minor=0
   	}
   }
   ```

4. 父组件监听子组件的**事件** 

   // 子 =》父 

   子组件暴露一个 `EventEmitter` 属性，当事件发生时，子组件利用该属性 `emits`(向上弹射)事件。父组件绑定到这个事件属性，并在事件发生时作出回应。

   子组件的 `EventEmitter` 属性是一个**输出属性**，通常带有[@Output 装饰器](https://angular.cn/guide/inputs-outputs#output)，

   ```
   //voter.component.ts
   import {Component,EventEmitter,Input,Output} from '@angular/core';
   @Component({
   	selector:'app-voter',
   	template:`
   		<h4>{{name}}</h4>
   		<button (click)="vote(true)" [disabled]="didVote">Agree</button>
   		<button (click)="vote(false)" [disabled]="didVote">Disagree</button>
   	`
   })
   export class VoterComponentj{
   	@Input() name:string
   	@Output() voted = new EventEmitter<boolean>()
   	
   	private didVote = false;
   	vote(agreed: boolean){
   		this.voted.emit(agreed)
   		this.didVote = true;
   	}
   }
   
   //votetaker.component.ts
   @Component({
   	selector:'app-vote-taker',
   	template:`
   		<h2>Should mankind colonize the Universe?</h2>
   		<h3>Agreed:{{agreed}}人, Disagree:{{disagreed}} 人
   		<app-voeter *ngFor="let voter of voters" [name]="voter" 
   						(voted)="onVoted($event)"></app-voter>
   	`;        //(自定义事件,子组件同名@Output事件名)
   })
   export class VoteTakerComponent{
   	agreed = 0;
   	disagreed =0 ;
   	voters =['Narco','Celeritas','Bombasto'];
   	onVoted(agreed: boolean){
   		agreed? this.agreed++ : this.diagereeed++;
   	}
   }
   ```

   

5. **父组件通过模版**本地变量与子组件互动

   //在父组件的模板中访问子组件的所有属性和方法。
   父组件不能使用数据绑定来读取子组件的属性或调用子组件的方法。但可以在父组件模板里，新建一个本地变量来代表子组件，然后利用这个变量来读取子组件的属性和调用子组件的方法

   ```
   //countdown-timer.component.ts
   @Component({
   	selector:'app-countdown-timer',
   	template:'<p>{{message}}</p>'
   })
   export class CountdownTimerComponent implements OnDestroy{
   	 intervalId = 0;
   	 message =''
   	 seconds = 11;
   	 
   	 ngOnDestroy(){this.clearTimer();}
   	 start(){this.countDown();}
   	 stop(){
   	 	this.clearTimer();
   	 	this.message=`Holding at T-${{this.seconds}} seconds`
   	 }
   	 private clearTime(){clearInterval(this.intervalId)}
   	 private countDown(){
   	 	this.clearTime();
   	 	this.intervalId = window.setInterval(()=>{
   	 		this.second -= 1;
   	 		if(this.second === 0){
   	 			this.message = 'Blast off!'
   	 		}else{
   	 			if(this.seconds <0){this.seconds = 10; }//reset
   	 			this.message = `T-${{this.seconds}} seconds and counting`
   	 		}
   	 	},1000)
   	 }
   }
   
   
   //countdown-parent.component.ts
   @Component({
   	selector :'app-countdown-parent-lv',
   	template:`
   		<button (click)="timer.start()">start</button>
   		<button (click)="timer.stop()">stop</button>
   		<div class="seconds">{{timer.seconds}}</div>
   		<app-countdown-timer #timer></app-countdown-timer>
   	`
   	styleUrls:['../assets/demo.css']
   })
   export class CountdownParentComponent{}
   ```

6. 父组件调用@ViewChild()

   如果父组件的*类*需要读取子组件的属性值或调用子组件的方法，就不能使用*本地变量*方法。
   当父组件*类*需要这种访问时，可以把子组件作为 *ViewChild*，***注入\***到父组件里面。

   ```
   //countdown-parent.component.ts
   @Component({
   	selector:'app-countdown-parent-vc',
   	template:`
   		<button (click)="start()">start</button>
   		<button (click)="stop()">stop</button>
   		<div class="seconds">{{seconds()}}</div>
   		<app-countdown-timer></app-countdown-timer>
   	`
   })
   export class CountdownParentComponent implements AfterViewInit{
   	@ViewChild(CountdownTimerComponent)
   	private timeComponent: CountdownTimerComponent;
   	
   	seconds(){return 0;}
   	ngAfterViewInit(){
   		setTimeout(()=>{
   			this.seconds= ()=> this.timerComponent.seconds;
   		},0)
   	}
   	start(){this.timerComponent.start()}
   	stop(){this.timerComponent.stop()}
   }
   ```

   `ngAfterViewInit()` 生命周期钩子是非常重要的一步。被注入的计时器组件只有在 Angular 显示了父组件视图之后才能访问，所以它先把秒数显示为 0.

   然后 Angular 会调用 `ngAfterViewInit` 生命周期钩子，但这时候再更新父组件视图的倒计时就已经太晚了。Angular 的单向数据流规则会阻止在同一个周期内更新父组件视图。应用在显示秒数之前会被迫*再等一轮*。

   使用 `setTimeout()` 来等下一轮，然后改写 `seconds()` 方法，这样它接下来就会从注入的这个计时器组件里获取秒数的值。

7. 父组件和子组件通过service服务来通讯

   父组件和它的子组件共享同一个服务，利用该服务*在组件家族内部*实现双向通讯。

   该服务实例的作用域被限制在父组件和其子组件内。这个组件子树之外的组件将无法访问该服务或者与它们通讯。

   ```
   //misson.service.ts
   import {Injectable} from '@angular/core'
   import {Subject} from 'rxjs'
   
   @Injectable()
   export class MissonService{
   	//Observable string sources
   	private missionAnnoucedSource = new Subject<string>();
   	private misssonConfirmedSource = new Subject<string>();
   	//Observable string streams
   	missionAnnouced$ = this.missionANnoucedSource.asObservable();
   	missionConfirmed$ = this.missionConfirmedSource.asObservable();
   	//service message command
   	announcMission(mission: string){
   		this.missionAnnouncedSource.next(mission);
   	}
   	confirmMission(astronaut: string){
   		this.missionConfirmedSource.next(astronaut)
   	}
   }
   ```

   ```
   //mission-control.component.ts
   import {MissionService} from './mission.service';
   @Component({
   	selector:'app-mission-control',
   	template:`
   		<h2>Misson Control</h2>
   		<button (click)="annouce()">Annouce mission</button>
   		<app-astronaut *ngFor="let astronaut of astronauts"
   			[astronaut]="astronaut"></app-astronaut>
   		<h3>History</h3>
   		<ul>
   			<li *ngFor="let event of history">{{event}}</li>
   		</ul>
   	`,
   	provider:[MissionService]
   })
   export class MissionControlComponent{
   	astronauts = ['Lovell','Swigert','Haise'];
   	history: string[] = [];
   	mission=['Fly to the moon','Fly to the Mars','Fly to Vegas!'];
   	nextMission= 0;
   	
   	constructor(private missionService: MissionService){
   		missionService.missionConfirmed$.subscribe(
   			astronaut=>{this.hisotry.push(`${astronaut} confirmed the mission`)}
   		)
   	}
   	
   	annouce(){
   		const mission = this.missions[this.nextMission++];
   		this.missionService.annouceMission(mission);
   		this.history.push(`Mission "${mission}" annouced`);
   		if(this.nextMission >= this.mission.length){this.nextMission = 0;}
   	}
   }
   ```

   ```
   //astronaut.components.ts
   import {MissionService} from './mission.service'
   import {Subscription} from 'rxjs'
   @Component({
   	selector:'app-astronaut',
   	template:`
   		<p>{{astronaut}}:<strong>{{mission}}</strong>
   		<button (click)="confirm()" [disabled]="!annouced || confirmed">confirm</button>
   		</p>
   	`
   })
   export class AstronautComponent implements OnDestory{
   	@Input() astronaut: string;
   	mission = '<no mission annouced'
   	confirmed = false;
   	annouced =false
   	subscription: Subscription
   	constructor(private missionService:MissionService){
   		this.subscription = missionService.missionAnnouced$.subscribe(
   			mission =>{
   				this.mission = mission;
   				this.annouced = true;
   				this.confirmed = false
   			}
   		)
   	}
   	confirm(){
   		this.confirmed = true;
   		this.missionService.confrimMission(this.astronaut)
   	}
   	ngOnDestroy(){
   		//prevent memory leak when compoonent destroyed
   		this.subscription.unsubscribe();
   	}
   }
   ```

   不需要在 `MissionControlComponent` 中添加这个unsubscribe()保护措施，因为它作为父组件，控制着 `MissionService` 的生命期。

### 组件样式

 Angular 应用使用标准的 CSS 来设置样式。这意味着你可以把关于 CSS 的那些知识和技能直接用于 Angular 程序中，例如：样式表、选择器、规则以及媒体查询等。

另外，Angular 还能把*组件样式*捆绑在组件上，以实现比标准样式表更加模块化的设计。

在 `@Component` 的元数据中指定的样式只会对该组件的模板生效。它们既不会被模板中嵌入的组件继承，也不会被通过内容投影（如 ng-content）嵌进来的组件继承。

这种范围限制就是所谓的***样式模块化\***特性

- 可以使用对每个组件最有意义的 CSS 类名和选择器。
- 类名和选择器是局限于该组件的，它不会和应用中其它地方的类名和选择器冲突。
- 组件的样式*不会*因为别的地方修改了样式而被意外改变。
- 你可以让每个组件的 CSS 代码和它的 TypeScript、HTML 代码放在一起，这将促成清爽整洁的项目结构。
- 将来你可以修改或移除组件的 CSS 代码，而不用遍历整个应用来看它有没有在别处用到。

#### 特殊的选择器

:host伪类选择器，用来选择组件*宿主*元素中的元素（相对于组件模板*内部*的元素）。

`:host` 选择是是把宿主元素作为目标的*唯一*方式。除此之外，你将没办法指定它， 因为**宿主不是组件自身模板的一部分，而是父组件模板的一部分。**

```
//hero-details.component.css
:host {
  display: block;
  border: 1px solid black;
}

//宿主元素只有当它同时带有 active CSS 类的时候才会生效
:host(.active) {
  border-width: 3px;
}
```

 `:host-context()` 伪类选择器 ，在当前组件宿主元素的*祖先节点*中查找 CSS 类， 直到文档的根节点为止。

```
:host-context(.theme-light) h2 {
  background-color: #eef;
}
```

只有当某个祖先元素有 CSS 类 `theme-light` 时，才会把 `background-color` 样式应用到组件*内部*的所有 `<h2>` 元素中。

#### 把样式加载进组件中

ng generate component hero-app --inline-style 定义一个空的 `styles` 数组

可以组合使用 `style` 和 `styleUrls` 

##### HTML 模板中写 `<link>` 标签

```
  template: `
    <!-- We must use a relative URL so that the AOT compiler can find the stylesheet -->
    <link rel="stylesheet" href="../assets/hero-team.component.css">
```

**利用标准的 CSS [`@import` 规则](https://developer.mozilla.org/en/docs/Web/CSS/@import)来把其它 CSS 文件导入到 CSS 文件中。**

src/app/hero-details.component.css (excerpt)

```
/* The AOT compiler needs the `./` to show that this is local */
@import './hero-details-box.css';
```

##### 外部以及全局样式文件

当使用 CLI 进行构建时，你必须配置 `angular.json` 文件，使其包含*所有外部资源*（包括外部的样式表文件）。

在它的 `styles` 区注册这些**全局**样式文件，默认情况下，它会有一个预先配置的全局 `styles.css` 文件。

##### 非 CSS 样式文件

如果使用 CLI 进行构建，那么你可以用 [sass](http://sass-lang.com/)、[less](http://lesscss.org/) 或 [stylus](http://stylus-lang.com/) 来编写样式，并使用相应的扩展名（`.scss`、`.less`、`.styl`）把它们指定到 `@Component.styleUrls` 元数据中

```
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
```

CLI 的构建过程会运行相关的预处理器。

 `ng generate component` 命令生成组件文件时，CLI 会默认生成一个空白的 CSS 样式文件（`.css`）。 你可以配置 CLI，让它默认使用你喜欢的 CSS 预处理器。



### 父子组件、指令之间共享数据

```
<label>Add an item: <input #newItem></label>
<button (click)="addNewItem(newItem.value)">Add to parent's list</button>
```

 同时使用 `@Input()` 和 `@Output()`

```
<app-input-output [item]="currentItem" (deleteRequest)="crossOffItem($event)"></app-input-output>
```

想用“盒子里的香蕉” `[()]` 语法来组合属性和事件绑定，参阅[双向绑定](https://angular.cn/guide/two-way-binding)。

### 动态组件加载器

组件的模板不会永远是固定的。应用可能会需要在运行期间加载一些新的组件。

下面的例子展示了如何构建动态广告条。





一个是 UI 库（React），另一个是成熟的前端框架（Angular），而其中最年轻的（Vue）则可以称之为渐进式框架。

