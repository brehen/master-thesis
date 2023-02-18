# Title: The Rust Programming Language

## Metadata

- `Tags:` #rust #beginner 
- `Type:` [[{]]
- `Author:` 
	- `Notable Authors:` 
- `Keywords:` 
- `General Subject:` 
- `Specific Subject:` 
- `ISBN:` 
- `DOI:` 
- `Publish Date:` 
- `Reviewed Date:` 

## Citation

```latex

```

## Notes:

### Chapter 1 

The following snippet defines a function named `main()`. This is the entry to our program when running the compiled result of our rust program. 
```rust
fn main() {

}
```

The cargo project file is written in TOML, and might look like this;
```toml
[package]
name = "hello_cargo"
version = "0.1.0"
edition = "2021"

[dependencies]
```

All Rustaceans run `cargo check` to make sure their code still compiles, rather than cargo build, which needs to create the executable each time.

Run `cargo build --release` to compile with optimisations for production.

For smaller projects, using cargo doesn't provide a lot of value, over just creating separate files and compiling them with `rustc`. But once a project grows into multiple files with multiple dependencies, then the value is much more apparent.

### Chapter 2 (Project)

> Let's build a guessing game!

First iteration: 
```rust
use std::io; // Import input/output utils from standard library

fn main() {
    println!("Guess the number!"); // Print a text line

    println!("Please input your guess."); // Print a text line with prompt

    let mut guess = String::new(); // Define _mutable_ guess as a String

    io::stdin() // Call on method stdin in io. 
        .read_line(&mut guess) // Read the line from io and write to mutable guess
        .expect("Failed to read line"); // In case the previous method fails, fail gracefully.

    println!("You guessed: {guess}"); // Print out what the user guessed
}
```

### Chapter 3
### Chapter 4
### Chapter 5
### Chapter 6
### Chapter 7
### Chapter 8
### Chapter 9
### Chapter 10
### Chapter 11
### Chapter 12 (Project)
### Chapter 13
### Chapter 14
### Chapter 15
### Chapter 16
### Chapter 17
### Chapter 18
### Chapter 19
### Chapter 20 (Project)

## Summary of key points:

- 

## Context:

==(How this article relates to other work in the field; how it ties in with key issues and findings by others, including yourself)==

- 

## Cited References 

==to follow up on (cite those obviously related to your topic AND any papers frequently cited by others because those works may well prove to be essential as you develop your own work):==

- 

## Other Comments:

- 