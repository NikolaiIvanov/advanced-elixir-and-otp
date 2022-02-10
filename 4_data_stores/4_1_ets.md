# Data Stores

## ETS - Erlang Term Storage
* In-Memory datastore
* Owned by a process
* Allows storage of any Elixir data type
* Dissappear once the owner process dies

### Example - Book Catalog

Title - String

Rating [0-10] - Integer

Total pages - Integer

`{:title, 7, 320}`
```elixir
iex> table = :ets.new(:books, [:set])
#Reference<0.1593898435.1850343428.235077>

iex> table |> :ets.insert({:fairy_tales, 9, 328})
true

iex> table |> :ets.insert({:steve_jobs, 10, 222})
true

iex> table |> :ets.lookup(:steve_jobs)
[{:steve_jobs, 10, 222}]

iex> table |> :ets.lookup(:steve_job) 
[]

iex> table |> :ets.delete(:fairy_tales)
true

iex> table |> :ets.lookup(:fairy_tales)
[]

iex> table |> :ets.delete()            
true

iex> table |> :ets.lookup(:steve_jobs) 
** (ArgumentError) errors were found at the given arguments:

  * 1st argument: the table identifier does not refer to an existing ETS table

```

#
## ETS - Types
### The Type governs the way in which we can store and access terms.

|| Set | Ordered Set| Bag | Duplicate Bag |
|:--------------------|:-:|:-:|:-:|:-:|
| Duplicate keys?     | x | x | ✓ | ✓ |
| Duplicate key-value?| x | x | x | ✓ |
| Ordered?            | x | ✓ | x | x |

#
## ETS - Access
### The Access type governs who can access the table.

|| Public | Protected | Private |
|:------|:---:|:---:|:---:|
| Owner | R/W | R/W | R/W |
| Others| R/W | R   |  -  |

#
## Advanced Lookups
* `match/2`
* `select/2`
* `fun2ms/1`

### match/2

```elixir
iex> table = :ets.new(:books, [:set])              
#Reference<0.445956530.2929328132.164735>

iex> table |> :ets.insert({:fairy_tale, 10, 329})  
true

iex> table |> :ets.insert({:horror_novel, 9, 128}) 
true

iex> table |> :ets.insert({:best_seller, 9, 542}) 
true

iex> table |> :ets.insert({:mediocre_story, 2, 48})
true

iex> table |> :ets.insert({:fable, 5, 120})
true

iex> table |> :ets.match({:"$1", 9, :"$2"})
[[:best_seller, 542], [:horror_novel, 128]]

iex> table |> :ets.match({:"$2", 9, :"$1"})
[[542, :best_seller], [128, :horror_novel]]

iex> table |> :ets.match({:"$1", 9, :"_"}) 
[[:best_seller], [:horror_novel]]
```

### select/2
```elixir
iex> table |> :ets.select([{{:"$1", 9, :"$3"}, [], [:"$1"]}])
[:best_seller, :horror_novel]

iex> table |> :ets.select([{{:"$1", 9, :"$3"}, [], [:"$$"]}])
[[:best_seller, 542], [:horror_novel, 128]]

iex> table |> :ets.select([{{:"$1", 9, :"$3"}, [], [:"$_"]}])
[{:best_seller, 9, 542}, {:horror_novel, 9, 128}]

iex> table |> :ets.select([{{:"$1", :"$2", :"$3"}, [{:>=, :"$2", 9}], [:"$_"]}])
[{:fairy_tale, 10, 329}, {:best_seller, 9, 542}, {:horror_novel, 9, 128}]

```

### fun2ms/1

```elixir
iex> expression = :ets.fun2ms(fn {title, rating, pages} = book when rating >= 9 -> book end)
[{{:"$1", :"$2", :"$3"}, [{:>=, :"$2", 9}], [:"$_"]}]

iex> table |> :ets.select(expression)
[{:fairy_tale, 10, 329}, {:best_seller, 9, 542}, {:horror_novel, 9, 128}]

```