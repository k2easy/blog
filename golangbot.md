# 资源

facebook ent ，orm 框架

https://github.com/ardanlabs/gotraining-studyguide



# golangbot.com》

# Introduction  install

*Go* also known as *Golang* is an open source, compiled and statically typed programming language developed by Google. 
Go is a general-purpose programming language with a simple syntax and is backed by a robust standard library. One of the key areas where Go  shines is the creation of highly available and scalable web apps. Go can also be used to create command-line applications, desktop apps and even mobile applications.

  **Simple syntax**

The syntax is simple and concise and the language is not bloated with unnecessary features. 

 **Easy to write concurrent programs**

[Concurrency](https://golangbot.com/concurrency/) is an inherent part of the language. 

**Compiled language**

The source code is compiled to a native binary. 

**Fast compilation**

**Static linking**

The entire Go project can be statically linked into one big fat binary  and it can be deployed in cloud servers easily without worrying about  dependencies.  

**Go Tooling**

Go comes bundled with powerful tools that help developers write better code. 

- gofmt - [gofmt](https://golang.org/cmd/gofmt/) is used to automatically format go source code. It uses tabs for indentation and blanks for alignment. 

- vet - [vet](https://golang.org/cmd/vet/) analyses the go source code and reports possible suspicious code.

- golint - [golint](https://github.com/golang/lint) is used to identify styling issues in the code.  

**Garbage collection**

Go uses garbage collection and hence memory management is pretty much  taken care automatically and the developer doesn't need to worry about  managing memory. This also helps to write concurrent programs easily.

## popular product

- Google developed Kubernetes using Go.
- Docker, the world famous containerization platform is developed using Go.
- Dropbox has migrated its performance critical components from Python to Go.
- Infoblox's next generation networking products are developed using Go.

macos: brew install golang;  go version
Linux Install :unzip it to /usr/local. Add /usr/local/go/bin to the PATH environment variable.

# Hello world

```
cd Document; mkdri learngo;cd learngo;
// main.go 
go install 
```

go install: no install location for directory /home/naveen/Documents/learngo outside GOPATH  
For more details see: 'go help gopath'  

`go install` is unable to find a location to install the compiled binary.   //不知道go install 生成的二进制i文件应该存放到哪个目录

```
go env
GOPATH="/Users/demo/go"
GOPROXY="https://proxy.golang.org,direct"
GOMOD=""
GOBIN=""
```

set  gobin

```
go help env
go env -w GOBIN="/Users/demo/go/bin"
```



  **Running a go program**

## 1. go install

再执行 go install 即可在  $GOBIN/bin 下生成 learngo 

```
$ /Users/demo/go/bin/leargo //执行learngo二进制命令文件，可以把此路径添加到PATH，直接执行lergo即可，不需要下钻到这层目录 
输出 Hello World;
```

## 2. go build

go build 和 go install 功能类似，区别在于 go build生成的二进制文件在当前目录,go install生成的二进制文件在~/go/bin下

```
cd leargo
go build ;//直接在当前目录下生成 learngo 二进制文件
```

## 3. go run

```
cd leargo
go run main.go
```

it compiles the file to a temporary location and runs the file from that location. 

```
$ go run --work main.go // --work 显示出临时路径
WORK=/var/folders/49/p0_y9s6d2w56wpb3c29d7hbc0000gn/T/go-build861266148
Hello World
```

4、go playground
 [Click here](https://play.golang.org/p/oXGayDtoLPh) to run the program online.

# Variables

Variable is the name given to a memory location to store a value of a specific [type](https://golangbot.com/types/). 

```go
var age int; //default 0
```

var name type = initialValue 



类型推论：根据初始值推论出变量类型

```
var age =29 //int type is inferred
```

```
var width,height int = 30,50

var width,height  = 30,50

var (  
      name1 = initialvalue1
      name2 = initialvalue2
)
var (
  name   = "naveen"
  age    = 29
  height int
)
```



```
func main() {  
    count := 10
    fmt.Println("Count =",count)
}
```

Short hand declaration requires initial values for all variables on the left-hand side of the assignment.

```go
 name, age := "naveen" //error
```

```go
a, b := 20, 30 //a and b declared 
a, b := 40, 50 //error, no new variables //变量都已经存在，不可以再次声明

b, c  := 40, 50 // b is already declared but c is new ，这句可以正常运行，因为有一个新变量
```

```go
func main() {  
    age := 29      // age is int
    age = "naveen" // error since we are trying to assign a string to a variable of type int
}
```

#  Types

The following are the basic types available in go 

- bool
- Numeric Types
  - int8, int16, int32, int64, int
  - uint8, uint16, uint32, uint64, uint. -- **Unsigned integers**
  - float32, float64
  - complex64, complex128
  - byte
  - rune
- string

**int:** 32位系统则32位，64位系统则是64位。最常用的是int

```go
var a int = 1
fmt.Printf("type of a is %T, size of a is %d", a, unsafe.Sizeof(a)) //type and size of a
type of a is int, size of a is 4  
%T 取类型
```

**byte** is an alias of uint8 

**rune** is an alias of int32

**String**  is a collection of bytes in Go

## Type Conversion

类型转换

```go
    i := 55      //int
    j := 67.8    //float64
    sum := i + j //int + float64 not allowed
//  sum := i + int(j) //j is converted to int
```

# Constants

```
95  
"I love Go" 
67.89  
```

```go
const a = 50

const (
  name = "John"
  age = 50
  country = "Canada"
)
```

**The value of a constant should be known at compile time.** 
Hence it cannot be assigned to a value returned by a [function call](https://golangbot.com/functions/) since the function call takes place at run time.
常量值必须在编译器就得知道，不能等到运行期再赋值

```go
func main() {  
    var a = math.Sqrt(4)   //allowed
    const b = math.Sqrt(4) //not allowed
}
```

### String Constants, Typed and Untyped Constants

**A string constant like "Hello World" does not have any type**.

```go
func main() {  
    const n = "Sam"
    var name = n
    fmt.Printf("type %T value %v", name, name) 
}
```

**The answer is untyped constants have a default type associated  with them and they supply it if and only if a line of code demands it.  In the statement `var name = n` in line no. 8, `name` needs a type and it gets it from the default type of the string constant `n` which is a \*string.\***

```go
const typedhello string = "Hello World" 
//typed constant 
```

Go is a strongly typed language. Mixing types during the assignment is not allowed.

```go
func main() {  
        var defaultName = "Sam" //allowed
        type myString string
        var customName myString = "Sam" //allowed
        customName = defaultName //not allowed  两种是不同的类型
}
```

 

```go
func main() {  
    const a = 5 //generic
    var intVar int = a // requires a to be int so it becomes an int constant
    var int32Var int32 = a
    var float64Var float64 = a
    var complex64Var complex64 = a
    fmt.Println("intVar",intVar, "\nint32Var", int32Var, "\nfloat64Var", float64Var, "\ncomplex64Var",complex64Var)
}
```



#### Numeric Expressions

Numeric constants are free to be mixed 

```go
func main() {  
    var a = 5.9 / 8
    fmt.Printf("a's type is %T and value is %v", a, a) //float  64
}
```



# Functions

```go
func functionname(parametername type) returntype {  
 //function body
}
```

#### Multiple return values

```go
func rectProps(length, width float64)(float64, float64) {  
    var area = length * width
    var perimeter = (length + width) * 2
    return area, perimeter
}

func main() {  
     area, perimeter := rectProps(10.8, 5.6)
    fmt.Printf("Area %f Perimeter %f", area, perimeter) 
}
```

#### Named return values

```go
func rectProps(length, width float64)(area, perimeter float64) {  
    area = length * width
    perimeter = (length + width) * 2
    return //no explicit return value
}
```

#### Blank Identifier

```go
 area, _ := rectProps(10.8, 5.6) // perimeter is discarded
```

# Go Packages

The `import "packagename"` statement is used to import an existing package. `packagename.FunctionName()` is the syntax to call a function in a package.

Go Module
Why do we need Go modules to create a custom package? The answer is **the import path for the custom package we create is derived from the name of the go module**. 

In addition to this, all the other third-party packages(such as source  code from github) which our application uses will be present in the `go.mod` file along with the version.

```
cd learnpackage
go mod init learnpackage //generate go.mod file
```

```
-- go.mod
module learnpackage // learnpackage will be the base path to import any package created inside this module. 

go 1.13  
```



vscode 自动安装 go扩展失败
go env
goproxy 默认被设置为 https://proxy.golang.org  墙内无法访问，需要修改
使用七牛云的服务 https://goproxy.cn/

```
$ go env -w GO111MODULE=on
$ go env -w GOPROXY=https://goproxy.cn,direct
```



```
├── learnpackage
│   ├── go.mod
│   ├── main.go
│   └── simpleinterest
│       └── simpleinterest.go
```

```go
package main
import (  
    "fmt"
    "learnpackage/simpleinterest"
)
func main() { 
  simpleinterest.Cal()
}
```



go install moduleName 
不跟模块名称的话，默认当前路径go.mod模块名称

```
go install

go install .

go install learnpackage  
```

go install 在当前目录没有找到go.mod文件，会向上遍历查找go.mod ,因此在simpleinterest下执行 go install learnpackage 等同。

#### init function 

Each package in Go can contain an `init` function.  
init 函数 无入参 无返回值
It will be called automatically when the package is initialized. 

```
func init(){

}
```

The `init` function can be used to perform initialization  tasks and can also be used to verify the correctness of the program  before the execution starts.  

1. Package level variables are initialised first
2. init function is called next. A package can have multiple init  functions (either in a single file or distributed across multiple files) and they are called in the order in which they are presented to the  compiler.

If a package imports other packages, the imported packages are initialized first. 

A package will be initialized only once even if it is imported from multiple packages.

引入  执行包初始化 但是不调用包方法

```go
import (  
        "learnpackage/simpleinterest"
)
var _ = simpleinterest.Calculate
```

```go
import (  
    _ "learnpackage/simpleinterest"
)
```

# if else

```go
if condition {  
} else {
}

if num%2 == 0 { //checks if number is even
  fmt.Println("The number", num, "is even")
  return
}
```

### If with assignment

```go
if assignment-statement; condition {  
}

if num := 10; num % 2 == 0 { //checks if number is even
  fmt.Println(num,"is even") 
}  else {
  fmt.Println(num,"is odd")
}
```

**the scope of `num` is limited to the `if` `else` blocks.** 

### Idiomatic Go

**In Go's philosophy, it is better to avoid unnecessary branches  and indentation of code. It is also considered better to return as early as possible.**

```go
func main() {  
    if num := 10; num % 2 == 0 { //checks if number is even
        fmt.Println(num,"is even") 
    }  else {
        fmt.Println(num,"is odd")
    }
}
```

```go
func main() {  
    num := 10;
    if num%2 == 0 { //checks if number is even
        fmt.Println(num, "is even")
        return
    }
    fmt.Println(num, "is odd")

}
```



# Loops

```go
for initialisation; condition; post {  
}
```

```go
func main() {  
outer:  
    for i := 0; i < 3; i++ {
        for j := 1; j < 4; j++ {
            fmt.Printf("i = %d , j = %d\n", i, j)
            if i == j {
                break outer
            }
        }

    }
}
```

### infinite loop

```go
for {  
}
```

# Switch  Statement

**A switch is a conditional statement that evaluates an expression and compares it against a list of possible matches and executes the  corresponding block of code. It can be considered as an idiomatic way of replacing complex `if else` clauses.**

An example program is worth a hundred words. 

```go
func main() {  
    switch finger := 8; finger {
    case 1:
        fmt.Println("Thumb")
    case 2:
        fmt.Println("Index")
    case 3:
        fmt.Println("Middle")
    case 4:
        fmt.Println("Ring")
    case 5:
        fmt.Println("Pinky")
    default: //default case
        fmt.Println("incorrect finger number")
    }
}
```

```go
func main() {  
    letter := "i"
    fmt.Printf("Letter %s is a ", letter)
    switch letter {
    case "a", "e", "i", "o", "u": //multiple expressions in case
        fmt.Println("vowel")
    default:
        fmt.Println("not a vowel")
    }
}
```

```go
func main() {  
    num := 75
    switch { // expression is omitted
    case num >= 0 && num <= 50:
        fmt.Printf("%d is greater than 0 and less than 50", num)
    case num >= 51 && num <= 100:
        fmt.Printf("%d is greater than 51 and less than 100", num)
    case num >= 101:
        fmt.Printf("%d is greater than 100", num)
    }

}
```



`fallthrough` cannot be used in the last case of a switch since there are no more cases to fallthrough. I

### Fallthrough happens even when the case evaluates to false

```go
func main() {  
    switch num := 25; { 
    case num < 50:
        fmt.Printf("%d is lesser than 50\n", num)
        fallthrough
    case num > 100:
        fmt.Printf("%d is greater than 100\n", num)     
    }
}

25 is lesser than 50  
25 is greater than 100  
```

fallthrough doesn't consider this. Fallthrough will happen even though the case evaluates to false.

### Breaking switch

```go
func main() {  
    switch num := -5; {
    case num < 50:
        if num < 0 {
            break
        }
        fmt.Printf("%d is lesser than 50\n", num)
        fallthrough
    case num < 100:
        fmt.Printf("%d is lesser than 100\n", num)
        fallthrough
    case num < 200:
        fmt.Printf("%d is lesser than 200", num)
    }

}
```

### Breaking the outer for loop

```go
func main() {  
randloop:  
    for {
        switch i := rand.Intn(100); {
        case i%2 == 0:
            fmt.Printf("Generated even number %d", i)
            break randloop
        }
    }

}
```

 **if the break statement is used without the label, the switch  statement will only be broken and the loop will continue running. So  labeling the loop and using it in the break statement inside the switch  is necessary to break the outer for loop.**

# Arrays and Slices

An array is a collection of elements that belong to the same type. 
An array belongs to type `[n]T`
The number of elements `n` is also a part of the type

```go
func main() {  
    var a [3]int //int array with length 3   
  //[] collection ,int elemnt  //a collection [] of  n int element 
    fmt.Println(a) // [0 0 0]
}
```

**All elements in an array are automatically assigned the zero value of the array type**. 

```go
 a := [3]int{12, 78, 50} // short hand declaration to create array
```

```go
a := [3]int{12} // [12 0 0]
```

```go
a := [...]int{12, 78, 50} // ... makes the compiler determine the length
```

```go
func main() {  
    a := [3]int{5, 78, 8}
    var b [5]int
    b = a //not possible since [3]int and [5]int are distinct types
}
```

##### Arrays are value types

Arrays in Go are value types and not reference types. This means that  when they are assigned to a new variable, a copy of the original array  is assigned to the new variable.  If changes are made to the new variable, it will not be reflected in the original array.

```go
func main() {  
    a := [...]string{"USA", "China", "India", "Germany", "France"}
    b := a // a copy of a is assigned to b
    b[0] = "Singapore"
    fmt.Println("a is ", a)
    fmt.Println("b is ", b) 
}

a is [USA China India Germany France]  
b is [Singapore China India Germany France]  
```

```go
func main() {  
    a := [...]float64{67.7, 89.8, 21, 78}
    fmt.Println("length of a is",len(a))//4
}
```

##### Iterating arrays using range

```go
func main() {  
    a := [...]float64{67.7, 89.8, 21, 78}
    sum := float64(0)
    for i, v := range a {//range returns both the index and value
        fmt.Printf("%d the element of a is %.2f\n", i, v)
        sum += v
    }
    fmt.Println("\nsum of all elements of a",sum)
}
```

```go
for _, v := range a { //ignores index  
}
```

```go
    a := [3][2]string{
        {"lion", "tiger"},
        {"cat", "dog"},
        {"pigeon", "peacock"}, //this comma is necessary. The compiler will complain if you omit this comma
    }

func printarray(a [3][2]string) {  
    for _, v1 := range a {
        for _, v2 := range v1 {
            fmt.Printf("%s ", v2)
        }
        fmt.Printf("\n")
    }
}
```

### Slices

A slice is a convenient, flexible and powerful wrapper on top of an  array. Slices do not own any data on their own. They are the just  references to existing arrays.

```go
    a := [5]int{76, 77, 78, 79, 80}
    var b []int = a[1:4] //creates a slice from a[1] to a[3] //start end-1
    fmt.Println(b)
```

```go
 c := []int{6, 7, 8} //creates and array and returns a slice reference
```

Any modifications done to the slice will be reflected in the underlying array.

```go
func main() {  
    darr := [...]int{57, 89, 90, 82, 100, 78, 67, 69, 59}
    dslice := darr[2:5]
    fmt.Println("array before",darr)
    for i := range dslice {
        dslice[i]++
    }
    fmt.Println("array after",darr) 
}
```

```
array before [57 89 90 82 100 78 67 69 59]  
array after [57 89 91 83 101 78 67 69 59]  
```

```go
 nums1 := numa[:] //creates a slice which contains all elements of the array 
```

##### length and capacity of a slice

The length of the slice is the number of elements in the slice. **The capacity of the slice is the number of elements in the underlying array starting from the index from which the slice is created.**

```go
func main() {  
    fruitarray := [...]string{"apple", "orange", "grape", "mango", "water melon", "pine apple", "chikoo"}
    fruitslice := fruitarray[1:3]
    fmt.Printf("length of slice %d capacity %d", len(fruitslice), cap(fruitslice)) 
  //length of fruitslice is 2 and capacity is 6
}
```

##### creating a slice using make

*func make([]T, len, cap) []T* 
cap 可选，该参数默认值等于len

The make function creates an array and returns a slice reference to it.

```go
func main() {  
    i := make([]int, 5, 5)
    fmt.Println(i)
}
```

##### Appending to a slice

`func append(s []T, x ...T) []T`

x ...T  接收多个参数

x  accepts variable number of arguments for the parameter x.

 a new array is created. The elements of the existing array are copied  to this new array and a new slice reference for this new array is  returned. 

```go
 var names []string //zero value of a slice is nil
```

```go
    cars := []string{"Ferrari", "Honda", "Ford"}
    cars = append(cars, "Toyota")

    veggies := []string{"potatoes","tomatoes","brinjal"}
    fruits := []string{"oranges","apples"}
    food := append(veggies, fruits...)
```

append one slice to another using the `...` operator

##### Passing a slice to a function

可以把slice内部结构看成structure

```go
type slice struct{
   Length int
   Capacity int
   zerothElement *byte   // a pointer to the zeroth element of the array
}
```

When a slice is passed to a function, even though it's passed by value,  the pointer variable will refer to the same underlying array. 

##### Multidimensional slices

```go
func main() {  
     pls := [][]string {
            {"C", "C++"},
            {"JavaScript"},
            {"Go", "Rust"},
            }
    for _, v1 := range pls {
        for _, v2 := range v1 {
            fmt.Printf("%s ", v2)
        }
        fmt.Printf("\n")
    }
}
```

##### Memory Optimisation

如果slice引用了一个非常大的数组占用内存较多，但是只是使用数组中的一小部分，则可以进行优化。copy生成小数组，丢弃大数组。

```go
func copy(dst, src []T) int
```

```go
func countries() []string {  
    countries := []string{"USA", "Singapore", "Germany", "India", "Australia"}
    neededCountries := countries[:len(countries)-2]
    countriesCpy := make([]string, len(neededCountries))
    copy(countriesCpy, neededCountries) //copies neededCountries to countriesCpy
    return countriesCpy
}
```



# Variadic Functions

可变参数

```go
func hello(a int, b ...int) {   // []int{b1,b2...} 
  for i,v := range b{
    
  }
}
```

```go
hello(1, 2) //passing one argument "2" to b  
hello(5, 6, 7, 8, 9) //passing arguments "6, 7, 8 and 9" to b  
// 6,7,8,9 被编译器转换为 slice []int{6,7,8,9} ,再传递给hello函数调用
hello(1)  // can  pass zero arguments to a variadic function
```

**Only the last parameter of a function can be variadic.**
因为可变参数可以是0个参数 ，所以要放在最后一位，否则无法区分。

 **Slice arguments vs Variadic arguments** 

```go
func find(num int, nums []int) {}

find(89, []int{89, 90, 95})
find(87, []int{})
```

优点：1、没必要创建slice  2、可选参数可为空，不需要创建空的slice 多余。 3、可读性更强

### Append is a variadic function

```
func append(slice []Type, elems ...Type) []Type  
```

### Passing a slice to a variadic function

```go
nums := []int{89, 90, 95}
find(89, nums)
//find可选参数期望接受的参数格式是 []int{nums} , 传递过去的是[]int not int 所以编译失败
```



```go
nums := []int{89, 90, 95}
find(89, nums...)
```

**There is a syntactic sugar which can be used to pass a slice to a variadic function. You have to suffix the slice with ellipsis `...` If that is done, the slice is directly passed to the function without a new slice being created.**



```go
func change(s ...string) {
	s[0] = "Go"
	s = append(s, "playground")
	fmt.Println(s)
}

func main() {
	welcome := []string{"hello", "world"}
	change(welcome...)
	fmt.Println(welcome)
}
-- 
[Go world playground]
[Go world]
```

# Map

```go
make(map[type of key]type of value)  
```

```go
func main() {  
    employeeSalary := make(map[string]int)
    fmt.Println(employeeSalary) // map[]  
    employeeSalary["steve"] = 12000
}

employeeSalary := map[string]int {
  "steve": 12000,
  "jamie": 15000,
}
fmt.Println("Salary of joe is", employeeSalary["joe"]) // Salary of joe is 0  
//若果key不存在，取出的是默认值，不会报错
```

The zero value of a map is `nil`. If you try to add elements to a `nil` map, a run-time [panic](https://golangbot.com/panic-and-recover/) will occur. 
Hence the map has to be initialized before adding elements.

### Checking if a key exists

