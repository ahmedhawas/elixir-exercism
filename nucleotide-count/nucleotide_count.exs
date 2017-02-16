defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    find_nucleotide(strand, nucleotide)
    |> count_character_list
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    Enum.reduce @nucleotides, %{}, fn nucleotide, memo ->
      Map.put memo, nucleotide, count(strand, nucleotide)
    end
  end

  defp find_nucleotide(strand, nucleotide) do
    Enum.filter(strand, fn x -> x === nucleotide end)
  end

  defp count_character_list(list) do
    length(list)
  end
end
