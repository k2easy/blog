# Install

TypeScript extends JavaScript by adding types.
TypeScript 编译生成javascript代码

```shell
npm install -g typescript //npm upgrade -g typescript
npx tsc //run complier via tsc 
```

https://www.typescriptlang.org/docs/

Types by Inference ,简单类型可以自动推导，复杂类型需明确

```javascript
let helloWorld = "Hello World";
	// ^ = let helloWorld : string 
```

Defining Types ,定义类型

```
interface User{
  name : string;
  id : number;
}
const user : User={
  name :"Hiar",
  id:0,
}
```

```
class UserAccount {
   name : stringt;
   id :number;
   
   construcotr(name : string, id :number){
   		this.name = name;
   		this.id = id;
   }
}
const user :User = new UserAccount("Tom",1);
```

//某个实例实现了interface内的所有字段，就是该类型

定义返回值类型

```
function getAdminUser(): User {
  //...
}
function deleteUser(user: User) {}
```

js内置类型：`boolean`, `bigint`, `null`, `number`, `string`, `symbol`, `object`, undefined
typescript 扩展类型：`any` (allow anything), [`unknown`](https://www.typescriptlang.org/play#example/unknown-and-never) (ensure someone using this type declares what the type is), [`never`](https://www.typescriptlang.org/play#example/unknown-and-never) (it’s not possible that this type could happen), and `void` (a function which returns `undefined` or has no return value).

You should prefer `interface`. Use `type` when you need specific features.

## Composing Types

###  Unions

```
type MyBool = true | false; // either true or false
type WindowStates = "open" | "closed" | "minimized";
type LockStates = "locked" | "unlocked";
type OddNumbersUnderTen = 1 | 3 | 5 | 7 | 9;

function getLength(obj: string | string[]) {
  return obj.length;
}
```

 **typeof**

| string    | `typeof s === "string"`            |
| --------- | ---------------------------------- |
| number    | `typeof n === "number"`            |
| boolean   | `typeof b === "boolean"`           |
| undefined | `typeof undefined === "undefined"` |
| function  | `typeof f === "function"`          |
| array     | `Array.isArray(a)`                 |

### Generics

An array without generics could contain anything. An array with generics can describe the values that the array contains.

```
type StringArray = Array<string>;
type NumberArray = Array<number>;
type ObjectWithNameArray = Array<{name:string}>;
```



```
interface Backpack<Type>{
  add :(obj:Type) => void;
  get: ()=> Type;
}

//tell ts there is a const 'backpack', not worry about where it came from   
declare const backpack: Backpack<string>;

const object = backpack.get();// object is a string 
```

### Structural Type System

One of TypeScript’s core principles is that type checking focuses on the *shape* that values have. This is sometimes called “duck typing” or “structural typing”.

In a structural type system, if two objects have the same shape, they are considered to be of the same type.

```typescript
interface Point {
  x :number;
  y:number;
}
function printPoint(p:Point){
  console.log(`${p.x},{p.y}`)
}
const point = {x:12,y:16}
printPoint(point)
//TypeScript compares the shape of point to the shape of Point in the type-check. They have the same shape, so the code passes.

//The shape-matching only requires a subset of the object’s fields to match.

const point3 = { x: 12, y: 26, z: 89 };
printPoint(point3); // prints "12, 26"
```

There is no difference between how classes and objects conform to shapes:

If the object or class has all the required properties, TypeScript  will say they match, regardless of the implementation details.



### Examples

[ts playground examples](https://www.typescriptlang.org/play?#code/C4TwDgpgBAsiBCB7RAbKBeKwBOBXaAPlAGYCGKAzhANxA)



pop() 方法从数组中删除最后一个元素，并返回该元素的值。此方法更改数组的长度。mutate函数。


```
// Creates a readonly array of purchase orders
const readonlyOrders: readonly PurchaseOrder[] = [purchaseOrder];
```

```
const add1 = (x: any, y: any) => {
  return x + y;
};

const add4 = (x: number, y: number): number => {
  return x + y;
};
```

```
const users = [{ name: "Ahmed" }, { name: "Gemma" }, { name: "Jon" }];
const jon = users.find((u) => u.name === "jon");//string|undefined
```



## Handbook

### Basic Type

#### **Tuple**

an array with a fixed number of elements whose types are known, but need not be the same. 

```
let x: [string, number];
// Initialize it
x = ["hello", 10]; // OK
```

####  **Enum**

```
enum Color {
  Red,  //默认0 开始递增 ，可以自定义
  Green,// 1
  Blue, // 2
}
let c: Color = Color.Green;

enum Color {
  Red = 1,
  Green,
  Blue,
}
let colorName: string = Color[2]; //'Green'

enum Color {
  Red = 1,
  Green = 2,
  Blue = 4,
}
```

#### **Unkown**

dynamic content – e.g. from the user – or we may want to intentionally accept all values in our API.

```
let notSure: unknown = 4;
notSure = "maybe a string instead";

// OK, definitely a boolean
notSure = false;
```

#### **Any**

适用于之前没有使用ts或第三方代码库 集成时

Unlike `unknown`, variables of type `any` allow you to access arbitrary properties, even ones that don’t exist. These properties include functions and TypeScript will not check their existence or type:

```javascript
let looselyTyped: any = 4;
// OK, ifItExists might exist at runtime
looselyTyped.ifItExists();
// OK, toFixed exists (but the compiler doesn't check)
looselyTyped.toFixed();

let strictlyTyped: unknown = 4;
strictlyTyped.toFixed();
Object is of type 'unknown'.
```

The `any` will continue to propagate through your objects:

```
let looselyTyped: any = {};
let d = looselyTyped.a.b.c.d;
//  ^ = let d: any
```

#### **void**

Declaring variables of type `void` is not useful because you can only assign `null` (only if `--strictNullChecks` is not specified) or `undefined` to them:

```
let unusable : void  = undefined;
等价于 
let unusable  = null ;// undefined;
```

####  Null and Undefined

#### Never

这个值绝对不可能是这个类型

 `never` is the return type for a function expression or an  arrow function expression that always throws an exception or one that  never returns.

函数抛出异常 绝对不会停止 不会有正常返回值

```javascript
function error(message: string): never {
  throw new Error(message);
}


// Inferred return type is never
function fail() {
  return error("Something failed");
}

// Function returning never must not have a reachable end point
function infiniteLoop(): never {
  while (true) {}
}		
```

### Interfaces

#### Optional Properties

可选属性

```
interface SquareConfig {
  color?: string;
  width?: number;
}
```

**Readonly Properties**

```
interface Point {
  readonly x: number;
  readonly y: number;
}
```

```
let a: number[] = [1, 2, 3, 4];
let ro: ReadonlyArray<number> = a;

a = ro as number[]; //type assert
```

 

Variables use `const` whereas properties use `readonly`.



#### Excess Property Checks

excess 过度

暂停 
https://www.typescriptlang.org/docs/handbook/interfaces.html



