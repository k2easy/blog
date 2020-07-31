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
# go101
##  快速上手

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

### 路由

 `Router` 模块提供了一个服务，它可以让你定义在应用的各个不同状态和视图层次结构之间导航时要使用的路径。 它的工作模型基于人们熟知的浏览器导航约定





































 