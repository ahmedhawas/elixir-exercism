defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> String.downcase
    |> String.replace(~r/_/, " ")
    |> String.replace(~r/[!@#$%^&*()=+|;':",.<>?']/, "")
    |> String.split
    |> count_words
  end

  defp count_words(words) when is_list(words) do
    Enum.reduce(words, %{}, &update_count/2)
    # equivalent to
    # Enum.reduce words, %{}, fn word, acc ->
    #   update_count(word, acc)
    # end
  end

  defp update_count(word, acc) do
    Map.update acc, word, 1, &(&1 + 1)
  end
end
