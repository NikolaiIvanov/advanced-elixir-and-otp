# Polymorphysm with Protocols

## What is Polymorphysm?
> Polymorphysm in a programming language is the ability to represent different data types through a common interface

#
## Protocols
> The Elixir way for type Polymorphysm

> Define a series of functions that must be implemented.
> Allow implementing those functions for target data types

#
### Enum uses Enumerable Protocol

> Enumerable - a Protocol that binds collections of different types through a common interface

|   →  |   Enum    |  ←    |
| :--: | :-------: | :---: |
|  ↑   | Enumerable|   ↑   |
| List |    Map    | Tuple |

#
## Inspectable
> Exposes a dump function for logging type information

| Inspectable  |
| :----------: |
| dump(element)|

Define a Protocol - Inspectable - that exposes a dump function for logging type information.

```elixir
defprotocol Inspectable do
  def typeof(element)
end

defimpl Inspectable, for: BitString  do
  def typeof(string), do: String
end

defimpl Inspectable, for: Integer  do
  def typeof(0), do: "ZERO!"

  def dump(integer), do: Integer
end

iex> Inspectable.dump(1)       
"INTEGER: 1"

iex> Inspectable.typeof(0)
"ZERO!"

iex> Inspectable.typeof("Hello")
String
```
#
## Any
> Elixir exposes the Any construct on Protocols

### Default implementation of a Protocol for all data types. Has to be specifically enabled for the protocol.

```elixir
defmodule Point do
  defstruct x: 0, y: 0, z: 0
end


defprotocol Inspectable do
  @fallback_to_any true

  def typeof(element)
end

defimpl Inspectable, for: BitString  do
  def typeof(string), do: String
end

defimpl Inspectable, for: Integer  do
  def typeof(0), do: "ZERO!"

  def typeof(integer), do: Integer
end

defimpl Inspectable, for: Any  do
  def typeof(_), do: "A random element"
end

defimpl Inspectable, for: Point do
  def typeof(%Point{x: x, y: y, z: z}) do
    "(#{x}, #{y}, #{z})"
  end
end

iex> point = %Point{x: 1, y: -20, z: 10}
%Point{x: 1, y: -20, z: 10}

iex> Inspectable.typeof(point)
"(1, -20, 10)"

```
