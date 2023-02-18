202206052112
Status: #idea

Tags: [[Elixir]] - [[Features]]

# Comprehension
Comprehensions in [[Elixir]] are syntactic sugar to reduce the amount of code required to perform common operations on enumerables. 

Examples: 

Simple map and transform:
```
iex> for n < [1, 2, 3, 4], do: n * n
[1, 4, 9, 16]
```

[[Pattern matching]]:
```
iex> values = [good: 1, good: 2, bad: 3, bad: 4]
iex> for {:good, n} <- values, do: n * n
[1, 4]
```

[[Filtering]]:
```
iex> for n <- 0..10, rem(n, 3) == 0, do: n * n
[0, 9, 36, 81]
```

[[Bitstring]] generators:

```
iex> pixels = <<213, 45, 132, 64, 76, 32, 76, 0, 0, 234, 32, 15>>
iex> for <<r::8, g::8, b::8 <- pixesl>>, do: {r, g, b}
[{213, 45, 132}, {64, 78, 32}, {76, 0, 0}, {234, 32, 15}]
```

---
# references