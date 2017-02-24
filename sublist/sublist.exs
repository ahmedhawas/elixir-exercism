defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a === b, do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist
  def compare(a, a), do: :equal
  def compare(a, b) do
    cond do
      is_sublist?(a, b) -> :sublist
      is_sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp is_sublist?(a, b) when length(a) > length(b), do: false
  defp is_sublist?(a, b = [_ | tail_b]) do
    if is_at_head_of?(a, b) do
      true
    else
      is_sublist?(a, tail_b)
    end
  end

  defp is_at_head_of?([], _), do: true
  defp is_at_head_of?([a|tail_a], [a|tail_b]) do
    tail_a
    |> is_at_head_of?(tail_b)
  end
  defp is_at_head_of?(_, _), do: false
end
