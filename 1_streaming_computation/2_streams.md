# Streams
- Are Lazy Enumerables
- Composing streams creates recipes rather than immediate results
- Useful for processing large or infinite data sets efficiently

#
## [Word counting](words/lib/words.ex)
> Given a list of lines, count the accurrence of all words.

1. Split lines into words
2. Normalize words
3. Count words

```elixir
defmodule Words do
  def count(lines) do
    lines
    |> Enum.flat_map(&String.split/1)
    |> Enum.map(&String.downcase/1)
    |> Enum.map(&remove_special_chars/1)
    |> Enum.reduce(%{}, &count_word/2)
  end

  defp remove_special_chars(string) do
    string
    |> String.normalize(:nfd)
    |> String.replace(~r/[^A-z\s]/u, "")
  end

  defp count_word(word, map) do
    Map.update(map, word, 1, &(&1 + 1))
  end
end

iex> Words.count(["a", "a a a b", "b a"])  
%{"a" => 5, "b" => 2}

iex(3)> Words.count(File.stream!("big_file.txt"))  
%{"alot" => 5, "words" => 2}
```
> 150 mb jump on memory


### It uses too much memory!
### Because of intermediate representations
- Each step of the computation outputs a copy of the enumerable
- With big data sets, this becomes unfeasible

## Refactoring
```elixir
defmodule Words do
  def count(lines, mod) do
    lines
    |> mod.flat_map(&String.split/1)
    |> mod.map(&String.downcase/1)
    |> mod.map(&remove_special_chars/1)
    |> Enum.reduce(%{}, &count_word/2)
  end

  defp remove_special_chars(string) do
    string
    |> String.normalize(:nfd)
    |> String.replace(~r/[^A-z\s]/u, "")
  end

  defp count_word(word, map) do
    Map.update(map, word, 1, &(&1 + 1))
  end
end

iex> Words.count(File.stream!("big_file.txt"), Stream)  
%{"alot" => 5, "words" => 2}
```
> 10 mb jump on memory
  
