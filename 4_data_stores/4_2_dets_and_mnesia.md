# Data Stores

## DETS - Disk-based Erlang Term Storage
* Persistent file-based data store
* Tablesaccessible by name
* API campatible with ETS
* Needs to be closed properly
* MUCH slower than ETS

```elixir
iex> {:ok, table} = :dets.open_file(:books, [type: :set])
{:ok, :books}

iex> table |> :dets.insert({:fable, 5, 120})
:ok

iex> table |> :dets.insert({:novel, 7, 210})
:ok

iex> table |> :dets.lookup(:fable)          
[{:fable, 5, 120}]

iex> table |> :dets.close()       
:ok

iex> :erlang.halt

iex> {:ok, table} = :dets.open_file(:books, [type: :set])
{:ok, :books}

iex> table |> :dets.lookup(:novel)
[{:novel, 7, 210}]
```

#
## Mnesia - The distributed data store
* Disk + memory consistent persistency model
* Location transparency
* Transactions
* Fast queries

```elixir
iex> :mnesia.transaction(fn ->
...> :mnesia.write({Book, :fairy_tale, 9, 329})
...> :mnesia.write({Book, :novel, 10, 128})
...> :mnesia.write({Book, :fable, 5, 120})
...> end)
{:atomic, :ok}

iex> :mnesia.transaction(fn -> :mnesia.read(Book, :fairy_tale) end)
{:atomic, [{Book, :fairy_tale, 9, 329}]}


```
