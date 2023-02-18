---
id: "Reference Notes/🎓 Polyglot programming.md"
aliases:
  - "Title: Polyglot Programming - TS, Go and Rust"
tags: []
---

# Title: Polyglot Programming - TS, Go and Rust

202210201429 Status: #todo

## Metadata

- `Tags:` #rust #typescript #go
- `Keywords:`
- `General Subject:`
- `Specific Subject:`
- `Course completed:`

## Citation

```latex
```

## Notes

### Values, references and mutation (Rust)

In Rust, we have 3 types to think about

- Value, the thing itself
  - Only one value owner
  - If the object implements `copy` it can be implicitly copied
- Reference, a reference to a value
  - You can have as many references as you like. Shorthand:
    `let x = 5; let y = &x`
    - Referencing a value, `moves` the pointer to the value to the new
      reference.
- Mutable reference, a reference to a value that you can also [[mutate]]
  - You `can't` have a mutable reference to a value that is already referenced
    at the same time.

### Types, structs and traits

Types look similar across the three languages, but are written slightly
differently.

In [[Go]], types are generally defined like so:

```go
type Point struct {
  x int
  y int
}

type Line struct {
  p1 *Point
  p2 *Point
}
```

In [[Rust]]:

```rust
struct Point {
  x: i32,
  y: i32,
}

struct Line {
  x: Point,
  y: Point,
}
```

In [[TypeScript]]:

```ts
type Point = {
  x: number;
  y: number;
};

type Line = {
  p1: Point;
  p2: Point;
};
```

```rust
#[derive(Debug)] // Important
struct Point {
  x: i32,
  y: i32
}
```

[[TypeScript project structure]]

```ls
node_modules/
src/
.configrc.json
package.json
.config2rc.cjs
...etc
```

[[Golang project structure]]

```ls
cmd/
  main.go
pkg/
  export_name/
  thing.go
 ...
...
go.mod
```

[[Rust project structure]]

```
src/
  bin/
    binary_1.rs
    binary_2.rs
    ...
  lib.rs
  file_1.rs
  errors.rs
target/
  ... build stuff ...
Cargo.toml
```

[[1673971459-rust-enums|Rust enums]]

In Rust, you can write [[1673971551-enums|enums]] like so:

```rust
pub enum Operation {
  Print,
  Add,
  Remove
}
```

This is comprised of several facets. First of all, with the prefixed `pub`, we
can assume it will be publically available and can be imported like:

`TODO: Find out how to import enum`

Then followed by `enum` and the name of the enum, usually uppercased.

Then in the code you reference it like so:

```rust
if(A === Operation.Print) do ehm // TODO: WHAT IS THIS
```

Furthermore, you can even pimp these enum properties with macros, and generics:

```rust
pub enum Operation{
  Print(Option<String>), // <- Specifiy that the Print can be an optional String
  Add((String, String)), // <- Specifiy that the type has to be a tuple of strings
  Remove(String), // <- Specify that the type has to be a String
```

Note to self: I have decided to ignore the go and typescript parts, and just watch the rust videos. I already know a lot of TypeScript, and I have no desire to write Go.


#### [[Rust testing]]

Testing in rust is `fantastic`, according to the Prime. Not sure if I agree yet, but I'm willing to hear him out. Testing in JS-land is not optimal by any measure.

How to write a test in rust:
```rust
#[cfg(test)] // Macro that sets up the following `object`/whatever to be a test.
mod test {
	#[test] // Macro that `injects` the magic that's required to support a test.
	fn test_a_function() {
		exp
	}
}
```


#### [[Rust pattern matching]]

Pattern matching is a great feature in programming languages, that is also present in Rust.

Example:

```rust
let Some(p) = curr 
```


### Project: CLI app, "projector"

Description: Print out all environments in current path

\[ cli opts \] -> \[ Project config \] +-> \[print \] -> \[display\] | +->
\[add\] -> \[save\] | +-> \[rm\] -> \[save\]

CLI arg parsing

#### Node

package: commaind-line-args

#### Golang

package: argparse

#### Rust

package: clap

---

## References

[[Rust project structure]]

## Summary of key points

- Rust ensures safety through living on edge safe boundaries.

## Context

==(How this article relates to other work in the field; how it ties in with key
issues and findings by others, including yourself)==

-

## Significance

==(to the field; in relation to your own work)==

-

## Important Figures and/or Tables

==(brief description; page number)==

-

## Cited References

==to follow up on (cite those obviously related to your topic AND any papers
frequently cited by others because those works may well prove to be essential as
you develop your own work):==

-

## Other Comments

-
