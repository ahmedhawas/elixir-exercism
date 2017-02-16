defmodule Bob do
  def hey(input) do
    cond do
      String.strip(input) === "" -> "Fine. Be that way!"
      String.match?(input, ~r/\?\Z/) -> "Sure."
      upper_case_is_greater_than_lower_case?(input) -> "Whoa, chill out!"
      input === "УХОДИ" -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp upper_case_is_greater_than_lower_case?(input) do
    upper_case = Regex.run ~r/^(.*?[A-Z])/, input
    lower_case = Regex.run ~r/^(.*?[a-z])/, input
    upper_case >= lower_case && upper_case
  end
end

# someone else's solution
# defmodule Bob do
#   def hey(input) do
#     cond do
#         String.ends_with? input, "?" -> "Sure."
#         String.trim(input) === "" -> "Fine. Be that way!"
#         String.upcase(input) == String.downcase(input) -> "Whatever."
#         String.upcase(input) === input -> "Whoa, chill out!"
#         true -> "Whatever."
#     end
#   end
# end
