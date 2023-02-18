202207131307
Status: #idea

Tags:

# Pattern matching

A core feature in what makes Elixir such a joy to write in. Instead of banging your head against the wall, trying to make typescript/javascript function overloads a thing, which often ends up in either:
- a single function with many different names
- or, a function with many if's and else's

Instead of writing this:
```javascript
const updateUser = (name, age) => {
	if (age < 10) {
		return "Too young"
	}
	if (name === 'Gatsby') {
		return "Hello Miss President"
	}
	Service.updateUser(name, age)
}
```

One can write this:
```elixir
def update_user(_name, age) where age < 10, do: "Too young" 
def update_user(name = "Gatsby", _age), do: "Hello Miss President"
def update_user(name, age), do: Service.update_user(name, age)
```

This was but a simple example, but Pattern matching works across just about all the different primitives in Elixir;

```elixir
# Maps
def update_user(%{ name = "Gatsby" } = user), do: "Hello Miss President"

# List
def update_user([1, 2, 3] = list), do: "Nice row"
```

---
# references