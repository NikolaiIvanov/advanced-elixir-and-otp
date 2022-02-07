# Messaging
## Process and Messaging
| Process ID    | spawn | Process ID    |
|:-------------:|:-----:|:-------------:|
| #PID<0.110.0> | spawn | #PID<0.114.0> | 

> One Process can spawn other Process

> Process are isolated blackbox.

`#PID<0.110.0>` send(pid, msg) ---> receive(msg) `#PID<0.114.0>`

#
## Ping - Pong
### Two processes, passing messages back and forth indefinitely. One is ping, the other is pong.

```elixir
defmodule Messager do
  def loop({num_iterations, name}) do
    IO.puts("#{num_iterations} - #{name}")

    receive do
      {:msg, from} -> pass_msg(from); loop({num_iterations + 1, name})
      {:stop} -> stop()
    end
  end

  defp pass_msg(from) do
    :timer.sleep(1500)
    send(from, {:msg, self()})
  end

  defp stop() do
    :ok
  end
end

iex> sendr = spawn(Messager, :loop, [{0, :sendr}])
0 - sendr
#PID<0.152.0>

iex> rsvr = spawn(Messager, :loop, [{0, :rsvr}])  
0 - rsvr
#PID<0.154.0>

iex> Process.alive?(sendr)
true

iex> Process.alive?(rsvr) 
true

iex> send(sendr, {:msg, rsvr})                    
{:msg, #PID<0.152.0>}
1 - sendr
1 - rsvr
2 - sendr
2 - rsvr

iex> send(sendr, {:stop})
{:stop}
11 - sendr
11 - rsvr

iex> Process.alive?(sendr)    
false

iex> Process.alive?(rsvr)     
true

iex> send(rsvr, {:stop})  
{:stop}

iex> Process.alive?(rsvr) 
false

```

#
## Named Processes

`Process.register/2`
> We can give unique names to the processes, which makes it easier to call them without a reference.

```elixir
iex> sendr = spawn(Messager, :loop, [{0, :sendr}])
0 - sendr
#PID<0.150.0>

iex> rsvr = spawn(Messager, :loop, [{0, :rsvr}])  
0 - rsvr
#PID<0.152.0>

iex> Process.register(rsvr, :second)              
true

iex> send(sendr, {:msg, :second})                 
{:msg, :second}
1 - sendr
1 - rsvr
```