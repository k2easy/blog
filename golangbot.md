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
./main
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

```go
value, ok := map[key]  
```

```go
for key, value := range employeeSalary {
  fmt.Printf("employeeSalary[%s] = %d\n", key, value)
}
```

```go
   delete(employeeSalary, "steve")
```

### Map of structs

```go
    emp3 := employee{
        salary:  13000,
        country: "India",
    }
    employeeInfo := map[string]employee{
        "Steve": emp1,
        "Jamie": emp2,
        "Mike":  emp3,
    }
```

Similar to [slices](https://golangbot.com/arrays-and-slices/), maps are reference types. 

# String

```go
func printBytes(s string) {  
    fmt.Printf("Bytes: ")
    for i := 0; i < len(s); i++ {
        fmt.Printf("%x ", s[i]) //%x is the format specifier for hexadecimal.**
    }
}
func printChars(s string) {  
    fmt.Printf("Characters: ")
    for i := 0; i < len(s); i++ {
        fmt.Printf("%c ", s[i])
    }
}
name = "Señor" 
printChars(name) 
printBytes(name)
Characters: S e Ã ± o r  
Bytes: 53 65 c3 b1 6f 72  
```

he reason is that the Unicode code point of `ñ` is `U+00F1` and its [UTF-8 encoding](https://mothereff.in/utf-8#ñ) occupies 2 bytes `c3` and `b1`. We are trying to print characters assuming that each code point will be one byte long which is wrong. **In UTF-8 encoding a code point can occupy more than 1 byte.** 

A rune is a builtin [type](https://golangbot.com/types/) in Go and it's the alias of int32. Rune represents a Unicode code point in Go. I

```go
func printChars(s string) {  
    fmt.Printf("Characters: ")
    runes := []rune(s)
    for i := 0; i < len(runes); i++ {
        fmt.Printf("%c ", runes[i])
    }
}
```

Go offers us a much easier way to do this using the **for range** loop.

```go
func charsAndBytePosition(s string) {  
    for index, rune := range s {
        fmt.Printf("%c starts at byte %d\n", rune, index)
    }
}
S starts at byte 0  
e starts at byte 1  
ñ starts at byte 2
o starts at byte 4  
r starts at byte 5  
```

### Creating a string from a slice of bytes

```go
func main() {  
    byteSlice := []byte{0x43, 0x61, 0x66, 0xC3, 0xA9}
    str := string(byteSlice)
    fmt.Println(str) //Café  
}
func main() {  
    byteSlice := []byte{67, 97, 102, 195, 169}//decimal equivalent of {'\x43', '\x61', '\x66', '\xC3', '\xA9'}
    str := string(byteSlice)
    fmt.Println(str) // Café  
}
func main() {  
    runeSlice := []rune{0x0053, 0x0065, 0x00f1, 0x006f, 0x0072}
    str := string(runeSlice)
    fmt.Println(str)//Señor  
}
```

### String length

 `RuneCountInString(s string) (n int)`

```go
import (  
    "fmt"
    "unicode/utf8"
)

func main() {  
    word1 := "Señor"
    fmt.Printf("String: %s\n", word1)
    fmt.Printf("Length: %d\n", utf8.RuneCountInString(word1))
    fmt.Printf("Number of bytes: %d\n", len(word1))
  
String: Señor  
Length: 5  
Number of bytes: 6
```

### String comparison

The `==` operator 

### String concatenation

 the `+` operator.
 result := string1 + " " + string2
 result := fmt.Sprintf("%s %s", string1, string2)



### Strings are immutable

```go
func mutate(s string)string {  
    s[0] = 'a'//any valid unicode character within single quote is a rune 
    return s //报错
}
func main() {  
    h := "hello"
    fmt.Println(mutate(h))
}
```

To workaround this string immutability, strings are converted to a [slice](https://golangbot.com/arrays-and-slices/) of runes. Then that slice is mutated with whatever changes are needed and converted back to a new string.

```go
func mutate(s []rune) string {  
    s[0] = 'a' 
    return string(s)
}
func main() {  
    h := "hello"
    fmt.Println(mutate([]rune(h)))
}
```

# Pointers

A pointer is a variable which stores the memory address of another variable.

![Pointers in Go](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/03/2920210329064511.png)

variable `b` has value `156` and is stored at memory address `0x1040a124`. The variable `a` holds the address of `b`. Now `a` is said to point to `b`.

**declare pointer   *T** 

```go
func main() {  
    b := 255
    var a *int = &b
    fmt.Printf("Type of a is %T\n", a)
    fmt.Println("address of b is", a)
}
Type of a is *int  
address of b is 0x1040a124  
```

The zero value of a pointer is `nil`

### Creating pointers using the new function

The `new` function takes a type as argument and returns a pointer to a newly allocated zero value of the type passed as argument.

```go
func main() {  
    size := new(int)
    fmt.Printf("Size value is %d, type is %T, address is %v\n", *size, size, size)
    *size = 85 //Dereferencing a pointer  *
    fmt.Println("New size value is", *size)
}
Size value is 0, type is *int, address is 0x414020  
New size value is 85  
```

 Passing pointer to a function
Returning pointer from a function

```go
func hello() *int {  
    i := 5
    return &i
}
func main() {  
    d := hello()
    fmt.Println("Value of d", *d)
}
Value of d 5  
```

 **The behavior of this code is undefined in programming languages such as C and C++ as the variable `i` goes out of scope once the function `hello` returns. But in the case of Go, the compiler does a escape analysis and allocates `i` on the heap as the address escapes the local scope.** 



### Do not pass a pointer to an array as a argument to a function. Use slice instead.

```go
func modify(arr *[3]int) {  
    (*arr)[0] = 90
}

func main() {  
    a := [3]int{89, 90, 91}
    modify(&a)
    fmt.Println(a)
}
```

**a[x] is shorthand for (\*a)[x]. So (\*arr)[0] in the above program can be replaced by arr[0]**.

```go
func modify(arr *[3]int) {  
    arr[0] = 90
}

func main() {  
    a := [3]int{89, 90, 91}
    modify(&a)
    fmt.Println(a)
}
```

```go
func modify(sls []int) {  
    sls[0] = 90
}

func main() {  
    a := [3]int{89, 90, 91}
    modify(a[:])
    fmt.Println(a)
}
```

**So forget about passing pointers to arrays around and use slices instead :)**. This code is much more clean and is idiomatic Go :).

### Go does not support pointer arithmetic

# Structs

A struct is a user-defined type that represents a collection of fields.

```go
type Employee struct {  
    firstName, lastName string
    age                 int
}

    //creating struct specifying field names
    emp1 := Employee{
        firstName: "Sam",
        age:       25,
        salary:    500,
        lastName:  "Anderson",
    }

    //creating struct without specifying field names
    emp2 := Employee{"Thomas", "Paul", 29, 800}
    fmt.Println("Employee 1", emp1)

```

###  Creating anonymous structs

```go
func main() {  
    emp3 := struct {
        firstName string
        lastName  string
        age       int
        salary    int
    }{
        firstName: "Andreah",
        lastName:  "Nikola",
        age:       31,
        salary:    5000,
    }

    fmt.Println("Employee 3", emp3)
}
```

### Accessing individual fields of a struct

The dot `.` operator is used to access the individual fields of a struct.

### Zero value of a struct

When a struct is defined and it is not explicitly initialized with any value, the fields of the struct are assigned their zero values by default.

### Pointers to a struct

```go
    emp8 := &Employee{
        firstName: "Sam",
        lastName:  "Anderson",
        age:       55,
        salary:    6000,
    }
    fmt.Println("First Name:", (*emp8).firstName)
```

**The Go language gives us the option to use `emp8.firstName` instead of the explicit dereference `(\*emp8).firstName` to access the `firstName` field.**

### Anonymous fields

It is possible to create structs with fields that contain only a type without the field name. These kinds of fields are called anonymous fields.

```go
type Person struct {  
    string
    int
}
```

### Nested structs

```go
type Address struct {  
    city  string
    state string
}

type Person struct {  
    name    string
    age     int
    address Address
}
```

### Promoted fields

the `Person` struct has an anonymous field `Address` which is a struct. Now the fields of the `Address` namely `city` and `state` are called promoted fields since they can be accessed as if they are directly declared in the `Person` struct itself.

```go
type Address struct {  
    city string
    state string
}
type Person struct {  
    name string
    age  int
    Address
}
```

### Exported structs and fields

结构体名称，结构体字段名称 大写开头就能够被其他包使用

### Structs Equality

**Structs are value types and are comparable if each of their fields are comparable.** 
**Struct variables are not comparable if they contain fields that are not comparable**

# Methods

A method is just a [function](https://golangbot.com/functions/) with a special receiver type between the `func` keyword and the method name. The receiver can either be a struct type or non-struct type.

```go
func (t Type) methodName(parameter list) {  
}

func (e Employee) displaySalary() {  
    fmt.Printf("Salary of %s is %s%d", e.name, e.currency, e.salary)
}
```

### Pointer Receivers vs Value Receivers

 changes made inside a method with a pointer receiver is visible to the caller whereas this is not the case in value receiver. 

Pointer Receiver能够改变 调用者本身的值
Pointers receivers can also be used in places where it's expensive to copy a data structure. 

```go
/*
Method with value receiver  
*/
func (e Employee) changeName(newName string) {  
    e.name = newName
}

/*
Method with pointer receiver  
*/
func (e *Employee) changeAge(newAge int) {  
    e.age = newAge
}
```

 `(&e).changeAge(51)` , 可以使用 `e.changeAge(51)` will be interpreted as `(&e).changeAge(51)` by the language.

### Methods of anonymous struct fields

```go
type address struct {  
    city  string
    state string
}

func (a address) fullAddress() {  
    fmt.Printf("Full address: %s, %s", a.city, a.state)
}

type person struct {  
    firstName string
    lastName  string
    address
}

func main() {  
    p := person{
        firstName: "Elon",
        lastName:  "Musk",
        address: address {
            city:  "Los Angeles",
            state: "California",
        },
    }

    p.fullAddress() //accessing fullAddress method of address struct

}
```

### Value receivers in methods vs Value arguments in functions

When a function has a value argument, it will accept only a value argument.

When a method has a value receiver, it will accept both pointer and value receivers.

```go
func area(r rectangle) {  
    fmt.Printf("Area Function result: %d\n", (r.length * r.width))
}

func (r rectangle) area() {  
    fmt.Printf("Area Method result: %d\n", (r.length * r.width))
}

func main() {  
    r := rectangle{
        length: 10,
        width:  5,
    }
    area(r)
    r.area()

    p := &r
    /*
       compilation error, cannot use p (type *rectangle) as type rectangle 
       in argument to area  
    */
    //area(p)

    p.area()//calling value receiver with a pointer
}
```

 `p.area()`, for convenience will be interpreted by Go as `(*p).area()` since `area` has a value receiver.

### Pointer receivers in methods vs Pointer arguments in functions

Similar to value arguments, functions with pointer arguments will accept only pointers whereas methods with pointer receivers will accept both pointer and value receiver.

### Methods with non-struct receivers

It is also possible to define methods on non-struct types, but there is a catch. **To define a method on a type, the definition of the receiver type and the definition of the method should be present in the same package**

```go
type myInt int

func (a myInt) add(b myInt) myInt {  
    return a + b
}
```

# Interfaces

**In Go, an interface is a set of method signatures. When a type provides definition for all the methods in the interface, it is said to implement the interface.** 

### Declaring and implementing an interface

```go
//interface definition
type VowelsFinder interface {  
    FindVowels() []rune
}

type MyString string

//MyString implements VowelsFinder
func (ms MyString) FindVowels() []rune {  
    var vowels []rune
    for _, rune := range ms {
        if rune == 'a' || rune == 'e' || rune == 'i' || rune == 'o' || rune == 'u' {
            vowels = append(vowels, rune)
        }
    }
    return vowels
}

func main() {  
    name := MyString("Sam Anderson")
    var v VowelsFinder
    v = name // possible since MyString implements VowelsFinder
    fmt.Printf("Vowels are %c", v.FindVowels())

}
```

//某个变量实现了该接口内的全部方法，那么这个变量就是该接口的一员，可以用该接口类型声明的变量表示。

```go
type SalaryCalculator interface {  
    CalculateSalary() int
}

type Permanent struct {  
    empId    int
    basicpay int
    pf       int
}

type Contract struct {  
    empId    int
    basicpay int
}

//salary of permanent employee is sum of basic pay and pf
func (p Permanent) CalculateSalary() int {  
    return p.basicpay + p.pf
}

//salary of contract employee is the basic pay alone
func (c Contract) CalculateSalary() int {  
    return c.basicpay
}
/*
total expense is calculated by iterating through the SalaryCalculator slice and summing  
the salaries of the individual employees  
*/
func totalExpense(s []SalaryCalculator) {  
    expense := 0
    for _, v := range s {
        expense = expense + v.CalculateSalary()
    }
    fmt.Printf("Total Expense Per Month $%d", expense)
}

func main() {  
    pemp1 := Permanent{
        empId:    1,
        basicpay: 5000,
        pf:       20,
    }
     cemp1 := Contract{
        empId:    3,
        basicpay: 3000,
    }
     employees := []SalaryCalculator{pemp1, cemp1}
    totalExpense(employees)

}
```

### Interface internal representation

An interface can be thought of as being represented internally by a tuple `(type, value)`. `type` is the underlying concrete type of the interface and `value` holds the value of the concrete type.

```go
type Worker interface {  
    Work()
}

type Person struct {  
    name string
}

func (p Person) Work() {  
    fmt.Println(p.name, "is working")
}

func describe(w Worker) {  
    fmt.Printf("Interface type %T value %v\n", w, w)
}

func main() {  
    p := Person{
        name: "Naveen",
    }
    var w Worker = p
    describe(w)
    w.Work()
}
Interface type main.Person value {Naveen}  
Naveen is working  
```



### Empty interface

**An interface that has zero methods is called an empty interface. It is represented as `interface{}`.** Since the empty interface has zero methods, all types implement the empty interface.

```go
func describe(i interface{}) {  
    fmt.Printf("Type = %T, value = %v\n", i, i)
}

    s := "Hello World"
    describe(s)
```

### Type assertion

Type assertion is used to extract the underlying value of the interface.

// 获取该类型的底层值

```go
func assert(i interface{}) {  
    v, ok := i.(int)
    fmt.Println(v, ok)
}
func main() {  
    var s interface{} = 56
    assert(s)
    var i interface{} = "Steven Paul"
    assert(i)
}
```

### Type switch

```go
func findType(i interface{}) {  
    switch i.(type) {
    case string:
        fmt.Printf("I am a string and my value is %s\n", i.(string))
    case int:
        fmt.Printf("I am an int and my value is %d\n", i.(int))
    default:
        fmt.Printf("Unknown type\n")
    }
}
```

interface is also a type,
**It is also possible to compare a type to an interface. If we have a type and if that type implements an interface, it is possible to compare this type with the interface it implements.**

```go
type Describer interface {  
    Describe()
}
type Person struct {  
    name string
    age  int
}

func (p Person) Describe() {  
    fmt.Printf("%s is %d years old", p.name, p.age)
}

func findType(i interface{}) {  
    switch v := i.(type) {
    case Describer:
        v.Describe()
    default:
        fmt.Printf("unknown type\n")
    }
}

func main() {  
    findType("Naveen")
    p := Person{
        name: "Naveen R",
        age:  25,
    }
    findType(p)
}
```

### Implementing interfaces using pointer receivers vs value receivers

```go
type Describer interface {  
    Describe()
}
type Person struct {  
    name string
    age  int
}

func (p Person) Describe() { //implemented using value receiver  
    fmt.Printf("%s is %d years old\n", p.name, p.age)
}

type Address struct {  
    state   string
    country string
}

func (a *Address) Describe() { //implemented using pointer receiver  
    fmt.Printf("State %s Country %s", a.state, a.country)
}

  var d2 Describer
    a := Address{"Washington", "USA"}

    /* compilation error if the following line is
       uncommented
       cannot use a (type Address) as type Describer
       in assignment: Address does not implement
       Describer (Describe method has pointer
       receiver)
    */
    //d2 = a  //line 45

    d2 = &a //This works since Describer interface
    //is implemented by Address pointer in line 22
    d2.Describe()

```

This is because, the `Describer` interface is implemented using a Address Pointer receiver in line 22 and we are trying to assign `a` which is a value type and it has not implemented the `Describer` interface. This will definitely surprise you since we learnt earlier that [methods](https://golangbot.com/methods/#pointerreceiversinmethodsvspointerargumentsinfunctions) with pointer receivers will accept both pointer and value receivers. 
**The reason is that it is legal to call a pointer-valued method on anything that is already a pointer or whose address can be taken. The concrete value stored in an interface is not addressable and hence it is not possible for the compiler to automatically take the address of `a` in line no. 45 and hence this code fails.**

### Implementing multiple interfaces

### Embedding interfaces

Although go does not offer inheritance, it is possible to create a new interfaces by embedding other interfaces.

```go
type SalaryCalculator interface {  
    DisplaySalary()
}

type LeaveCalculator interface {  
    CalculateLeavesLeft() int
}

type EmployeeOperations interface {  
    SalaryCalculator
    LeaveCalculator
}

type Employee struct {  
    firstName string
    lastName string
    basicPay int
    pf int
    totalLeaves int
    leavesTaken int
}

func (e Employee) DisplaySalary() {  
    fmt.Printf("%s %s has salary $%d", e.firstName, e.lastName, (e.basicPay + e.pf))
}

func (e Employee) CalculateLeavesLeft() int {  
    return e.totalLeaves - e.leavesTaken
}

func main() {  
    e := Employee {
        firstName: "Naveen",
        lastName: "Ramanathan",
        basicPay: 5000,
        pf: 200,
        totalLeaves: 30,
        leavesTaken: 5,
    }
    var empOp EmployeeOperations = e
    empOp.DisplaySalary()
    fmt.Println("\nLeaves left =", empOp.CalculateLeavesLeft())
}
```

The zero value of a interface is nil. A nil interface has both its underlying value and as well as concrete type as nil.

# Concurrency

**Go is a concurrent language and not a parallel one**. 
Concurrency is the capability to deal with lots of things at once. 

Let's consider a person jogging. During his morning jog, let's say his shoelaces become untied. Now the person stops running, ties his shoelaces and then starts running again. This is a classic example of concurrency. The person is capable of handling both running and tying shoelaces, that is the person is able to deal with lots of things at once :)



Parallelism is doing lots of things at the same time. It might sound similar to concurrency but it's actually different.the person is jogging and listening to music at the same time, that is he is doing lots of things at the same time. This is called parallelism.

只有一个内核的cpu电脑上，浏览器渲染网页和下载文件 交替使用cpu，这叫做并发。
Goroutines are [functions](https://golangbot.com/functions/) or [methods](https://golangbot.com/methods/) that run concurrently with other functions or methods. Goroutines can be thought of as light weight threads. 

```go
func hello() {  
    fmt.Println("Hello world goroutine")
}
func main() {  
    go hello()
    fmt.Println("main function")
}
```

# Channels

Channels can be thought of as pipes using which Goroutines communicate. Similar to how water flows from one end to another in a pipe, data can be sent from one end and received from the other end using channels.

### Declaring channels

```go
    var a chan int
    if a == nil {
        fmt.Println("channel a is nil, going to define it")
        a = make(chan int)
        fmt.Printf("Type of a is %T", a)  //Type of a is chan int  
    }
```

### Sending and receiving from a channel

```go
data := <- a // read from channel a  
a <- data // write to channel a 
```

### Sends and receives are blocking by default

When data is sent to a channel, the control is blocked in the send statement until some other Goroutine reads from that channel. Similarly, when data is read from a channel, the read is blocked until some Goroutine writes data to that channel.

This property of channels is what helps Goroutines communicate effectively without the use of explicit locks or conditional variables that are quite common in other programming languages.

```go
func hello(done chan bool) {  
    fmt.Println("Hello world goroutine")
    done <- true
}
func main() {  
    done := make(chan bool)
    go hello(done)
    <-done  //等待读，读不到就等待(阻塞)，如果一直没有其他goroutine写数据就会deadlock死锁
    fmt.Println("main function")
}
```

```go
func main() {  
    number := 589
    sqrch := make(chan int)
    cubech := make(chan int)
    go calcSquares(number, sqrch)
    go calcCubes(number, cubech)
    squares, cubes := <-sqrch, <-cubech  //等待两个chanel都完成
    fmt.Println("Final output", squares + cubes)
}
```

### Deadlock

### Unidirectional channels 

单向channel

```go
func sendData(sendch chan<- int) {  
    sendch <- 10 
}

func main() {  
    sendch := make(chan<- int) //只送不读
    go sendData(sendch)
    fmt.Println(<-sendch)
  	// invalid operation: <-sendch (receive from send-only type chan<- int)
}
```

**It is possible to convert a bidirectional channel to a send only or receive only channel but not the vice versa.**

```go
func sendData(sendch chan<- int) {  
    sendch <- 10
}

func main() {  
    chnl := make(chan int)
    go sendData(chnl)
    fmt.Println(<-chnl)
}
```

### Closing channels and for range loops on channels

Senders have the ability to close the channel to notify receivers that no more data will be sent on the channel.
v, ok := <- ch  

Receivers can use an additional variable while receiving data from the channel to check whether the channel has been closed.

 If `ok` is false it means that we are reading from a closed channel. The value read from a closed channel will be the zero value of the channel's type. 

```go
func producer(chnl chan int) {  
    for i := 0; i < 10; i++ {
        chnl <- i
    }
    close(chnl)
}
func main() {  
    ch := make(chan int)
    go producer(ch)
    for v := range ch {
        fmt.Println("Received ",v)
    }
}
```

# Buffered Channels and Worker Pools

 Sends to a buffered channel are blocked only when the buffer is full. Similarly receives from a buffered channel are blocked only when the buffer is empty.

```
ch := make(chan type, capacity)  
```

 The capacity for an unbuffered channel is 0 by default 

```go
func write(ch chan int) {  
    for i := 0; i < 5; i++ {
        ch <- i
        fmt.Println("successfully wrote", i, "to ch")
    }
    close(ch)
}
func main() {  
    ch := make(chan int, 2)
    go write(ch)
    time.Sleep(2 * time.Second)
    for v := range ch {
        fmt.Println("read value", v,"from ch")
        time.Sleep(2 * time.Second)

    }
}
successfully wrote 0 to ch  
successfully wrote 1 to ch  
read value 0 from ch  
successfully wrote 2 to ch  
read value 1 from ch  
successfully wrote 3 to ch  
read value 2 from ch  
successfully wrote 4 to ch  
read value 3 from ch  
read value 4 from ch
读和写交替进行，即 并发
```

### Deadlock

```go
func main() {  
    ch := make(chan string, 2)
    ch <- "naveen"
    ch <- "paul"
    ch <- "steve"
    fmt.Println(<-ch)
    fmt.Println(<-ch)
  
    fmt.Println("capacity is", cap(ch))
    fmt.Println("length is", len(ch))
}
```



### WaitGroup

A WaitGroup is used to wait for a collection of Goroutines to finish executing. The control is blocked until all Goroutines finish executing.

```go
func process(i int, wg *sync.WaitGroup) {  
    fmt.Println("started Goroutine ", i)
    time.Sleep(2 * time.Second)
    fmt.Printf("Goroutine %d ended\n", i)
    wg.Done()
}

func main() {  
    no := 3
    var wg sync.WaitGroup
    for i := 0; i < no; i++ {
        wg.Add(1)
        go process(i, &wg)
    }
    wg.Wait()
    fmt.Println("All go routines finished executing")
}
```



### Worker Pool Implementation

One of the important uses of buffered channel is the implementation of [worker pool](https://en.wikipedia.org/wiki/Thread_pool).

In general, a worker pool is a collection of threads that are waiting for tasks to be assigned to them. Once they finish the task assigned, they make themselves available again for the next task.

```go
package main 
import (
	"fmt"
	"math/rand"
	"sync"
	"time"
)
type Job struct{
	id int 
	randomno int
}
type Result struct{
	job Job
	sumofdigits int 
}

var jobs = make(chan Job,10)
var results = make(chan Result,10)

func digits(number int) int{
	sum := 0
	no := number 
	for no!=0{
		digit := no%10
		sum += digit
		no /= 10
	}
	time.Sleep(2 * time.Second)
	return sum 
}

func worker(wg *sync.WaitGroup){
	for job := range jobs{
		output := Result(job,digits(job.randomno))
		results <- output
	}
	wg.Done()
}

func createWorkerPool(noOfWorkers int){
	var wg = sync.WaitGroup
	for i:=0;i<noOfWorkers;i++{
		wg.Add(1)
		go worker(&wg)
	}
	wg.Wait()
	close(results)
}
// 生产者 产生作业
func allocate(noOfJobs int){
	for i :=0 ;i<noOfJobs;i++{
		randomno = rand.Intn(999)
		job := Job(i,randomno)
		jobs <- job 
	}
	close(jobs)
}
//消费者 消费作业
func result(done chan bool){
    for result := range results {
        fmt.Printf("Job id %d, input random no %d , sum of digits %d\n", result.job.id, result.job.randomno, result.sumofdigits)
    }
	done <- true
}
func main(){
	startTime := time.Now()
	noOfJobs := 10
	go allocate(noOfJobs)
	done := make(chan bool)
	go result(done)
	//消费者 消费结束返回信号给主线程
	noOfWorkers := 10 //要用时再声明变量
	createWorkerPool(noOfWorkers)
	<- done 
	endTime := time.Now()
	diff := endTime.sub(startTime)
	fmt.Println("total time taken",diff.Seconds(),"seconds")
}
```

# Select

The `select` statement is used to choose from multiple send/receive channel operations. The select statement blocks until one of the send/receive operations is ready. If multiple operations are ready, one of them is chosen at random. 

```go
func server1(ch chan string) {  
    time.Sleep(6 * time.Second)
    ch <- "from server1"
}
func server2(ch chan string) {  
    time.Sleep(3 * time.Second)
    ch <- "from server2"

}
func main() {  
    output1 := make(chan string)
    output2 := make(chan string)
    go server1(output1)
    go server2(output2)
    select {
    case s1 := <-output1:
        fmt.Println(s1)
    case s2 := <-output2:
        fmt.Println(s2)
    }
}
```

### Default case

The default case in a `select` statement is executed when none of the other cases is ready. This is generally used to prevent the select statement from blocking.

```go
func process(ch chan string) {  
    time.Sleep(10500 * time.Millisecond)
    ch <- "process successful"
}

func main() {  
    ch := make(chan string)
    go process(ch)
    for {
        time.Sleep(1000 * time.Millisecond)
        select {
        case v := <-ch:
            fmt.Println("received value: ", v)
            return  //即时返回
        default:
            fmt.Println("no value received")
        }
    }
}
```

### Deadlock and default case

### Gotcha - Empty select

```go
package main

func main() {  
    select {} //panic
}
```

select statement will block until one of its cases is executed. In this case, the select statement doesn't have any cases and hence it will block forever resulting in a deadlock. This program will panic with the following output。

# Mutex

### Critical section

临界区/点

[critical section](https://en.wikipedia.org/wiki/Critical_section) in concurrent programming. When a program runs concurrently, the parts of code which modify shared resources should not be accessed by multiple [Goroutines](https://golangbot.com/goroutines/) at the same time. 

A Mutex is used to provide a locking mechanism to ensure that only one Goroutine is running the critical section of code at any point in time to prevent race conditions from happening.

```go
import "sync"
mutex.Lock()  
x = x + 1  
mutex.Unlock()  
```

**If one Goroutine already holds the lock and if a new Goroutine is trying to acquire a lock, the new Goroutine will be blocked until the mutex is unlocked.**

### Program with a race condition

```go
var x  = 0  
func increment(wg *sync.WaitGroup) {  
    x = x + 1
    wg.Done()
}
func main() {  
    var w sync.WaitGroup
    for i := 0; i < 1000; i++ {
        w.Add(1)        
        go increment(&w)
    }
    w.Wait()
    fmt.Println("final value of x", x)
}
```

输出结果不固定，Some of the outputs which I encountered are `final value of x 941`, `final value of x 928`, `final value of x 922` and so on.

### Solving the race condition using a mutex

```go
var x  = 0  
func increment(wg *sync.WaitGroup, m *sync.Mutex) {  
    m.Lock()
    x = x + 1
    m.Unlock()
    wg.Done()   
}
func main() {  
    var w sync.WaitGroup
    var m sync.Mutex
    for i := 0; i < 1000; i++ { //1000个goroutine共用一个 wg计数器，共用一个mutex锁
        w.Add(1)        
        go increment(&w, &m)
    }
    w.Wait()
    fmt.Println("final value of x", x)
}
```

### Solving the race condition using channel

```go
var x  = 0  
func increment(wg *sync.WaitGroup, ch chan bool) {  
    ch <- true  //利用chan的默认阻塞特性
    x = x + 1
    <- ch
    wg.Done()   
}
func main() {  
    var w sync.WaitGroup
    ch := make(chan bool, 1)
    for i := 0; i < 1000; i++ {
        w.Add(1)        
        go increment(&w, ch)
    }
    w.Wait()
    fmt.Println("final value of x", x)
}
```

### Mutex vs Channels

In general use channels when Goroutines need to communicate with each other and mutexes when only one Goroutine should access the critical section of code.



# OOP in Go

#### Object Oriented Programming

### Structs Instead of Classes  

```
go mod init oop  
```

### Composition Instead of Inheritance  

```go
type post struct {  
    title     string
    content   string
    author
}

type website struct {  
        posts []post
}
```

# Polymorphism

### Polymorphism using interface

**A variable of type interface can hold any value which implements the interface. This property of interfaces is used to achieve polymorphism in Go.**

#### Defer and Error Handling

**Defer statement is used to execute a [function](https://golangbot.com/functions/) call just before the surrounding function where the defer statement is present returns.**

函数结束前调用下defer函数或方法

```go
func printA(a int) {  
    fmt.Println("value of a in deferred function", a)
}
func main() {  
    a := 5
    defer printA(a)
    a = 10
    fmt.Println("value of a before deferred function call", a)
}
value of a before deferred function call 10  
value of a in deferred function 5  
```

### Stack of defers

When a function has multiple defer calls, they are pushed on to a stack and executed in Last In First Out (LIFO) order.

Defer is used in places where a function call should be executed irrespective of the code flow. 

```go
func (r rect) area(wg *sync.WaitGroup) {  
    defer wg.Done()
		～
  	area := r.length * r.width
    fmt.Printf("rect %v's area %d\n", r, area)
}
```

# Error Handling

Errors in Go are plain old values. Errors are represented using the built-in `error` type. 

```go
    f, err := os.Open("/test.txt")
    if err != nil {
```

### Error type representation

```go
type error interface {  
    Error() string
}
```

### Different ways to extract more information from the error

```
open /test.txt: No such file or directory  
```

Is there a better way to get the file name 🤔? 

#### 1. Asserting the underlying struct type and getting more information from the struct fields

```go
func main() {  
    f, err := os.Open("test.txt")
    if err != nil {
        if pErr, ok := err.(*os.PathError); ok {
            fmt.Println("Failed to open file at path", pErr.Path)
            //Failed to open file at path /test.txt  
            return
        }
        fmt.Println("Generic error", err)
        return
    }
    fmt.Println(f.Name(), "opened successfully")
}
```

#### 2. Asserting the underlying struct type and getting more information using methods

```go
func main() {  
    addr, err := net.LookupHost("golangbot123.com")
    if err != nil {
        if dnsErr, ok := err.(*net.DNSError); ok {
            if dnsErr.Timeout() {
                fmt.Println("operation timed out")
                return
            }
            if dnsErr.Temporary() {
                fmt.Println("temporary error")
                return
            }
            fmt.Println("Generic DNS error", err)
            return
        }
        fmt.Println("Generic error", err)
        return
    }
    fmt.Println(addr)
}
```

#### 3. Direct comparison

```go
import (  
    "fmt"
    "path/filepath"
)

func main() {  
    files, err := filepath.Glob("[")
    if err != nil {
        if err == filepath.ErrBadPattern {
            fmt.Println("Bad pattern error:", err)
            return
        }
        fmt.Println("Generic error:", err)
        return
    }
    fmt.Println("matched files", files)
}
```

### Do not ignore errors

Never ever ignore an error. Ignoring errors is inviting for trouble. 

# Custom Errors

The simplest way to create a custom error is to use the [New](https://golang.org/pkg/errors/#New) function of the [errors](https://golang.org/pkg/errors/) package.

```go
// Package errors implements functions to manipulate errors.
  package errors

  // New returns an error that formats as the given text.
  func New(text string) error {
      return &errorString{text}
  }

  // errorString is a trivial implementation of error.
  type errorString struct {
      s string
  }

  func (e *errorString) Error() string {
      return e.s
  }
```

```go
func circleArea(radius float64) (float64, error) {  
    if radius < 0 {
        return 0, errors.New("Area calculation failed, radius is less than zero")
    }
    return math.Pi * radius * radius, nil
}

func main() {  
    radius := -20.0
    area, err := circleArea(radius)
    if err != nil {
        fmt.Println(err)
        return
    }
    fmt.Printf("Area of circle %0.2f", area)
}
// Area calculation failed, radius is less than zero  
```

### Errorf

```go
func circleArea(radius float64) (float64, error) {  
    if radius < 0 {
        return 0, fmt.Errorf("Area calculation failed, radius %0.2f is less than zero", radius)
    }
    return math.Pi * radius * radius, nil
}
```

### Providing more information about the error using struct type and fields

```go
type areaError struct {  
    err    string
    radius float64
}
func (e *areaError) Error() string {  
    return fmt.Sprintf("radius %0.2f: %s", e.radius, e.err)
}
func circleArea(radius float64) (float64, error) {  
    if radius < 0 {
        return 0, &areaError{"radius is negative", radius}
    }
    return math.Pi * radius * radius, nil
}
```

### Providing more information about the error using methods on struct types

```go
type areaError struct {  
    err    string  //error description
    length float64 //length which caused the error
    width  float64 //width which caused the error
}

func (e *areaError) Error() string {  
    return e.err
}

func (e *areaError) lengthNegative() bool {  
    return e.length < 0
}

func (e *areaError) widthNegative() bool {  
    return e.width < 0
}

func rectArea(length, width float64) (float64, error) {  
    err := ""
    if length < 0 {
        err += "length is less than zero"
    }
    if width < 0 {
        if err == "" {
            err = "width is less than zero"
        } else {
            err += ", width is less than zero"
        }
    }
    if err != "" {
        return 0, &areaError{err, length, width}
    }
    return length * width, nil
}

func main() {  
    length, width := -5.0, -9.0
    area, err := rectArea(length, width)
    if err != nil {
        if err, ok := err.(*areaError); ok {
            if err.lengthNegative() {
                fmt.Printf("error: length %0.2f is less than zero\n", err.length)

            }
            if err.widthNegative() {
                fmt.Printf("error: width %0.2f is less than zero\n", err.width)

            }
            return
        }
    }
    fmt.Println("area of rect", area)
}
```

# Panic and Recover

idiomatic 符合语义的
The idiomatic way of handling abnormal conditions in a Go program is using [errors](https://golangbot.com/error-handling/). 
**But there are some situations where the program cannot continue execution after an abnormal condition. **

**In this case, we use `panic` to prematurely(过早地) terminate the program. When a [function](https://golangbot.com/functions/) encounters a panic, its execution is stopped, any [deferred](https://golangbot.com/defer/) functions are executed and then the control returns to its caller. This process continues until all the functions of the current [goroutine](https://golangbot.com/goroutines/) have returned at which point the program prints the panic message, followed by the stack trace and then terminates.** 

**It is possible to regain control of a panicking program using `recover`**

One important factor is that you should avoid panic and recover and use [errors](https://golangbot.com/error-handling/) where ever possible. Only in cases where the program just cannot continue execution should panic and recover mechanism be used.

There are two valid use cases for panic.

**An unrecoverable error where the program cannot simply continue its execution.**
	One example is a web server that fails to bind to the required port
**A programmer error.**
a [method](https://golangbot.com/methods/) that accepts a pointer as a parameter and someone calls this method using a `nil` argument. In this case, we can panic as it's a programmer error to call a method with `nil` argument which was expecting a valid pointer.

```go
func panic(interface{})  
```

数组越界也会造成panic

### Defer Calls During a Panic

### Recovering from a Panic

```go
func recover() interface{}  
```

Recover is useful only when called inside deferred functions. Executing a call to recover inside a deferred function stops the panicking sequence by restoring normal execution and retrieves the error message passed to the panic function call. If recover is called outside the deferred function, it will not stop a panicking sequence.

```go
func recoverFullName() {  
    if r := recover(); r!= nil {
        fmt.Println("recovered from ", r)
    }
}

func fullName(firstName *string, lastName *string) {  
    defer recoverFullName()
    if firstName == nil {
        panic("runtime error: first name cannot be nil")
    }
    if lastName == nil {
        panic("runtime error: last name cannot be nil")
    }
    fmt.Printf("%s %s\n", *firstName, *lastName)
    fmt.Println("returned normally from fullName")
}

func main() {  
    defer fmt.Println("deferred call in main")
    firstName := "Elon"
    fullName(&firstName, nil)
    fmt.Println("returned normally from main")
}
recovered from  runtime error: last name cannot be nil  
returned normally from main  
deferred call in main  
```

```go
func recoverInvalidAccess() {  
    if r := recover(); r != nil {
        fmt.Println("Recovered", r)
    }
}

func invalidSliceAccess() {  
    defer recoverInvalidAccess()
    n := []int{5, 7, 4}
    fmt.Println(n[4])
    fmt.Println("normally returned from a")
}
Recovered runtime error: index out of range [4] with length 3  
normally returned from main  
```

### Getting Stack Trace after Recover

 print the stack trace using the [PrintStack](https://golang.org/pkg/runtime/debug/#PrintStack) function of the Debug [package](https://golangbot.com/go-packages/)

```go
import (  
    "fmt"
    "runtime/debug"
)

func recoverFullName() {  
    if r := recover(); r != nil {
        fmt.Println("recovered from ", r)
        debug.PrintStack()
    }
}
```

### Panic, Recover and Goroutines

Recover works only when it is called from the same [goroutine](https://golangbot.com/goroutines/) which is panicking. **It's not possible to recover from a panic that has happened in a different goroutine.** 

# First Class Functions

**A language which supports first class functions allows functions to be assigned to variables, passed as arguments to other functions and returned from other functions. Go has support for first class functions.**

### Anonymous functions

```go
    a := func() {
        fmt.Println("hello world first class function")
    }
    a()
```

```go
func main() {  
    func() {
        fmt.Println("hello world first class function")
    }()
}
```

```go
func main() {  
    func(n string) {
        fmt.Println("Welcome", n)
    }("Gophers")
}
```

### User defined function types

```go
type add func(a int, b int) int  
```

```go
type add func(a int, b int) int

func main() {  
    var a add = func(a int, b int) int {
        return a + b
    }
    s := a(5, 6)
    fmt.Println("Sum", s)
}
```

### Higher-order functions

- **takes one or more functions as arguments**
- **returns a function as its result**

```go
func simple(a func(a, b int) int) {  
    fmt.Println(a(60, 7))
}

func main() {  
    f := func(a, b int) int {
        return a + b
    }
    simple(f)
}
```

```go
func simple() func(a, b int) int {  
    f := func(a, b int) int {
        return a + b
    }
    return f
}
```

### Closures

Closures are anonymous functions which access the variables defined outside the body of the function.

```go
func main() {  
    a := 5
    func() {
        fmt.Println("a =", a)
    }()
}
```

Every closure is bound to its own surrounding variable

```go
func appendStr() func(string) string {  
    t := "Hello"
    c := func(b string) string {
        t = t + " " + b
        return t
    }
    return c
}

func main() {  
    a := appendStr()
    b := appendStr()
    fmt.Println(a("World"))
    fmt.Println(b("Everyone"))

    fmt.Println(a("Gopher"))
    fmt.Println(b("!"))
}
Hello World  
Hello Everyone  
Hello World Gopher  
Hello Everyone !  
```

### Practical use of first class functions

```go
func filter(s []student, f func(student) bool) []student {  
    var r []student
    for _, v := range s {
        if f(v) == true {
            r = append(r, v)
        }
    }
    return r
}

s := []student{s1, s2}
f := filter(s, func(s student) bool {
  if s.grade == "B" {
    return true
  }
  return false
})

c := filter(s, func(s student) bool {  
    if s.country == "India" {
        return true
    }
    return false
})


func iMap(s []int, f func(int) int) []int {  
    var r []int
    for _, v := range s {
        r = append(r, f(v))
    }
    return r
}
    a := []int{5, 6, 7, 8, 9}
    r := iMap(a, func(n int) int {
        return n * 5
    })
```

# reflection

Reflection is the ability of a program to inspect its variables and values at run time and find their type. 

```go
func createQuery(q interface{}) {  
    t := reflect.TypeOf(q)
    k := t.Kind() // Kind  struct  
    v := reflect.ValueOf(q)
    fmt.Println("Type ", t) //Type  main.order  
    fmt.Println("Value ", v) 
}

```

```go
func createQuery(q interface{}) {  
    if reflect.ValueOf(q).Kind() == reflect.Struct {
        v := reflect.ValueOf(q)
        fmt.Println("Number of fields", v.NumField())
        for i := 0; i < v.NumField(); i++ {
            fmt.Printf("Field:%d type:%T value:%v\n", i, v.Field(i), v.Field(i))
        }
    }

}
```

# Reading Files

```go
import (  
    "fmt"
    "io/ioutil"
)

func main() {  
    data, err := ioutil.ReadFile("test.txt")
    if err != nil {
        fmt.Println("File reading error", err)
        return
    }
    fmt.Println("Contents of file:", string(data))
}
```

```go
func main() {  
    fptr := flag.String("fpath", "test.txt", "file path to read from")
    flag.Parse()

    f, err := os.Open(*fptr)
    if err != nil {
        log.Fatal(err)
    }
    defer func() {
        if err = f.Close(); err != nil {
        log.Fatal(err)
    }
    }()
    s := bufio.NewScanner(f)
    for s.Scan() {
        fmt.Println(s.Text())
    }
    err = s.Err()
    if err != nil {
        log.Fatal(err)
    }
}
```

# Write File

```go
func main() {  
    f, err := os.Create("test.txt")
    if err != nil {
        fmt.Println(err)
        return
    }
    l, err := f.WriteString("Hello World")
    if err != nil {
        fmt.Println(err)
        f.Close()
        return
    }
```

### Writing bytes to a file

```go
    d2 := []byte{104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100}
    n2, err := f.Write(d2)
```

### Appending to a file

```go
func main() {  
    f, err := os.OpenFile("lines", os.O_APPEND|os.O_WRONLY, 0644)
    if err != nil {
        fmt.Println(err)
        return
    }
    newLine := "File handling is easy."
    _, err = fmt.Fprintln(f, newLine)
```

### Writing to file concurrently

multiple goroutines write to a file concurrently

# [Module](https://www.practical-go-lessons.com/chap-17-go-modules)

A module is a group of packages (or a single package) that are (is) versioned.A module is a group of packages (or a single package) that are (is) versioned. This group of go files forms together a **module**. Modules can be dependant on other modules.

A module is identified by a string which is called the “module path”.

Go will use **go.mod** file for each installation to build the module.

go get command uses a **proxy** to fetch the latest releases of modules. 

# JSON

```go
func main() {
    myJson := []byte(`{"cat":{ "name":"Joey", "age":8}}`)
    c := MyJson{} //create a new empty MyJson struct
    err := json.Unmarshal(myJson,&c)
    if err != nil {
        panic(err)
    }
    fmt.Println(c.Cat.Name)
    fmt.Println(c.Cat.Age)
}
```

#### Struct Tags

![Type Struct to JSON with struct tags](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/03/2920210329163323.png)

```go
//Marshal JSON 
type Product struct {
    ID    uint64
    Name  string
    SKU   string
    Cat   Category
}
type Category struct {
    ID   uint64
    Name string
}
p := Product{ID: 42, Name: "Tea Pot", SKU: "TP12", Category: Category{ID: 2, Name: "Tea"}}

b, err := json.Marshal(p)
if err != nil {
    panic(err)
}
fmt.Println(string(b))
//{"ID":42,"Name":"Tea Pot","SKU":"TP12","Price":30.5,"Category":{"ID":2,"Name":"Tea"}}
```

unmarshal 编出

```
bI, err := json.MarshalIndent(p,"","    ") //缩进排版
```

```
type Product struct {
    ID   uint64 `json:"id"`
    Name string `json:"name,omitempty"`  //ignore empty fields
        Description string `json:"-"`  //skip a field
}
```

# [Marshal / Unmarshal XML](https://www.practical-go-lessons.com/chap-25-json-and-xml)

```
type MyXML struct {
    Cat `xml:"cat"`
}

type Cat struct {
    Name string `xml:"name"`
    Age  uint   `xml:"age"`
}

myJson := []byte(`<cat>
    <name>Ti</name>
    <age>23</age>
</cat>`)
c := MyXML{}
err := xml.Unmarshal(myJson, &c)

p := Product{ID: 42, Name: "Tea Pot", SKU: "TP12", Category: Category{ID: 2, Name: "Tea"}}
bI, err := xml.MarshalIndent(p, "", "   ")
```

Remember that you have to add a header to your XML :

```
<?xml version="1.0" encoding="UTF-8"?>
```

```
xmlWithHeader := xml.Header + string(bI)
```

