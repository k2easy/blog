 

流行游戏聊天服务 Discord [透露](https://blog.discord.com/why-discord-is-switching-from-go-to-rust-a190bbca2b1f)，该公司用 Rust 语言开发了客户端和服务端组件，在切换到 Rust 实现之后性能有了显著改进。Discord 称在某些领域 Rust 是首要选择的语言。它此前用 Go 语言开发了名为 Read States 的服务，但因为性能问题该服务难以满足产品需求，Go 实现的 Read States 每隔数分钟就会出现延迟飙升。问题与 Go 的内存模式和垃圾收集有关，而 Rust 没有垃圾收集。对比发现 Rust 实现的版本在没怎么优化的情况下性能就超过了优化过的 Go 实现版本。

https://blog.discord.com/why-discord-is-switching-from-go-to-rust-a190bbca2b1f

# [install](https://www.rust-lang.org/learn/get-started)

  Rustup: the Rust installer and version management tool

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
下载失败，因为rust被墙了，.zshrc中加入镜像
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
重启item2即可
```

```
 -s/--silent静音模式。不输出任何东西
 -S/--show-error   显示错误
 -f/--fail          连接失败时不显示http错误
```

`rustup update` 升级rust

 同时安装了Cargo: the Rust build tool and package manager
cargo --version

- build your project with `cargo build`
- run your project with `cargo run`
- test your project with `cargo test`
- build documentation for your project with `cargo doc`
- publish a library to [crates.io](https://crates.io/) with `cargo publish`

vscode rust 插件

```
cargo new hello-rust 
```

generate a new directory called `hello-rust` with the following files:

```
hello-rust
|- Cargo.toml //
|- src
  |- main.rs

cargo run 
```

cargo.toml , manifest file for Rust. It’s where you keep metadata for your project, as well as dependencies.

 Adding dependencies,libraries on [crates.io](https://crates.io/), 
In Rust, we often refer to packages as “crates.”//木箱
Cargo.toml 新增依赖

```
[dependencies]
ferris-says = "0.2"
```

**cargo build**，install  dependency，`Cargo.lock`. This file is a log of the exact versions of the dependencies we are using locally.

```
//main.rs
use ferris_says::say; 
// use the say function that the ferris-says crate exports for us. 
use std::io::{stdout, BufWriter};

fn main() {
    let stdout = stdout();
    let message = String::from("Hello fellow Rustaceans!");
    let width = message.chars().count();

    let mut writer = BufWriter::new(stdout.lock());
    say(message.as_bytes(), width, &mut writer).unwrap();
}
```

**rust含义**

Ferris is the unofficial mascot of the Rust Community，Ferris is a name playing off of the adjective, “ferrous 铁的,” meaning of or pertaining附属 to iron. Since Rust生锈 often forms on iron, it seemed like a fun origin for our mascot’s吉祥物 name!
Rust promgrammer is called Rustaceans。

all tools are installed to the `~/.cargo/bin` directory, and this is where you will find the Rust toolchain, including `rustc`, `cargo`, and `rustup`. add bin direcotry to path .

```
rustc --version
rustup self uninstall //Uninstall Rust
rustup docs --book 
```



# cargo

```
cargo --version
cargo new hello-rust
cargo.toml 新增依赖
ferris-says = "0.2"

cargo build //安装依赖
cargo run   // target/debug/hello-rust,如果build编译后代码无改动就会直接运行编译好的文件，不会再次编译
```

```
cargo -h
-V --version
--list              List installed commands
-v, --verbose           Use verbose output (-vv very verbose/build.rs output)

    build, b    Compile the current packagev ,生成可执行文件，--release
    check, c    Analyze the current package and report errors, but don't build object files   只编译检查错误，不生成可执行文件，这样编译速度会快很多。
    clean       Remove the target directory
    doc         Build this package's and its dependencies' documentation
    new         Create a new cargo package
    init        Create a new cargo package in an existing directory
    run, r      Run a binary or example of the local package 
    					//运行编译好的二进制文件 或 本地目录
    test, t     Run the tests
    bench       Run the benchmarks
    update      Update dependencies listed in Cargo.lock
    search      Search registry for crates
    publish     Package and upload this package to the registry
    install     Install a Rust binary. Default location is $HOME/.cargo/bin
    uninstall   Uninstall a Rust binary
```

在 `cargo.toml` 文件中添加了依赖之后，运行 `cargo build` 命令时，如果卡在 `blocking waiting for file lock on package cache lock` 这里，在你尝试了网上其他解决方法无效后，有可能是网络的问题，需要给 cargo 换源**或者**借助代理来解决 。

在 ～/.cargo/config 配置国内镜像，国内的镜像这些大学的镜像也特别不稳定。 ，

```
# 放到 `$HOME/.cargo/config` 文件中
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"

# 替换成你偏好的镜像源
replace-with = 'sjtu'

# 清华大学
[source.tuna]
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"

# 中国科学技术大学
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"

# 上海交通大学
[source.sjtu]
registry = "https://mirrors.sjtug.sjtu.edu.cn/git/crates.io-index"

# rustcc社区
[source.rustcc]
registry = "git://crates.rustcc.cn/crates.io-index"
```

cd 空格即可转到当前用户主目录

```
一直出现 Blocking waiting for file lock on package cache
如果确定没有多个程序占用，可以删除rm -rf ~/.cargo/.package-cache，然后再执行。
可能原因：cargo build后，未执行结束被终止了。
```

- We can build a project using `cargo build`.
- We can build and run a project in one step using `cargo run`.
- We can build a project without producing a binary to check for errors using `cargo check`.

  上述命令执行结果都在 *target/debug* directory.

`cargo build --release` to compile it with optimizations,target/release

# Guess Game

```python
use std::io;
fn main(){
    println!("Guess the number!");
    println!("Please input your guess.");

    let mut guess = String::new();
    io::stdin()
        .read_line(&mut guess)
        .expect("Failed to read line");
    println!("You guessed:{}",guess);
}
```



`main` function is the entry point into the program
`println!` is a macro that prints a string to the screen
mut可变的， In Rust, variables are immutable by default. 
`String::new`, a function that returns a new instance of a `String`，a new empty string.

The `stdin` function returns an instance of [`std::io::Stdin`](https://doc.rust-lang.org/std/io/struct.Stdin.html), which is a type that represents a handle to the standard input for your terminal.

`read_line` is to take whatever the user types into standard input and place that into a string, so it takes that string as an argument. The string argument needs to be mutable so the method can change the string’s content by adding the user input.

The `&` indicates that this argument is a *reference*

 variables, references are immutable by default. Hence, you need to write `&mut guess` rather than `&guess` to make it mutable.

[Handling Potential Failure with the `Result` Type](https://doc.rust-lang.org/book/ch02-00-guessing-game-tutorial.html#handling-potential-failure-with-the-result-type)

`read_line` puts what the user types into the string we’re passing it, but it also returns a value—in this case, an [`io::Result`](https://doc.rust-lang.org/std/io/type.Result.html). 

Rust has a number of types named `Result` in its standard library: a generic [`Result`](https://doc.rust-lang.org/std/result/enum.Result.html) .
For `Result`, the variants are `Ok` or `Err`. 

An instance of `io::Result` has an [`expect` method](https://doc.rust-lang.org/std/result/enum.Result.html#method.expect) that you can call. If this instance of `io::Result` is an `Err` value, `expect` will cause the program to crash and display the message that you passed as an argument to `expect`. If this instance of `io::Result` is an `Ok` value, `expect` will take the return value that `Ok` is holding and return just that value to you so you can use it. 

随机数

```
[dependencies]
rand = "0.5.5"

cargo build //编译，从registry crates.io 下载依赖
```

 [Semantic Versioning](http://semver.org/) (sometimes called *SemVer*) is a standard for writing version numbers. The number `0.5.5` is actually shorthand for `^0.5.5`, which means any version that is at least `0.5.5` but below `0.6.0`.

build时重新生成 cargo.lock 

If the `rand` crate has released two new versions, `0.5.6` and `0.6.0`,

```
$ cargo update
    Updating crates.io index
    Updating rand v0.5.5 -> v0.5.6
```

如果想升级到`0.6.0`,需要修改 cargo.toml 文件，`cargo build`

# 3. Common Concepts

```
let x=5;
x= 6; //异常 

let mut x =5;
x=6;// ok
```

When a variable is immutable, once a value is bound to a name, you can’t change that value.

```
const MAX_POINTS: u32 = 100_000;
```

> Rust’s naming convention for constants is to use all uppercase with underscores between words, and underscores can be inserted in numeric literals to improve readability)

**shadowing**

```
let x =5;
let x = x + 1;
let x = x * 2;
println!("{}",x) //12
```

>  相对于 let mut，shadowing 可以改变变量类型，更像是新生成的同名变量

```
   let test ="  ";
    let test = test.len();
```

### Data Types 

```rust
    let guess:u32 = "123".parse().expect("Not a number");
```

## 基本类型

**整数**

| Length  | Signed  | Unsigned |
| ------- | ------- | -------- |
| 8-bit   | `i8`    | `u8`     |
| 16-bit  | `i16`   | `u16`    |
| 32-bit  | `i32`   | `u32`    |
| 64-bit  | `i64`   | `u64`    |
| 128-bit | `i128`  | `u128`   |
| arch    | `isize` | `usize`  |

| Number literals  | Example       |
| ---------------- | ------------- |
| Decimal          | `98_222`      |
| Hex              | `0xff`        |
| Octal            | `0o77`        |
| Binary           | `0b1111_0000` |
| Byte (`u8` only) | `b'A'`        |

**浮点型**

`f32` and `f64`, which are 32 bits and 64 bits in size, respectively. The default type is `f64` because on modern CPUs it’s roughly the same speed as `f32` but is capable of more precision.

```
let f: bool = false; // with explicit type annotation
```

**字符型**

```
let heart_eyed_cat = '😻';
```

单引号 字符，双引号字符串 

## **组合类型**

**元组**

```
let tup: (i32, f64, u8) = (500, 6.4, 1);

let tup = (500, 6.4, 1);
let (x, y, z) = tup;
```





前端自动化测试 Cypress







## enum

```rust
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}
impl Message {
  fn call(&self) {
    // method body would be defined here
  }
}

