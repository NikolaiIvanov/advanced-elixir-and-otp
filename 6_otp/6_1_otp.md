# OTP - Open Telecom Platform

| Framework | Design Patterns |
| :-------: | :-------------: |
| A structure for building `Applications` and having them operate with each other | A set of `Behaviors` that implement common generic usage patterns |

#
### Building Blocks for Distributed, Scalable, and Robust Applications

| Elixir Toolset | Erlang OTP | Behaviours |
| :-: | :-: | :-:|
| Mix | ETS | GenServer |
| Application | Mnesia ||
||Crypto|| 

```elixir
defmodule Deck do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def take_card() do
    GenServer.call(__MODULE__, {:take_card})
  end

  def init(_) do
    {:ok, Enum.shuffle(1..52)}
  end

  def handle_call({:take_card}, _from, [card|deck]) do
    {:reply, card, deck}
  end
end
```

```elixir
iex> Deck.start_link
{:ok, #PID<0.162.0>}

iex> 1..51 |> Enum.each(fn(_) -> IO.puts(Deck.take_card) end)
37
3
14
47
44
...

iex> Deck.take_card
46

iex> Deck.take_card
xx:xx:xx.xxx [error] GenServer Deck terminating

iex> Deck.start_link
{:ok, #PID<0.170.0>}

iex> Deck.take_card 
29

iex> Deck.take_card
28

iex> Deck.take_card
15

```