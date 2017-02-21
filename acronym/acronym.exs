defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    String.split(string, ~r/[A-Z][a-z]+/, include_captures: true, trim: true)
    |> Enum.join(" ")
    |> String.split(~r/[^\p{L}0-9]+/, trim: true)
    |> capitalize_all
    |> generate_acronym("")
  end

  def capitalize_all(word_list) do
    Enum.reduce word_list, [], fn word, acc ->
      acc ++ [String.capitalize(word)]
    end
  end

  def generate_acronym([word | rest_of_words], accronym) do
    result = accronym <> String.first(word)
    generate_acronym(rest_of_words, String.trim(result))
  end

  def generate_acronym([], accronym) do
    accronym
  end
end
