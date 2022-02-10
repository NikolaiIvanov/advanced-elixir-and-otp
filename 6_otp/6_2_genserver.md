# GenServer

## Public API
Hide the implementation (GenServer) from the calling parties

## Callbacks
Implement the GenServer behavior and business logic

## Setup → init/1


| Message Handling |
| :--------------: |
| handle_call/3 |
| handle_cast/2 |
| handle_info/2 |

| Exceptional Cases |
| :---------------: |
| terminate/2 |
| code_change/3 |

#
## Arguments → init/1 → {:ok, state}


| message, from, state | message, state|
| :-------: | :----:|
| ↓ | ↓ |
| handle_call/3 | handle_cast/2 |
| ↓ | ↓ |
| {:reply, resp, state} | {:noreply, state} |
| Sync | Async |

```elixir
defmodule Counter do
  use GenServer
  
  # <-- Public API -->
  def start_link() do
    GenServer.start_link(__MODULE__, 0)
  end

  def inc(server, x) do
    GenServer.cast(server, {:inc, x})
  end

  def dec(server, x) do
    GenServer.cast(server, {:dec, x})
  end

  def get(server) do
    GenServer.call(server, {:get})
  end
  # <-- END -->

  # <-- Callbacks -->
  def handle_cast({:inc, x}, counter) do
    {:noreply, counter + x}
  end

  def handle_cast({:dec, x}, counter) do
    {:noreply, counter - x}
  end

  def handle_call({:get}, _from, counter) do
    {:reply, counter, counter}
  end
  # <-- END -->
end
```