let m = Message::Write(String::from("hello"));
m.call();
	
```

### [The `Option` Enum and Its Advantages Over Null Values](https://doc.rust-lang.org/book/ch06-01-defining-an-enum.html#the-option-enum-and-its-advantages-over-null-values)

The problem with null values is that if you try to use a null value as a not-null value, you’ll get an error of some kind. Because this null or not-null property is pervasive, it’s extremely easy to make this kind of error.

Rust does not have nulls, but it does have an enum that can encode the concept of a value being present or absent. This enum is `Option<T>`

```
enum Option<T>{
	Some(T),
	None,
}
```

 you can use `Some` and `None` directly without the `Option::` prefix.



[`Debug`](https://doc.rust-lang.org/std/fmt/trait.Debug.html) formatter:

```rust
use std::collections::HashMap;

fn main() {
    let mut hash = HashMap::new();
    hash.insert("Daniel", "798-1364");
    println!("{:?}", hash);
}
```

`Option<T>` and `T` (where `T` can be any type) are different types,

```rust
enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter,
}

fn value_in_cents(coin: Coin) -> u8 {
    match coin {
        Coin::Penny => {
            println!("Lucky penny!");
            1
        }
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter => 25,
    }
}

fn main() {}
```

```
    fn plus_one(x: Option<i32>) -> Option<i32> {
        match x {
            None => None,
            Some(i) => Some(i + 1),
        }
    }

    let five = Some(5);
    let six = plus_one(five);
    let none = plus_one(None);
