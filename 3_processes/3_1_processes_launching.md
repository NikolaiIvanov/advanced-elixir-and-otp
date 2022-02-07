# What is Process
> Everything in Elixir runs as a Process!

> A Language construct for executing code asynchonously and in isolation.

| Process ||
| :-----: | :----: |
| spawn/1 | self/0 |

```elixir
iex> self()                             
#PID<0.110.0>

iex> me = self()
#PID<0.110.0>

iex> Process.alive?(me)
true

iex> other = spawn(fn -> IO.puts("Hello") end)
Hello
#PID<0.114.0>

iex> Process.alive?(other)                    
false
```

## Process tree

||||||
| :-----------: | :-: | :-----------: |:-: |:------------: |
| #PID<0.110.0> | →   | #PID<0.111.0> |  → | #PID<0.113.0> |
|               | →   | #PID<0.112.0> |  → | #PID<0.114.0> |
> Spawn processes without any kind of liveness controll - useless, if one of the processess on the tree fail, other processes dont know about that failure unless parent process actively checks for the liveness of the child process

## Let it Crash
### Linking Processes
> Making processes depend on one another. If the child crashes, the parent will also crash.

`spawn_link/1`

```elixir
iex> self()
#PID<0.127.0>

iex> pid = spawn_link(fn -> raise "Boom" end)
** (EXIT from #PID<0.127.0>) shell process exited with reason: an exception was raised:
    ** (RuntimeError) Boom

11:43:55.233 [error] Process #PID<0.130.0> raised an exception
** (RuntimeError) Boom
 
iex> self()                                  
#PID<0.131.0>
```