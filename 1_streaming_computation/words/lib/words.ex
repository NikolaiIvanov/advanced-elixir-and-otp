defmodule Words do
  @doc ~S"""
  Given a list of lines, count the accurrence of all words.

  ## Examples
    iex> Words.count(["a", "a a a", "b a"], Stream)
    %{"a" => 5, "b" => 1}

  """
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
