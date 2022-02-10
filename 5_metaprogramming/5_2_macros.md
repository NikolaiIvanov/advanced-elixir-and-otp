# Macros
> The Elixir-provided mechanizm to expand the language with new constructs.

| quoted expression |
|:-----------------:|
|   ↓ defmacro ↓    |
| quoted expression |

```elixir
defmodule AsyncTask do
  defmacro __using__(_opts) do
    quote do
      import AsyncTask

      @async false
      @timeout 10_000
      @timeout_response nil
    end
  end

  defmacro task(header, do: body) do
    quote do
      def unquote(header) do
        case @async do
          true -> spawn(fn -> unquote(body) end)
          _ ->
            caller = self()
            spawn(fn -> send(caller, unquote(body)) end)

            receive do
              message -> message
            after
              @timeout -> @timeout_response
            end
        end
      end
    end
  end
end
```
```elixir
defmodule Sample do
  use AsyncTask

  @timeout 1000
  @timeout_response "Hello, Unknown!"

  task hello(name, timer \\ 10_000) do
    :timer.sleep(timer)

    "Hello, #{name}!"
  end
end
```

```elixir
iex> Sample.hello("John Doe", 500) 
"Hello, John Doe!"

iex> Sample.hello("John Doe", 5000)
"Hello, Unknown!"

```