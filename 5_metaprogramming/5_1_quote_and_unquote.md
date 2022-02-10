# Quote and UnQuote

## AST - Abstract Syntax Tree

| say_to(:David, "Hello!")          |
|:---------------------------------:|
|     ↓ Tuple - exposes to ↓        |
| {:say_to, [], [:David, "Hello!"]} |
| Function name, [metadata], [list of subsequent notes]|

## Quote Macro
```elixir
# Integer
iex> quote do: 1
1

# String
iex> quote do: "Hello"
"Hello"

# List
iex> quote do: [1,2,3,4]
[1, 2, 3, 4]

# Tuple
iex> quote do: {:a, 2}
{:a, 2}

# Map
iex> quote do: %{a: 2} 
{:%{}, [], [a: 2]}

iex> quote do: [a: 2, b: "Hello"]
[a: 2, b: "Hello"]

iex> quote do
...> hello(1, name)
...> end
{:hello, [], [1, {:name, [], Elixir}]}

```
#
## Unquote Macro
| quote do: 1 + 2    |
|:------------------:|
|      ↓ Tuple ↓     |
| {:+, [...], [1,2]} |

```elixir
iex> quote do: unquote(1+2)
3
```

```elixir
iex> name = "David"
"David"

iex> quote do: unquote(name)
"David"

iex> quote do
...> name
...> end
{:name, [], Elixir}

iex> quote do
...> hello(unquote(name), 20)
...> end
{:hello, [], ["David", 20]}
```