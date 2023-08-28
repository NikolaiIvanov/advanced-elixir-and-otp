# Streaming Computations

## Enumerables
> Collection Types - data types that allow the composition of other data types.

- Lists - ordered sets of elements
- Maps - which allow orbitally index up values via keys

```elixir
iex> Enum.to_list 1..5
[1, 2, 3, 4, 5]

iex> Enum.into 1..5, []
[1, 2, 3, 4, 5]

iex> Enum.into 1..5, %{}, &{&1, &1}
%{1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5}

iex> Enum.to_list ?a..?e             
'abcde'

iex> Enum.into 1..5, %{}, &{&1 |> Integer.to_string() |> String.to_atom(), &1}
%{"1": 1, "2": 2, "3": 3, "4": 4, "5": 5}

iex>list = [1, 2, 3, 4, 5]
[1, 2, 3, 4, 5]

iex> Enum.at(list, 0)
1

iex> map = %{one: 1, two: 2}
%{one: 1, two: 2}

iex> Enum.at(map, 0)        
{:one, 1}
``` 
#
## Module Sizeable
```elixir
defmodule Sizeable do
  def first(enum) do
    Enum.at(enum, 0)
  end
end

iex>list = [1, 2, 3, 4, 5]
[1, 2, 3, 4, 5]

iex> Sizeable.first(list)
1
```

## Enumerable - A protocol that binds Enumerable collection types
- Collections have a variable number of elements
- One can verfy if an element belongs to a collection
- Collections can be reduced by means of a function and accumulator

## Transformation functions
- filter/2
- map/2
- reduce/3

```elixir
iex> 1..100 |> Enum.filter(fn(x) -> rem(x, 2) == 0 end)
[2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42,
 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82,
 84, 86, 88, 90, 92, 94, 96, 98, 100]

iex> 1..100 |> Enum.filter(fn(x) -> rem(x, 2) == 0 end) |> Enum.map(fn(x) -> x * x end)
[4, 16, 36, 64, 100, 144, 196, 256, 324, 400, 484, 576, 676, 784, 900, 1024,
 1156, 1296, 1444, 1600, 1764, 1936, 2116, 2304, 2500, 2704, 2916, 3136, 3364,
 3600, 3844, 4096, 4356, 4624, 4900, 5184, 5476, 5776, 6084, 6400, 6724, 7056,
 7396, 7744, 8100, 8464, 8836, 9216, 9604, 10000]

iex> 1..100 |> Enum.filter(fn(x) -> rem(x, 2) == 0 end) |> Enum.map(fn(x) -> x *x end) |> Enum.reduce(1, fn(x, acc) -> x * acc end)
1172598438026726424225841189879925155913793199602752542539067407440522905183549302893354249487566805661643501091722190953657497125126144000000000000000000000000
```

#
## Project Euler
## Exercise 1
- If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6, and 9
- The sum of these multiples is 23
- Find the sum of all the multipes of 3 or 5 below 1000

```elixir
range = 1..9
iex> range |> Enum.filter(fn(x) -> rem(x, 3) == 0 || rem(x, 5) == 0 end) 
[3, 5, 6, 9]

iex> range |> Enum.filter(fn(x) -> rem(x, 3) == 0 || rem(x, 5) == 0 end) |> Enum.reduce(0, fn(x, acc) -> x + acc end)
23

iex> range = 1..999
1..999

iex> range |> Enum.filter(fn(x) -> rem(x, 3) == 0 || rem(x, 5) == 0 end) |> Enum.reduce(0, fn(x, acc) -> x + acc end)
233168
```

