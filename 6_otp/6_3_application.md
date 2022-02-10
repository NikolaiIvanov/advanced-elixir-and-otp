# Application
## Logical group of processes

```elixir
# lib/application.ex
defmodule Deck.Application do
  use Application

  def start(_type, _args) do
    Deck.start_link()
  end
end

# mix.exs
def application do
  [
    extra_applications: [:logger],
    mod: {Deck.Application, []}
  ]
end

# lib/deck.ex
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

iex> Deck.take_card
21

iex> Deck.take_card
5

```