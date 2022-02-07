defmodule PingPong do
  @doc """
  Spawn Processes. Send and Receive messages between of them.

  ## Examples
    iex> ping = spawn(PingPong, :loop, [{0, :ping}])
    0 - ping
    #PID<0.150.0>

    iex> pong = spawn(PingPong, :loop, [{0, :pong}])
    0 - pong
    #PID<0.152.0>

    iex> Process.alive?(ping)
    true

    iex> Process.alive?(pong)
    true

    iex> first = spawn(PingPong, :loop, [{1, :ping}])
    true

    iex> second = spawn(PingPong, :loop, [{1, :pong}])
    true

    iex> Process.register(second, :pong)
    true

    iex> send(ping, {:msg, pong})
    {:msg, #PID<0.152.0>}
    1 - ping
    1 - pong
    2 - ping
    2 - pong
    3 - ping
    3 - pong

    iex> send(ping, {:stop})
    {:stop}
    6 - pong

    iex> Process.alive?(ping)
    false

    iex> Process.alive?(pong)
    true

    iex> send(pong, {:stop})
    {:stop}

    iex> Process.alive?(pong)
    false


  """
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