```

_ 占位符 

```
    let some_u8_value = 0u8;
    match some_u8_value {
        1 => println!("one"),
        3 => println!("three"),
        5 => println!("five"),
        7 => println!("seven"),
        _ => (),
    }
```



## 6.3 [Concise Control Flow with `if let`](https://doc.rust-lang.org/book/ch06-03-if-let.html#concise-control-flow-with-if-let)

```
    let some_u8_value = Some(0u8);
    match some_u8_value {
        Some(3) => println!("three"),
        _ => (),
    }
    等同于 
    if let Some(3) = some_u8_value {
        println!("three");
    }

```

# 7 [Packages, Crates, and Modules](https://doc.rust-lang.org/book/ch07-00-managing-growing-projects-with-packages-crates-and-modules.html#managing-growing-projects-with-packages-crates-and-modules)

- **Packages:** A Cargo feature that lets you build, test, and share crates
- **Crates:** A tree of modules that produces a library or executable
- **Modules** and **use:** Let you control the organization, scope, and privacy of paths
- **Paths:** A way of naming an item, such as a struct, function, or module

 cargo new my-project

## [Defining Modules to Control Scope and Privacy](https://doc.rust-lang.org/book/ch07-02-defining-modules-to-control-scope-and-privacy.html#defining-modules-to-control-scope-and-privacy)

`cargo new --lib restaurant`
src>restaurant>src>lib.rs

## [Paths for Referring to an Item in the Module Tree](https://doc.rust-lang.org/book/ch07-03-paths-for-referring-to-an-item-in-the-module-tree.html#paths-for-referring-to-an-item-in-the-module-tree)

- An *absolute path* starts from a crate root by using a crate name or a literal `crate`.
- A *relative path* starts from the current module and uses `self`, `super`, or an identifier in the current module.

 double colons `::`

```
mod front_of_house {
    mod hosting {
        fn add_to_waitlist() {}
    }
}

pub fn eat_at_restaurant() {
    // Absolute path
    crate::front_of_house::hosting::add_to_waitlist();

    // Relative path
    front_of_house::hosting::add_to_waitlist();
}
```

```
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}
```

```rust
fn serve_order() {}

mod back_of_house {
    fn fix_incorrect_order() {
        cook_order();
        super::serve_order();
    }

    fn cook_order() {}
}
```

### [Making Structs and Enums Public](https://doc.rust-lang.org/book/ch07-03-paths-for-referring-to-an-item-in-the-module-tree.html#making-structs-and-enums-public)

```rust
mod back_of_house {
    pub struct Breakfast {
        pub toast: String,
        seasonal_fruit: String,
    }

    impl Breakfast {
        pub fn summer(toast: &str) -> Breakfast {
            Breakfast {
                toast: String::from(toast),
                seasonal_fruit: String::from("peaches"),
            }
        }
    }
}

pub fn eat_at_restaurant() {
    // Order a breakfast in the summer with Rye toast
    let mut meal = back_of_house::Breakfast::summer("Rye");
    // Change our mind about what bread we'd like
    meal.toast = String::from("Wheat");
    println!("I'd like {} toast please", meal.toast);

    // The next line won't compile if we uncomment it; we're not allowed
    // to see or modify the seasonal fruit that comes with the meal
    // meal.seasonal_fruit = String::from("blueberries");
}
```

```rust

mod back_of_house {
    pub enum Appetizer {
        Soup,
        Salad,
    }
}

pub fn eat_at_restaurant() {
    let order1 = back_of_house::Appetizer::Soup;
    let order2 = back_of_house::Appetizer::Salad;
}
```



## [Bringing Paths into Scope with the `use` Keyword](https://doc.rust-lang.org/book/ch07-04-bringing-paths-into-scope-with-the-use-keyword.html#bringing-paths-into-scope-with-the-use-keyword)

 bring the `crate::front_of_house::hosting` module into the scope of the `eat_at_restaurant` function 

```
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}

use crate::front_of_house::hosting;
// use self::front_of_house::hosting;

pub fn eat_at_restaurant() {
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
}
```

### [Creating Idiomatic `use` Paths](https://doc.rust-lang.org/book/ch07-04-bringing-paths-into-scope-with-the-use-keyword.html#creating-idiomatic-use-paths)

```
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}

use crate::front_of_house::hosting::add_to_waitlist;

pub fn eat_at_restaurant() {
    add_to_waitlist();
    add_to_waitlist();
    add_to_waitlist();
}
```

idiomatic 不能相同，可以使用别名 

```

use std::fmt::Result;
use std::io::Result as IoResult;

fn function1() -> Result {
    // --snip--
}

fn function2() -> IoResult<()> {
    // --snip--
}
```

### [Re-exporting Names with `pub use`](https://doc.rust-lang.org/book/ch07-04-bringing-paths-into-scope-with-the-use-keyword.html#re-exporting-names-with-pub-use)

```
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}

pub use crate::front_of_house::hosting;

pub fn eat_at_restaurant() {
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
}
```

```
use std::io;
use std::io::Write;

use std::io::{self, Write};

use std::collections::*; //glob operator
```

# [8. Common Collections](https://doc.rust-lang.org/book/ch08-00-common-collections.html#common-collections)

 Unlike the built-in array and tuple types, the data these collections point to is stored on the heap, which means the amount of data does not need to be known at compile time and can grow or shrink as the program runs. Each kind of collection has different capabilities and costs, and choosing an appropriate one for your current situation is a skill you’ll develop over time. I

## [Storing Lists of Values with Vectors](https://doc.rust-lang.org/book/ch08-01-vectors.html#storing-lists-of-values-with-vectors)

```
    let v: Vec<i32> = Vec::new();
        let v = vec![1, 2, 3];
```

```
    let mut v = Vec::new();

    v.push(5);
    v.push(6);
    v.push(7);
    v.push(8);
```

The numbers we place inside are all of type `i32`, and Rust infers this from the data, so we don’t need the `Vec<i32>` annotation.



学起来太复杂了，我需要快速能做出产品的技术框架，现有1再去优化

